//
//  GFPersistence.h
//  GFPersistence
//
//  Created by huangjian on 17/3/14.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, GFKeychainIdType) {
    /*
     rule: FullIdertifer = [NSBundle mainBundle].bundleIdentifier + '.' + identifier
     eg: kGFKeychain_trykey、kGFKeychain_mac、kGFKeychain_isNewSupplement
     */
    GFKeychainIdType1 = 1,
    /*
     rule: FullIdertifer = [[NSBundle mainBundle].bundleIdentifier componentsSeparatedByString:@"."].lastObject + identifier
     eg: kGFKeychain_Payment_storeKey、kGFKeychain_sdkURL、kGFKeychain_imprestURL
     */
    GFKeychainIdType2 = 2,
};

@interface GFPersistenceKeychain : NSObject

+ (id)dataWithIdType:(GFKeychainIdType)type identifier:(NSString *)identifier;
+ (BOOL)addWithIdType:(GFKeychainIdType)type identifier:(NSString *)identifier data:(id)data;
+ (BOOL)removeWithIdType:(GFKeychainIdType)type identifier:(NSString *)identifier;

@end

@interface GFPersistenceUserDefaults : NSObject

+ (id)dataWithPrefix:(NSString *)prefix identifier:(NSString *)identifier;
+ (void)addWithPrefix:(NSString *)prefix identifier:(NSString *)identifier data:(id)data;
+ (void)removeWithPrefix:(NSString *)prefix identifier:(NSString *)identifier;

@end

@class GFPersistenceLocalFileModel;

@interface GFPersistenceSandbox : NSObject

+ (void)writeWithModel:(GFPersistenceLocalFileModel *)model data:(id)data;
+ (void)removeWithModel:(GFPersistenceLocalFileModel *)model;
+ (id)dataWithModel:(GFPersistenceLocalFileModel *)model;
+ (NSString *)pathWithModel:(GFPersistenceLocalFileModel *)model;

@end
