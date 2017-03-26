//
//  GFColorUtil.h
//  GameFriendSDK
//
//  Created by  好玩友2 on 15/12/21.
//  Copyright © 2015年  好玩友2. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GFColorUtil : NSObject


+ (UIColor *)colorWithHexValue:(uint)hexValue alpha:(float)alpha;
//16进制取色
+ (UIColor *)colorWithHexString:(NSString*)hexString alpha:(float)alpha;

@end
