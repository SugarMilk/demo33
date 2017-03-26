//
//  GFPersistenceLocalFileManager.m
//  GFPersistence
//
//  Created by huangjian on 17/3/14.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import "GFPersistenceLocalFileManager.h"

@implementation GFPersistenceLocalFileManager

+ (instancetype)shared {
    static GFPersistenceLocalFileManager * instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (NSString *)cachesRootPath {
    return NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
}

- (NSString *)documentRootPath {
    return NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
}

- (BOOL)fileExistsAtPath:(NSString *)path {
    return [[NSFileManager defaultManager] fileExistsAtPath:path];
}

- (NSString *)cachesPathWithDir:(NSString *)dirName {
    NSString * path = [self.cachesRootPath stringByAppendingPathComponent:dirName];
    if ([[NSFileManager defaultManager] fileExistsAtPath:path] == NO) {
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:NULL];
    }
    return path;
}

- (NSString *)documentPathWithDir:(NSString *)dirName {
    NSString * path = [self.documentRootPath stringByAppendingPathComponent:dirName];
    if ([[NSFileManager defaultManager] fileExistsAtPath:path] == NO) {
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:NULL];
    }
    return path;
}

- (NSString *)documentPathWithDir:(NSString *)dirName file:(NSString *)fileName {
    return [[self documentPathWithDir:dirName] stringByAppendingPathComponent:fileName];
}

@end
