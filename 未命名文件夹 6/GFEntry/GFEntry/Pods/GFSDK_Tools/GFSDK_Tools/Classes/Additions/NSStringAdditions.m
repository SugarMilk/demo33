//
//  NSStringAdditions.m
//  GameFriendSDK
//
//  Created by  好玩友2 on 15/12/21.
//  Copyright © 2015年  好玩友2. All rights reserved.
//

#import "NSStringAdditions.h"

@implementation NSString(gf)

- (NSString *)trimedString{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

@end
