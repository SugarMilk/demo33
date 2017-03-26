//
//  UIBarButtonItem+GFExtension.m
//  GFUtil
//
//  Created by huangjian on 17/3/20.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import "UIBarButtonItem+GFExtension.h"

@implementation UIBarButtonItem (GFExtension)

+ (instancetype)gf_itemWithTitle:(NSString *)title color:(UIColor *)color target:(id)target action:(SEL)action {
    UIBarButtonItem *item = [[self alloc] initWithTitle:title style:UIBarButtonItemStyleDone target:target action:action];
    item.tintColor = color ? color : item.tintColor;
    return item;
}

+ (instancetype)gf_itemWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action {
    UIButton *button = [[UIButton alloc] init];
    [button setFrame:(CGRect){CGPointZero, image.size}];
    [button setImage:image     forState:UIControlStateNormal];
    [button setImage:highImage forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[self alloc] initWithCustomView:button];
}

+ (instancetype)gf_itemWithSpaceWidth:(CGFloat)width {
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    space.width = width;
    return space;
}

@end
