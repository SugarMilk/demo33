//
//  GFPersistenceUserDefaults.m
//  GFPersistence
//
//  Created by huangjian on 17/3/14.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import "GFPersistence.h"

@implementation GFPersistenceUserDefaults

+ (id)dataWithPrefix:(NSString *)prefix identifier:(NSString *)identifier {
    return [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@%@", prefix, identifier]];
}

+ (void)addWithPrefix:(NSString *)prefix identifier:(NSString *)identifier data:(id)data {
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:[NSString stringWithFormat:@"%@%@", prefix, identifier]];
}

+ (void)removeWithPrefix:(NSString *)prefix identifier:(NSString *)identifier {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:[NSString stringWithFormat:@"%@%@", prefix, identifier]];
}

@end
