//
//  UIButton+GFCountDown.h
//  GFUtil
//
//  Created by huangjian on 17/3/20.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^GFCountDownRunBlock)(UIButton * button, NSInteger totalTime, NSInteger leftTime);
typedef void(^GFCountDownEndBlock)(UIButton * button);

@interface UIButton (GFCountDown)

/**
 *  倒计时按钮
 *
 *  为防止文字闪烁，请将UIButton的类型由 System 改为 Custom
 *
 *  @param duration 总时间
 *  @param runBlock 倒计时期间回调
 *  @param endBlock 倒计时结束回调
 */
- (void)gf_startWithDuration:(NSInteger)duration
                     running:(GFCountDownRunBlock)runBlock
                     finished:(GFCountDownEndBlock)endBlock;

@end
