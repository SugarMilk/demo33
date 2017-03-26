// GFURLConnectionOperation.m
//
// Copyright (c) 2013-2014 GFNetworking (http://afnetworking.com)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "GFURLConnectionOperation.h"

#if defined(__IPHONE_OS_VERSION_MIN_REQUIRED)
#import <UIKit/UIKit.h>
#endif

#if !__has_feature(objc_arc)
#error GFNetworking must be built with ARC.
// You can turn on ARC for only GFNetworking files by adding -fobjc-arc to the build phase for each of its files.
#endif

typedef NS_ENUM(NSInteger, GFOperationState) {
    GFOperationPausedState      = -1,
    GFOperationReadyState       = 1,
    GFOperationExecutingState   = 2,
    GFOperationFinishedState    = 3,
};

#if defined(__IPHONE_OS_VERSION_MIN_REQUIRED) && !defined(GF_APP_EXTENSIONS)
typedef UIBackgroundTaskIdentifier GFBackgroundTaskIdentifier;
#else
typedef id GFBackgroundTaskIdentifier;
#endif

static dispatch_group_t url_request_operation_completion_group() {
    static dispatch_group_t gf_url_request_operation_completion_group;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        gf_url_request_operation_completion_group = dispatch_group_create();
    });

    return gf_url_request_operation_completion_group;
}

static dispatch_queue_t url_request_operation_completion_queue() {
    static dispatch_queue_t gf_url_request_operation_completion_queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        gf_url_request_operation_completion_queue = dispatch_queue_create("com.alamofire.networking.operation.queue", DISPATCH_QUEUE_CONCURRENT );
    });

    return gf_url_request_operation_completion_queue;
}

static NSString * const kGFNetworkingLockName = @"com.alamofire.networking.operation.lock";

NSString * const GFNetworkingOperationDidStartNotification = @"com.alamofire.networking.operation.start";
NSString * const GFNetworkingOperationDidFinishNotification = @"com.alamofire.networking.operation.finish";

typedef void (^GFURLConnectionOperationProgressBlock)(NSUInteger bytes, long long totalBytes, long long totalBytesExpected);
typedef void (^GFURLConnectionOperationAuthenticationChallengeBlock)(NSURLConnection *connection, NSURLAuthenticationChallenge *challenge);
typedef NSCachedURLResponse * (^GFURLConnectionOperationCacheResponseBlock)(NSURLConnection *connection, NSCachedURLResponse *cachedResponse);
typedef NSURLRequest * (^GFURLConnectionOperationRedirectResponseBlock)(NSURLConnection *connection, NSURLRequest *request, NSURLResponse *redirectResponse);

static inline NSString * GFKeyPathFromOperationState(GFOperationState state) {
    switch (state) {
        case GFOperationReadyState:
            return @"isReady";
        case GFOperationExecutingState:
            return @"isExecuting";
        case GFOperationFinishedState:
            return @"isFinished";
        case GFOperationPausedState:
            return @"isPaused";
        default: {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunreachable-code"
            return @"state";
#pragma clang diagnostic pop
        }
    }
}

static inline BOOL GFStateTransitionIsValid(GFOperationState fromState, GFOperationState toState, BOOL isCancelled) {
    switch (fromState) {
        case GFOperationReadyState:
            switch (toState) {
                case GFOperationPausedState:
                case GFOperationExecutingState:
                    return YES;
                case GFOperationFinishedState:
                    return isCancelled;
                default:
                    return NO;
            }
        case GFOperationExecutingState:
            switch (toState) {
                case GFOperationPausedState:
                case GFOperationFinishedState:
                    return YES;
                default:
                    return NO;
            }
        case GFOperationFinishedState:
            return NO;
        case GFOperationPausedState:
            return toState == GFOperationReadyState;
        default: {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunreachable-code"
            switch (toState) {
                case GFOperationPausedState:
                case GFOperationReadyState:
                case GFOperationExecutingState:
                case GFOperationFinishedState:
                    return YES;
                default:
                    return NO;
            }
        }
#pragma clang diagnostic pop
    }
}

