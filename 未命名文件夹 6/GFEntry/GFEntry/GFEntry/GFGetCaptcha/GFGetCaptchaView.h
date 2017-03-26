//
//  GFGetCaptchaView.h
//  GFEntry
//
//  Created by huangjian on 17/3/22.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM (NSUInteger, GFGetCaptchaViewButtonType) {
    GFGetCaptchaViewButtonTypeGetCaptcha,
    GFGetCaptchaViewButtonTypeNotReceive,
    GFGetCaptchaViewButtonTypeNextStep,
};

typedef void(^GFGetCaptchaViewButtonActionBlock)(UIButton * button, GFGetCaptchaViewButtonType buttonType);

@interface GFGetCaptchaView : UIView

@property (nonatomic, copy) NSString * bindIdentifier;
@property (nonatomic, copy) NSString * captcha;

- (void)handleButtonActionBlock:(GFGetCaptchaViewButtonActionBlock)buttonActionBlock;

@end
