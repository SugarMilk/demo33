//
//  GFPersistenceKeychain.m
//  GFPersistence
//
//  Created by huangjian on 17/3/14.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import "GFPersistence.h"
#import "GFKeychain.h"

@implementation GFPersistenceKeychain

+ (id)dataWithIdType:(GFKeychainIdType)type identifier:(NSString *)identifier {
    NSString * service = [self getFullIdertifer:identifier idType:type];
    if (service) {
        return [GFKeychain load:service];
    }
    return nil;
}

+ (BOOL)addWithIdType:(GFKeychainIdType)type identifier:(NSString *)identifier data:(id)data {
    NSString * service = [self getFullIdertifer:identifier idType:type];
    if (service && data) {
        [GFKeychain save:service data:data];
        return YES;
    }
    return NO;
}

+ (BOOL)removeWithIdType:(GFKeychainIdType)type identifier:(NSString *)identifier {
    NSString * service = [self getFullIdertifer:identifier idType:type];
    if (service) {
        [GFKeychain remove:service];
        return YES;
    }
    return NO;
}

+ (NSString *)getFullIdertifer:(NSString *)identifier idType:(GFKeychainIdType)type {
    NSString * bundleIdentifer = [NSBundle mainBundle].bundleIdentifier;
    
    if (type == GFKeychainIdType1) {
        return [NSString stringWithFormat:@"%@.%@", bundleIdentifer, identifier];
    } else if (type == GFKeychainIdType2) {
        return [NSString stringWithFormat:@"%@%@", [bundleIdentifer componentsSeparatedByString:@"."].lastObject, identifier];
    }
    
    return nil;
}

@end
