//
//  UIButton+GFImagePosition.h
//  GFUtil
//
//  Created by huangjian on 17/3/20.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, GFImagePosition) {
    GFImagePositionLeft   = 0,  // 图片左文字右
    GFImagePositionRight  = 1,  // 图片右文字左
    GFImagePositionTop    = 2,  // 图片上文字下
    GFImagePositionBottom = 3,  // 图片下文字上
};

@interface UIButton (GFImagePosition)

/**
 *  设置按钮图片和文字的位置
 *
 *  @param postion 图片和文字的位置类型
 *  @param inset   图片和文字的间距
 */
- (void)gf_setImagePosition:(GFImagePosition)postion inset:(CGFloat)inset;

@end