@interface GFURLConnectionOperation ()
@property (readwrite, nonatomic, assign) GFOperationState state;
@property (readwrite, nonatomic, strong) NSRecursiveLock *lock;
@property (readwrite, nonatomic, strong) NSURLConnection *connection;
@property (readwrite, nonatomic, strong) NSURLRequest *request;
@property (readwrite, nonatomic, strong) NSURLResponse *response;
@property (readwrite, nonatomic, strong) NSError *error;
@property (readwrite, nonatomic, strong) NSData *responseData;
@property (readwrite, nonatomic, copy) NSString *responseString;
@property (readwrite, nonatomic, assign) NSStringEncoding responseStringEncoding;
@property (readwrite, nonatomic, assign) long long totalBytesRead;
@property (readwrite, nonatomic, assign) GFBackgroundTaskIdentifier backgroundTaskIdentifier;
@property (readwrite, nonatomic, copy) GFURLConnectionOperationProgressBlock uploadProgress;
@property (readwrite, nonatomic, copy) GFURLConnectionOperationProgressBlock downloadProgress;
@property (readwrite, nonatomic, copy) GFURLConnectionOperationAuthenticationChallengeBlock authenticationChallenge;
@property (readwrite, nonatomic, copy) GFURLConnectionOperationCacheResponseBlock cacheResponse;
@property (readwrite, nonatomic, copy) GFURLConnectionOperationRedirectResponseBlock redirectResponse;

- (void)operationDidStart;
- (void)finish;
- (void)cancelConnection;
@end

@implementation GFURLConnectionOperation
@synthesize outputStream = _outputStream;

+ (void)networkRequestThreadEntryPoint:(id)__unused object {
    @autoreleasepool {
        [[NSThread currentThread] setName:@"GFNetworking"];

        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        [runLoop addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
        [runLoop run];
    }
}

+ (NSThread *)networkRequestThread {
    static NSThread *_networkRequestThread = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _networkRequestThread = [[NSThread alloc] initWithTarget:self selector:@selector(networkRequestThreadEntryPoint:) object:nil];
        [_networkRequestThread start];
    });
    
    return _networkRequestThread;
}

- (instancetype)initWithRequest:(NSURLRequest *)urlRequest {
    NSParameterAssert(urlRequest);

    self = [super init];
    if (!self) {
		return nil;
    }

    _state = GFOperationReadyState;

    self.lock = [[NSRecursiveLock alloc] init];
    self.lock.name = kGFNetworkingLockName;
    
    self.runLoopModes = [NSSet setWithObject:NSRunLoopCommonModes];
    
    self.request = urlRequest;
    
    self.shouldUseCredentialStorage = YES;

    self.securityPolicy = [GFSecurityPolicy defaultPolicy];

    return self;
}

- (void)dealloc {
    if (_outputStream) {
        [_outputStream close];
        _outputStream = nil;
    }
    
#if defined(__IPHONE_OS_VERSION_MIN_REQUIRED) && !defined(GF_APP_EXTENSIONS)
    if (_backgroundTaskIdentifier) {
        [[UIApplication sharedApplication] endBackgroundTask:_backgroundTaskIdentifier];
        _backgroundTaskIdentifier = UIBackgroundTaskInvalid;
    }
#endif
}

#pragma mark -

- (void)setResponseData:(NSData *)responseData {
    [self.lock lock];
    if (!responseData) {
        _responseData = nil;
    } else {
        _responseData = [NSData dataWithBytes:responseData.bytes length:responseData.length];
    }
    [self.lock unlock];
}

- (NSString *)responseString {
    [self.lock lock];
    if (!_responseString && self.response && self.responseData) {
        self.responseString = [[NSString alloc] initWithData:self.responseData encoding:self.responseStringEncoding];
    }
    [self.lock unlock];

    return _responseString;
}

- (NSStringEncoding)responseStringEncoding {
    [self.lock lock];
    if (!_responseStringEncoding && self.response) {
        NSStringEncoding stringEncoding = NSUTF8StringEncoding;
        if (self.response.textEncodingName) {
            CFStringEncoding IANAEncoding = CFStringConvertIANACharSetNameToEncoding((__bridge CFStringRef)self.response.textEncodingName);
            if (IANAEncoding != kCFStringEncodingInvalidId) {
                stringEncoding = CFStringConvertEncodingToNSStringEncoding(IANAEncoding);
            }
        }

        self.responseStringEncoding = stringEncoding;
    }
    [self.lock unlock];

    return _responseStringEncoding;
}

