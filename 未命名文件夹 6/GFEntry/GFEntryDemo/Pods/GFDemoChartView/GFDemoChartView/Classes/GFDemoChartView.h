//
//  GFDemoChartView.h
//  Pods
//
//  Created by sdk－app11 on 17/1/18.
//
//

#import <UIKit/UIKit.h>
#import "GFDemoChartEnum.h"

typedef void(^GFDemoViewItemClickBlock)(void);

@interface GFDemoChartView : UIScrollView

//是否添加转屏功能
@property (nonatomic ,assign) BOOL addRotateItem;

//是否添加实时日志按钮
@property (nonatomic ,assign) BOOL addLoggerItem;

/**
 添加一个默认可选图片Item
 @params iconImage  单元显示图片
 @params btnContext 单元显示文字
 @params clickBlock 单元点击block
 */
-(void)addItemWithItemImageType:(GFDemoItemImageType)imageType btnContext:(NSString *)btnContext clickBlock:(GFDemoViewItemClickBlock)clickBlock;

/**
 添加一个自定义item
 @params iconImage  单元显示图片
 @params btnContext 单元显示文字
 @params clickBlock 单元点击block
 */
-(void)addItemWithIconImage:(UIImage *)iconImage btnContext:(NSString *)btnContext clickBlock:(GFDemoViewItemClickBlock)clickBlock;


@end
