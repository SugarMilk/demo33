//
//  UIImageAdditions.m
//  GameFriendSDK
//
//  Created by  好玩友2 on 15/12/21.
//  Copyright © 2015年  好玩友2. All rights reserved.
//

#import "UIImageAdditions.h"

@implementation UIImage(gf)

- (UIImage *)resizableImageForAlliOSVersionWithCapInsets:(UIEdgeInsets)capInsets {
    if ([[UIDevice currentDevice].systemVersion doubleValue] > 4.99) {
        return [self resizableImageWithCapInsets:capInsets];
    } else {
        return [self stretchableImageWithLeftCapWidth:capInsets.left topCapHeight:capInsets.top];
    }
}

- (UIImage *)scaleToScale:(float)scale {
    UIGraphicsBeginImageContext(CGSizeMake(self.size.width*scale,self.size.height*scale));
    [self drawInRect:CGRectMake(0, 0, self.size.width*scale, self.size.height*scale)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

- (UIImage *)resizeToSize:(CGSize)size {
    UIGraphicsBeginImageContext(CGSizeMake(size.width, size.height));
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return reSizeImage;
}

@end