- (NSInputStream *)inputStream {
    return self.request.HTTPBodyStream;
}

- (void)setInputStream:(NSInputStream *)inputStream {
    NSMutableURLRequest *mutableRequest = [self.request mutableCopy];
    mutableRequest.HTTPBodyStream = inputStream;
    self.request = mutableRequest;
}

- (NSOutputStream *)outputStream {
    if (!_outputStream) {
        self.outputStream = [NSOutputStream outputStreamToMemory];
    }

    return _outputStream;
}

- (void)setOutputStream:(NSOutputStream *)outputStream {
    [self.lock lock];
    if (outputStream != _outputStream) {
        if (_outputStream) {
            [_outputStream close];
        }

        _outputStream = outputStream;
    }
    [self.lock unlock];
}

#if defined(__IPHONE_OS_VERSION_MIN_REQUIRED) && !defined(GF_APP_EXTENSIONS)
- (void)setShouldExecuteAsBackgroundTaskWithExpirationHandler:(void (^)(void))handler {
    [self.lock lock];
    if (!self.backgroundTaskIdentifier) {
        UIApplication *application = [UIApplication sharedApplication];
        __weak __typeof(self)weakSelf = self;
        self.backgroundTaskIdentifier = [application beginBackgroundTaskWithExpirationHandler:^{
            __strong __typeof(weakSelf)strongSelf = weakSelf;
            
            if (handler) {
                handler();
            }
            
            if (strongSelf) {
                [strongSelf cancel];
                
                [application endBackgroundTask:strongSelf.backgroundTaskIdentifier];
                strongSelf.backgroundTaskIdentifier = UIBackgroundTaskInvalid;
            }
        }];
    }
    [self.lock unlock];
}
#endif

#pragma mark -

- (void)setState:(GFOperationState)state {
    if (!GFStateTransitionIsValid(self.state, state, [self isCancelled])) {
        return;
    }
    
    [self.lock lock];
    NSString *oldStateKey = GFKeyPathFromOperationState(self.state);
    NSString *newStateKey = GFKeyPathFromOperationState(state);
    
    [self willChangeValueForKey:newStateKey];
    [self willChangeValueForKey:oldStateKey];
    _state = state;
    [self didChangeValueForKey:oldStateKey];
    [self didChangeValueForKey:newStateKey];
    [self.lock unlock];
}

- (void)pause {
    if ([self isPaused] || [self isFinished] || [self isCancelled]) {
        return;
    }
    
    [self.lock lock];
    if ([self isExecuting]) {
        [self performSelector:@selector(operationDidPause) onThread:[[self class] networkRequestThread] withObject:nil waitUntilDone:NO modes:[self.runLoopModes allObjects]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
            [notificationCenter postNotificationName:GFNetworkingOperationDidFinishNotification object:self];
        });
    }
    
    self.state = GFOperationPausedState;
    [self.lock unlock];
}

- (void)operationDidPause {
    [self.lock lock];
    [self.connection cancel];
    [self.lock unlock];
}

- (BOOL)isPaused {
    return self.state == GFOperationPausedState;
}

- (void)resume {
    if (![self isPaused]) {
        return;
    }
    
    [self.lock lock];
    self.state = GFOperationReadyState;
    
    [self start];
    [self.lock unlock];
}

#pragma mark -

- (void)setUploadProgressBlock:(void (^)(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite))block {
    self.uploadProgress = block;
}

- (void)setDownloadProgressBlock:(void (^)(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead))block {
    self.downloadProgress = block;
}

- (void)setWillSendRequestForAuthenticationChallengeBlock:(void (^)(NSURLConnection *connection, NSURLAuthenticationChallenge *challenge))block {
    self.authenticationChallenge = block;
}

- (void)setCacheResponseBlock:(NSCachedURLResponse * (^)(NSURLConnection *connection, NSCachedURLResponse *cachedResponse))block {
    self.cacheResponse = block;
}

- (void)setRedirectResponseBlock:(NSURLRequest * (^)(NSURLConnection *connection, NSURLRequest *request, NSURLResponse *redirectResponse))block {
    self.redirectResponse = block;
}

