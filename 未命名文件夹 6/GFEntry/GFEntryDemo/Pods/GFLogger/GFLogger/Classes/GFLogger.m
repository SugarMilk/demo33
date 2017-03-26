//
//  GFLogger.m
//  Pods
//
//  Created by sdk－app11 on 16/12/26.
//
//

#import "GFLogger.h"
#import "iConsole.h"

// error level by default

#if DEBUG == 1
static GFLogLevel _level = GFLogLevelDebug;
#else
static GFLogLevel _level = GFLogLevelFatal;
#endif

@implementation GFLogger

+ (void)setLogLevel:(GFLogLevel)level
{
    _level = level;
}

+ (void)debug:(NSString *)format, ...
{
    if (_level <= GFLogLevelDebug) {
        va_list argList;
        va_start(argList, format);
        NSMutableString * message = [[NSMutableString alloc] initWithFormat:format
                                                                  arguments:argList];
        
        [iConsole log:message args:argList];
        va_end(argList);
        
    }
    
}

+ (void)info:(NSString *)format, ...
{
    if (_level <= GFLogLevelInfo) {
        va_list argList;
        va_start(argList, format);
        NSMutableString * message = [[NSMutableString alloc] initWithFormat:format
                                                                  arguments:argList];
        
        [message insertString:@"Info:" atIndex:0];
        [iConsole info:message args:argList];
        va_end(argList);
        
    }
}

+ (void)warn:(NSString *)format, ...
{
    if (_level <= GFLogLevelWarn) {
        va_list argList;
        va_start(argList, format);
        NSMutableString * message = [[NSMutableString alloc] initWithFormat:format
                                                                  arguments:argList];
        
        [message insertString:@"Warn:" atIndex:0];
        [iConsole warn:message args:argList];
        va_end(argList);
        
    }
}

+ (void)error:(NSString *)format, ...
{
    if (_level <= GFLogLevelError) {
        va_list argList;
        va_start(argList, format);
        NSMutableString * message = [[NSMutableString alloc] initWithFormat:format
                                                                  arguments:argList];
        
        [message insertString:@"Error:" atIndex:0];
        [iConsole error:message args:argList];
        va_end(argList);
        
    }
}

+ (void)fatal:(NSString *)format, ...
{
    if (_level <= GFLogLevelFatal) {
        va_list argList;
        va_start(argList, format);
        NSMutableString * message = [[NSMutableString alloc] initWithFormat:format
                                                                  arguments:argList];
        
        [message insertString:@"Fatal:" atIndex:0];
        [iConsole crash:message args:argList];
        va_end(argList);
        
    }
}

+ (void)debugWithRect:(CGRect)rect prefix:(NSString *)prefix {
    [self debug:@"%@ Rect:(%f, %f, %f, %f)", prefix, rect.origin.x, rect.origin.y, rect.size.width, rect.size.height];
}

+ (void)debugWithPoint:(CGPoint)point prefix:(NSString *)prefix {
    [self debug:@"%@ Point:(%f, %f)", prefix, point.x, point.y];
}

+ (void)debugWithSize:(CGSize)size prefix:(NSString *)prefix {
    [self debug:@"%@ Size:(%f, %f)", prefix, size.width, size.height];
}

+ (void)debugWithViewGF:(UIView *)v prefix:(NSString *)prefix {
    for (UIView* view = v; view; view = view.superview) {
        [self debug:@"%@", view];
    };
}

+ (void)showLogPanel{
    [iConsole show];
}

+ (void)hideLogPanel{
    [iConsole hide];
}

+ (void)setShakeToShow:(BOOL)shakeToShow{
    [iConsole sharedConsole].deviceShakeToShow = shakeToShow;
    [iConsole sharedConsole].simulatorShakeToShow = shakeToShow;
}

@end
