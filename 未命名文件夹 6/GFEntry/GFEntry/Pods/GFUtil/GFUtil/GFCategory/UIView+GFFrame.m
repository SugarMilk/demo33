//
//  UIView+GFFrame.m
//  GFUtil
//
//  Created by huangjian on 17/3/20.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import "UIView+GFFrame.h"

@implementation UIView (GFFrame)

- (void)setGf_x:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)gf_x {
    return self.frame.origin.x;
}

- (void)setGf_y:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)gf_y {
    return self.frame.origin.y;
}

- (void)setGf_width:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)gf_width {
    return self.frame.size.width;
}

- (void)setGf_height:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)gf_height {
    return self.frame.size.height;
}

- (void)setGf_origin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)gf_origin {
    return self.frame.origin;
}

- (void)setGf_size:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)gf_size {
    return self.frame.size;
}

- (CGFloat)gf_xWidth {
    return self.frame.origin.x + self.frame.size.width;
}

- (CGFloat)gf_yHeight {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)gf_removeAllSubviews {
    while (self.subviews.count) {
        UIView *lastView = [self.subviews lastObject];
        [lastView removeFromSuperview];
    }
}


@end
