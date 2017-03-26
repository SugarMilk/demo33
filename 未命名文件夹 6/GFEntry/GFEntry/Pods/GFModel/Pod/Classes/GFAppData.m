//
//  GFAppData.m
//  GFModel
//
//  Created by huangjian on 17/3/21.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import "GFAppData.h"
#import <UIKit/UIKit.h>
#import <AdSupport/AdSupport.h>
#import <GFNetworking/GFNetworking.h>
#import <GFPersistence/GFPersistence.h>
#import <GFPersistenceConfig/GFPersistenceConfig.h>
#import <DeviceUtil/DeviceUtil.h>
#include <sys/socket.h>
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>

@implementation GFAppData

+ (instancetype)current {
    static GFAppData * instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
        [[GFNetworkReachabilityManager sharedManager] startMonitoring];
    });
    return instance;
}

- (BOOL)isReachable {
    if ([GFNetworkReachabilityManager sharedManager].networkReachabilityStatus == GFNetworkReachabilityStatusUnknown) {
        return YES;
    } else {
        return [[GFNetworkReachabilityManager sharedManager] isReachable];
    }
}

- (NSString *)uuid {
    if (_uuid == nil){
        _uuid = [GFPersistenceUserDefaults dataWithPrefix:nil identifier:kGFUserDefaults_uuid] ?: @"";
    }
    return _uuid;
}

- (NSString *)mac {
    if(_mac == nil){
        NSString * systemVersion = [UIDevice currentDevice].systemVersion;
        if ([systemVersion floatValue] >= 7.0) {
            NSDictionary * macInkeyChain = [GFPersistenceKeychain dataWithIdType:1 identifier:kGFKeychain_mac];
            NSString * identifier = [[NSBundle mainBundle] bundleIdentifier];
            NSString * keyName = [[NSString stringWithFormat:@"%@.idfa.value", identifier] init];

            if (macInkeyChain) {
                _mac = [macInkeyChain objectForKey:keyName];    //优先从中间层代码取
            } else {
                NSString *adId =[[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
                NSString * idfa = [NSString stringWithFormat:@"%s", [adId UTF8String]];
                NSDictionary *usernamepasswordKVPairs = [NSDictionary dictionaryWithObject:idfa forKey:keyName];
                [GFPersistenceKeychain addWithIdType:1 identifier:kGFKeychain_mac data:usernamepasswordKVPairs];
                _mac = [idfa copy];
            }
            
            NSString *errorIDFAStr = @"00000000-0000-0000-0000-000000000000";
            
            if ([_mac isEqualToString:errorIDFAStr]) {
                CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
                CFStringRef uuid_string_ref = CFUUIDCreateString(NULL, uuid_ref);
                CFRelease(uuid_ref);
                NSString * uuid = [NSString stringWithFormat:@"%@",(__bridge NSString*)uuid_string_ref];
                CFRelease(uuid_string_ref);
                
                NSString * idfa = [NSString stringWithFormat:@"%s", [uuid UTF8String]];
                NSDictionary *usernamepasswordKVPairs = [NSDictionary dictionaryWithObject:idfa forKey:keyName];
                [GFPersistenceKeychain addWithIdType:1 identifier:kGFKeychain_mac data:usernamepasswordKVPairs];
                _mac=[idfa copy];
            }
            
        } else {
            int                mib[6];
            size_t                len;
            char                 *buf;
            unsigned char        *ptr;
            struct if_msghdr     *ifm;
            struct sockaddr_dl   *sdl;
            
            mib[0] = CTL_NET;
            mib[1] = AF_ROUTE;
            mib[2] = 0;
            mib[3] = AF_LINK;
            mib[4] = NET_RT_IFLIST;
            
            if ((mib[5] = if_nametoindex("en0")) == 0) {
                printf("Error: if_nametoindex error/n");
                _mac=@"";
            }
            
            if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
                printf("Error: sysctl, take 1/n");
                _mac=@"";
            }
            
            if ((buf = malloc(len)) == NULL) {
                printf("Could not allocate memory. error!/n");
                _mac=@"";
            }
            
            if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
                printf("Error: sysctl, take 2");
                _mac=@"";
            }
            
            ifm = (struct if_msghdr *)buf;
            sdl = (struct sockaddr_dl *)(ifm + 1);
            ptr = (unsigned char *)LLADDR(sdl);
            NSString *outstring = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
            free(buf);
            _mac=[outstring uppercaseString];
        }
    }
    return _mac;
}

- (NSString *)device {
    return self.mac;
}

- (NSString *)model {
    return [DeviceUtil hardwareString];
}

- (NSString *)tryKey {
    NSString * loadTryKeyFromKeychain = [GFPersistenceKeychain dataWithIdType:1 identifier:kGFKeychain_trykey];
    if (loadTryKeyFromKeychain) {
        return loadTryKeyFromKeychain;
    }

    // 获取Mac地址并保存到trykey标识
    if (self.mac.length == 0) {
        // 假设因为某种原因无法获取mac地址的话 则使用UUID来替代
        [GFPersistenceKeychain addWithIdType:1 identifier:kGFKeychain_trykey data:_uuid];
        NSLog(@"can not get mac, use uuid (%@)", _uuid);
        return _uuid;
    } else {
        [GFPersistenceKeychain addWithIdType:1 identifier:kGFKeychain_trykey data:_mac];
        return _mac;
    }
}

- (NSString *)version {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
}

- (NSString *)platformid {
    return @"haowanyou";
}

- (NSString *)gameid {
    return @"0";
}

- (NSString *)sort {
    return @"1";    // 1-游戏内提单 2-游戏外/sdk提单
}

- (NSString *)clientType {
    return @"1";    // 0-pc 1-ios 2-android
}

- (NSString *)os {
    return [UIDevice currentDevice].systemVersion;
}

@end
