//
//  GFDemoResourceHelper.h
//  Pods
//
//  Created by sdk－app11 on 17/1/18.
//
//

#import <UIKit/UIKit.h>
#import "GFDemoChartEnum.h"

@interface GFDemoResourceHelper : UIView

/**
 读取指定类型对应的图片
 */
+(UIImage *)loadImageWithItemImageType:(GFDemoItemImageType)itemImageType;

@end