#pragma mark - NSOperation

- (void)setCompletionBlock:(void (^)(void))block {
    [self.lock lock];
    if (!block) {
        [super setCompletionBlock:nil];
    } else {
        __weak __typeof(self)weakSelf = self;
        [super setCompletionBlock:^ {
            __strong __typeof(weakSelf)strongSelf = weakSelf;

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgnu"
            dispatch_group_t group = strongSelf.completionGroup ?: url_request_operation_completion_group();
            dispatch_queue_t queue = strongSelf.completionQueue ?: dispatch_get_main_queue();
#pragma clang diagnostic pop

            dispatch_group_async(group, queue, ^{
                block();
            });

            dispatch_group_notify(group, url_request_operation_completion_queue(), ^{
                [strongSelf setCompletionBlock:nil];
            });
        }];
    }
    [self.lock unlock];
}

- (BOOL)isReady {
    return self.state == GFOperationReadyState && [super isReady];
}

- (BOOL)isExecuting {
    return self.state == GFOperationExecutingState;
}

- (BOOL)isFinished {
    return self.state == GFOperationFinishedState;
}

- (BOOL)isConcurrent {
    return YES;
}

- (void)start {
    [self.lock lock];
    if ([self isCancelled]) {
        [self performSelector:@selector(cancelConnection) onThread:[[self class] networkRequestThread] withObject:nil waitUntilDone:NO modes:[self.runLoopModes allObjects]];
    } else if ([self isReady]) {
        self.state = GFOperationExecutingState;
        
        [self performSelector:@selector(operationDidStart) onThread:[[self class] networkRequestThread] withObject:nil waitUntilDone:NO modes:[self.runLoopModes allObjects]];
    }
    [self.lock unlock];
}

- (void)operationDidStart {
    [self.lock lock];
    if (![self isCancelled]) {
        self.connection = [[NSURLConnection alloc] initWithRequest:self.request delegate:self startImmediately:NO];
        
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        for (NSString *runLoopMode in self.runLoopModes) {
            [self.connection scheduleInRunLoop:runLoop forMode:runLoopMode];
            [self.outputStream scheduleInRunLoop:runLoop forMode:runLoopMode];
        }
        
        [self.outputStream open];
        [self.connection start];
    }
    [self.lock unlock];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:GFNetworkingOperationDidStartNotification object:self];
    });
}

- (void)finish {
    [self.lock lock];
    self.state = GFOperationFinishedState;
    [self.lock unlock];

    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:GFNetworkingOperationDidFinishNotification object:self];
    });
}

- (void)cancel {
    [self.lock lock];
    if (![self isFinished] && ![self isCancelled]) {
        [super cancel];

        if ([self isExecuting]) {
            [self performSelector:@selector(cancelConnection) onThread:[[self class] networkRequestThread] withObject:nil waitUntilDone:NO modes:[self.runLoopModes allObjects]];
        }
    }
    [self.lock unlock];
}

- (void)cancelConnection {
    NSDictionary *userInfo = nil;
    if ([self.request URL]) {
        userInfo = [NSDictionary dictionaryWithObject:[self.request URL] forKey:NSURLErrorFailingURLErrorKey];
    }
    NSError *error = [NSError errorWithDomain:NSURLErrorDomain code:NSURLErrorCancelled userInfo:userInfo];

    if (![self isFinished]) {
        if (self.connection) {
            [self.connection cancel];
            [self performSelector:@selector(connection:didFailWithError:) withObject:self.connection withObject:error];
        } else {
            // Accomodate race condition where `self.connection` has not yet been set before cancellation
            self.error = error;
            [self finish];
        }
    }
}

#pragma mark -

