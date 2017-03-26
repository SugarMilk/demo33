//
//  UIView+GFFrame.h
//  GFUtil
//
//  Created by huangjian on 17/3/20.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (GFFrame)

@property (nonatomic, assign) CGFloat gf_x;
@property (nonatomic, assign) CGFloat gf_y;
@property (nonatomic, assign) CGFloat gf_width;
@property (nonatomic, assign) CGFloat gf_height;

@property (nonatomic, assign) CGPoint gf_origin;
@property (nonatomic, assign) CGSize  gf_size;

@property (nonatomic, assign, readonly) CGFloat gf_xWidth;  // x + width
@property (nonatomic, assign, readonly) CGFloat gf_yHeight; // y + height

- (void)gf_removeAllSubviews;

@end
