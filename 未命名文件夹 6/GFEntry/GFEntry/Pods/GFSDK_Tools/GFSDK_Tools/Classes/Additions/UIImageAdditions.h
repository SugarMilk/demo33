//
//  UIImageAdditions.h
//  GameFriendSDK
//
//  Created by  好玩友2 on 15/12/21.
//  Copyright © 2015年  好玩友2. All rights reserved.
//

#import <Foundation/Foundation.h>

CGContextRef createARGBBitmapContextFromImage(CGImageRef image);

@interface UIImage(gf)

- (UIImage *)resizableImageForAlliOSVersionWithCapInsets:(UIEdgeInsets)capInsets;

/**
 将image按照指定的比例放大或缩小
 */
- (UIImage *)scaleToScale:(float)scale;

/**
 将image按照指定的大小放大或缩小
 */
- (UIImage *)resizeToSize:(CGSize)size;

@end