+ (NSArray *)batchOfRequestOperations:(NSArray *)operations
                        progressBlock:(void (^)(NSUInteger numberOfFinishedOperations, NSUInteger totalNumberOfOperations))progressBlock
                      completionBlock:(void (^)(NSArray *operations))completionBlock
{
    if (!operations || [operations count] == 0) {
        return @[[NSBlockOperation blockOperationWithBlock:^{
            dispatch_async(dispatch_get_main_queue(), ^{
                if (completionBlock) {
                    completionBlock(@[]);
                }
            });
        }]];
    }

    __block dispatch_group_t group = dispatch_group_create();
    NSBlockOperation *batchedOperation = [NSBlockOperation blockOperationWithBlock:^{
        dispatch_group_notify(group, dispatch_get_main_queue(), ^{
            if (completionBlock) {
                completionBlock(operations);
            }
        });
    }];

    for (GFURLConnectionOperation *operation in operations) {
        operation.completionGroup = group;
        void (^originalCompletionBlock)(void) = [operation.completionBlock copy];
        __weak __typeof(operation)weakOperation = operation;
        operation.completionBlock = ^{
            __strong __typeof(weakOperation)strongOperation = weakOperation;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgnu"
            dispatch_queue_t queue = strongOperation.completionQueue ?: dispatch_get_main_queue();
#pragma clang diagnostic pop
            dispatch_group_async(group, queue, ^{
                if (originalCompletionBlock) {
                    originalCompletionBlock();
                }

                NSUInteger numberOfFinishedOperations = [[operations indexesOfObjectsPassingTest:^BOOL(id op, NSUInteger __unused idx,  BOOL __unused *stop) {
                    return [op isFinished];
                }] count];

                if (progressBlock) {
                    progressBlock(numberOfFinishedOperations, [operations count]);
                }

                dispatch_group_leave(group);
            });
        };

        dispatch_group_enter(group);
        [batchedOperation addDependency:operation];
    }

    return [operations arrayByAddingObject:batchedOperation];
}

#pragma mark - NSObject

- (NSString *)description {
    [self.lock lock];
    NSString *description = [NSString stringWithFormat:@"<%@: %p, state: %@, cancelled: %@ request: %@, response: %@>", NSStringFromClass([self class]), self, GFKeyPathFromOperationState(self.state), ([self isCancelled] ? @"YES" : @"NO"), self.request, self.response];
    [self.lock unlock];
    return description;
}

#pragma mark - NSURLConnectionDelegate

- (void)connection:(NSURLConnection *)connection
willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    if (self.authenticationChallenge) {
        self.authenticationChallenge(connection, challenge);
        return;
    }

    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        if ([self.securityPolicy evaluateServerTrust:challenge.protectionSpace.serverTrust forDomain:challenge.protectionSpace.host]) {
            NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
            [[challenge sender] useCredential:credential forAuthenticationChallenge:challenge];
        } else {
            [[challenge sender] cancelAuthenticationChallenge:challenge];
        }
    } else {
        if ([challenge previousFailureCount] == 0) {
            if (self.credential) {
                [[challenge sender] useCredential:self.credential forAuthenticationChallenge:challenge];
            } else {
                [[challenge sender] continueWithoutCredentialForAuthenticationChallenge:challenge];
            }
        } else {
            [[challenge sender] continueWithoutCredentialForAuthenticationChallenge:challenge];
        }
    }
}

- (BOOL)connectionShouldUseCredentialStorage:(NSURLConnection __unused *)connection {
    return self.shouldUseCredentialStorage;
}

- (NSURLRequest *)connection:(NSURLConnection *)connection
             willSendRequest:(NSURLRequest *)request
            redirectResponse:(NSURLResponse *)redirectResponse
{
    if (self.redirectResponse) {
        return self.redirectResponse(connection, request, redirectResponse);
    } else {
        return request;
    }
}

- (void)connection:(NSURLConnection __unused *)connection
   didSendBodyData:(NSInteger)bytesWritten
 totalBytesWritten:(NSInteger)totalBytesWritten
totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.uploadProgress) {
            self.uploadProgress((NSUInteger)bytesWritten, totalBytesWritten, totalBytesExpectedToWrite);
        }
    });
}

- (void)connection:(NSURLConnection __unused *)connection
didReceiveResponse:(NSURLResponse *)response
{
    self.response = response;
}

