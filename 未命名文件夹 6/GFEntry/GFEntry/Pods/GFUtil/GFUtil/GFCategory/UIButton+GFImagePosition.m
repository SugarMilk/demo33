//
//  UIButton+GFImagePosition.m
//  GFUtil
//
//  Created by huangjian on 17/3/20.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import "UIButton+GFImagePosition.h"

@implementation UIButton (GFImagePosition)

- (void)gf_setImagePosition:(GFImagePosition)postion inset:(CGFloat)inset {
    [self setTitle:self.currentTitle forState:UIControlStateNormal];
    [self setImage:self.currentImage forState:UIControlStateNormal];
    
    CGFloat imageWidth  = self.imageView.image.size.width;
    CGFloat imageHeight = self.imageView.image.size.height;
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    CGFloat labelWidth  = [self.titleLabel.text sizeWithFont:self.titleLabel.font].width;
    CGFloat labelHeight = [self.titleLabel.text sizeWithFont:self.titleLabel.font].height;
#pragma clang diagnostic pop
    
    CGFloat imageOffsetX = (imageWidth + labelWidth) / 2 - imageWidth / 2;
    CGFloat imageOffsetY = imageHeight / 2 + inset / 2;
    CGFloat labelOffsetX = (imageWidth + labelWidth / 2) - (imageWidth + labelWidth) / 2;
    CGFloat labelOffsetY = labelHeight / 2 + inset / 2;
    
    CGFloat tempWidth     = MAX(labelWidth, imageWidth);
    CGFloat changedWidth  = labelWidth + imageWidth - tempWidth;
    CGFloat tempHeight    = MAX(labelHeight, imageHeight);
    CGFloat changedHeight = labelHeight + imageHeight + inset - tempHeight;
    
    switch (postion) {
        case GFImagePositionLeft:
            self.imageEdgeInsets = UIEdgeInsetsMake(0, -inset/2, 0, inset/2);
            self.titleEdgeInsets = UIEdgeInsetsMake(0, inset/2, 0, -inset/2);
            self.contentEdgeInsets = UIEdgeInsetsMake(0, inset/2, 0, inset/2);
            break;
        case GFImagePositionRight:
            self.imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth + inset/2, 0, -(labelWidth + inset/2));
            self.titleEdgeInsets = UIEdgeInsetsMake(0, -(imageWidth + inset/2), 0, imageWidth + inset/2);
            self.contentEdgeInsets = UIEdgeInsetsMake(0, inset/2, 0, inset/2);
            break;
        case GFImagePositionTop:
            self.imageEdgeInsets = UIEdgeInsetsMake(-imageOffsetY, imageOffsetX, imageOffsetY, -imageOffsetX);
            self.titleEdgeInsets = UIEdgeInsetsMake(labelOffsetY, -labelOffsetX, -labelOffsetY, labelOffsetX);
            self.contentEdgeInsets = UIEdgeInsetsMake(imageOffsetY, -changedWidth/2, changedHeight-imageOffsetY, -changedWidth/2);
            break;
        case GFImagePositionBottom:
            self.imageEdgeInsets = UIEdgeInsetsMake(imageOffsetY, imageOffsetX, -imageOffsetY, -imageOffsetX);
            self.titleEdgeInsets = UIEdgeInsetsMake(-labelOffsetY, -labelOffsetX, labelOffsetY, labelOffsetX);
            self.contentEdgeInsets = UIEdgeInsetsMake(changedHeight-imageOffsetY, -changedWidth/2, imageOffsetY, -changedWidth/2);
            break;
        default:
            break;
    }
}


@end
