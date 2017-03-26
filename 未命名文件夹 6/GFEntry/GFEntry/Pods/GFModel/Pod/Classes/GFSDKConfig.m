//
//  GFSDKConfig.m
//  GFModel
//
//  Created by huangjian on 17/3/17.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import "GFSDKConfig.h"

@implementation GFSDKConfig

+ (instancetype)shared {
    static GFSDKConfig * instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

@end
