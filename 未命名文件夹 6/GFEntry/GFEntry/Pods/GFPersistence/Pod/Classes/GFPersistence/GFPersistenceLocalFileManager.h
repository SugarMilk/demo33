//
//  GFPersistenceLocalFileManager.h
//  GFPersistence
//
//  Created by huangjian on 17/3/14.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GFPersistenceLocalFileManager : NSObject

@property (nonatomic, readonly, copy) NSString * cachesRoot;
@property (nonatomic, readonly, copy) NSString * documentRoot;

+ (instancetype)shared;
- (BOOL)fileExistsAtPath:(NSString *)path;
- (NSString *)cachesPathWithDir:(NSString *)dirName;
- (NSString *)documentPathWithDir:(NSString *)dirName;
- (NSString *)documentPathWithDir:(NSString *)dirName file:(NSString *)fileName;

@end