- (void)connection:(NSURLConnection __unused *)connection
    didReceiveData:(NSData *)data
{
    NSUInteger length = [data length];
    while (YES) {
        NSInteger totalNumberOfBytesWritten = 0;
        if ([self.outputStream hasSpaceAvailable]) {
            const uint8_t *dataBuffer = (uint8_t *)[data bytes];

            NSInteger numberOfBytesWritten = 0;
            while (totalNumberOfBytesWritten < (NSInteger)length) {
                numberOfBytesWritten = [self.outputStream write:&dataBuffer[(NSUInteger)totalNumberOfBytesWritten] maxLength:(length - (NSUInteger)totalNumberOfBytesWritten)];
                if (numberOfBytesWritten == -1) {
                    break;
                }
                
                totalNumberOfBytesWritten += numberOfBytesWritten;
            }

            break;
        }
        
        if (self.outputStream.streamError) {
            [self.connection cancel];
            [self performSelector:@selector(connection:didFailWithError:) withObject:self.connection withObject:self.outputStream.streamError];
            return;
        }
    }

    dispatch_async(dispatch_get_main_queue(), ^{
        self.totalBytesRead += (long long)length;

        if (self.downloadProgress) {
            self.downloadProgress(length, self.totalBytesRead, self.response.expectedContentLength);
        }
    });
}

- (void)connectionDidFinishLoading:(NSURLConnection __unused *)connection {
    self.responseData = [self.outputStream propertyForKey:NSStreamDataWrittenToMemoryStreamKey];

    [self.outputStream close];
    if (self.responseData) {
       self.outputStream = nil;
    }

    self.connection = nil;

    [self finish];
}

- (void)connection:(NSURLConnection __unused *)connection
  didFailWithError:(NSError *)error
{
    self.error = error;

    [self.outputStream close];
    if (self.responseData) {
        self.outputStream = nil;
    }

    self.connection = nil;

    [self finish];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse *)cachedResponse
{
    if (self.cacheResponse) {
        return self.cacheResponse(connection, cachedResponse);
    } else {
        if ([self isCancelled]) {
            return nil;
        }
        
        return cachedResponse;
    }
}

#pragma mark - NSSecureCoding

+ (BOOL)supportsSecureCoding {
    return YES;
}

- (id)initWithCoder:(NSCoder *)decoder {
    NSURLRequest *request = [decoder decodeObjectOfClass:[NSURLRequest class] forKey:NSStringFromSelector(@selector(request))];
    
    self = [self initWithRequest:request];
    if (!self) {
        return nil;
    }

    self.state = [[decoder decodeObjectOfClass:[NSNumber class] forKey:NSStringFromSelector(@selector(state))] integerValue];
    self.response = [decoder decodeObjectOfClass:[NSHTTPURLResponse class] forKey:NSStringFromSelector(@selector(response))];
    self.error = [decoder decodeObjectOfClass:[NSError class] forKey:NSStringFromSelector(@selector(error))];
    self.responseData = [decoder decodeObjectOfClass:[NSData class] forKey:NSStringFromSelector(@selector(responseData))];
    self.totalBytesRead = [[decoder decodeObjectOfClass:[NSNumber class] forKey:NSStringFromSelector(@selector(totalBytesRead))] longLongValue];

    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [self pause];
    
    [coder encodeObject:self.request forKey:NSStringFromSelector(@selector(request))];
    
    switch (self.state) {
        case GFOperationExecutingState:
        case GFOperationPausedState:
            [coder encodeInteger:GFOperationReadyState forKey:NSStringFromSelector(@selector(state))];
            break;
        default:
            [coder encodeInteger:self.state forKey:NSStringFromSelector(@selector(state))];
            break;
    }
    
    [coder encodeObject:self.response forKey:NSStringFromSelector(@selector(response))];
    [coder encodeObject:self.error forKey:NSStringFromSelector(@selector(error))];
    [coder encodeObject:self.responseData forKey:NSStringFromSelector(@selector(responseData))];
    [coder encodeInt64:self.totalBytesRead forKey:NSStringFromSelector(@selector(totalBytesRead))];
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone {
    GFURLConnectionOperation *operation = [(GFURLConnectionOperation *)[[self class] allocWithZone:zone] initWithRequest:self.request];
    
    operation.uploadProgress = self.uploadProgress;
    operation.downloadProgress = self.downloadProgress;
    operation.authenticationChallenge = self.authenticationChallenge;
    operation.cacheResponse = self.cacheResponse;
    operation.redirectResponse = self.redirectResponse;
    operation.completionQueue = self.completionQueue;
    operation.completionGroup = self.completionGroup;
    
    return operation;
}

@end
