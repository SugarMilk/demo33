//
//  NSString+GFAvailable.m
//  GFUtil
//
//  Created by huangjian on 17/3/20.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import <Foundation/Foundation.h>

@implementation NSString (GFAvailable)

- (BOOL)containsString:(NSString *)str {
    return [self rangeOfString:str].location != NSNotFound;
}

@end
