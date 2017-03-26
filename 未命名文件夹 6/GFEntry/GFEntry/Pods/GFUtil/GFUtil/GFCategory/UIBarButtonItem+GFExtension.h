//
//  UIBarButtonItem+GFExtension.h
//  GFUtil
//
//  Created by huangjian on 17/3/20.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (GFExtension)

+ (instancetype)gf_itemWithTitle:(NSString *)title color:(UIColor *)color target:(id)target action:(SEL)action;
+ (instancetype)gf_itemWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action;
+ (instancetype)gf_itemWithSpaceWidth:(CGFloat)width;

@end
