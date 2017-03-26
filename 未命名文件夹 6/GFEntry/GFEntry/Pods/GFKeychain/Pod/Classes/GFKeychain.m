//
//  GFKeychain.m
//  GFKeychain
//
//  Created by huangjian on 17/2/20.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import "GFKeychain.h"
#import <Security/Security.h>

@implementation GFKeychain

+ (NSMutableDictionary *)keyChainData:(NSString *)service {
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            (id)kSecClassGenericPassword,(id)kSecClass,
            service, (id)kSecAttrService,
            service, (id)kSecAttrAccount,
            (id)kSecAttrAccessibleAfterFirstUnlock,(id)kSecAttrAccessible,
            nil];
}

+ (void)save:(NSString *)service data:(id)data {
    //Get search dictionary
    NSMutableDictionary *keychainQuery = [self keyChainData:service];
    if ([self load:service] != nil)
    {
        //Delete old item before add new item
        if (SecItemDelete((CFDictionaryRef)keychainQuery) == noErr) {
            NSLog(@"KC removed successfully");
        } else {
            NSLog(@"KC removed failed");
        }
    }
    //Add new object to search dictionary(Attention:the data format)
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:data] forKey:(id)kSecValueData];
    //Add item to keychain with the search dictionary
    int result = SecItemAdd((CFDictionaryRef)keychainQuery, NULL);
    if (result == noErr) {
        NSLog(@"KC save successfully");
    } else {
        NSLog(@"KC save failed,error code:%d",result);
    }
    // @OSStatus errSecSuccess
}

+ (id)load:(NSString *)service {
    id ret = nil;
    NSMutableDictionary *keychainQuery = [self keyChainData:service];
    //Configure the search setting
    //Since in our simple case we are expecting only a single attribute to be returned (the password) we can set the attribute kSecReturnData to kCFBooleanTrue
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnData];
    [keychainQuery setObject:(id)kSecMatchLimitOne forKey:(id)kSecMatchLimit];
    CFDataRef keyData = NULL;
    if (SecItemCopyMatching((CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr) {
        @try {
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData *)keyData];
        } @catch (NSException *e) {
            NSLog(@"Unarchive of %@ failed: %@", service, e);
        } @finally {
            
        }
    }
    if (keyData)
    CFRelease(keyData);
    return ret;
}

+ (void)remove:(NSString *)service {
    NSMutableDictionary *keychainQuery = [self keyChainData:service];
    SecItemDelete((CFDictionaryRef)keychainQuery);
}

@end
