//
//  UIButton+GFCountDown.m
//  GFUtil
//
//  Created by huangjian on 17/3/20.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import "UIButton+GFCountDown.h"

@implementation UIButton (GFCountDown)

- (void)gf_startWithDuration:(NSInteger)duration running:(GFCountDownRunBlock)runBlock finished:(GFCountDownEndBlock)endBlock {
    __block NSInteger timeOut = duration;
    dispatch_queue_t queue    = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer  = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        if (timeOut <= 0) {
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                endBlock(self);
            });
        } else {
            int allTime = (int)duration + 1;
            int seconds = timeOut % allTime;
            dispatch_async(dispatch_get_main_queue(), ^{
                runBlock(self, duration, seconds);
            });
            timeOut--;
        }
    });
    dispatch_resume(_timer);
}

@end
