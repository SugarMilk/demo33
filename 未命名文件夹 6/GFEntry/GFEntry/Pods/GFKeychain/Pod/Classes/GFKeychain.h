//
//  GFKeychain.h
//  GFKeychain
//
//  Created by huangjian on 17/2/20.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GFKeychain : NSObject

+ (id)load:(NSString *)service;
+ (void)save:(NSString *)service data:(id)data;
+ (void)remove:(NSString *)service;

@end
