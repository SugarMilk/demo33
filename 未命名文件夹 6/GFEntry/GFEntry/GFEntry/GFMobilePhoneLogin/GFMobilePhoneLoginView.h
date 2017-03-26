//
//  GFMobilePhoneLoginView.h
//  GFEntry
//
//  Created by huangjian on 17/3/21.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM (NSUInteger, GFMobilePhoneLoginViewButtonType) {
    GFMobilePhoneLoginViewButtonTypeGetCaptcha,
    GFMobilePhoneLoginViewButtonTypeNotReceive,
    GFMobilePhoneLoginViewButtonTypeLogin,
};

typedef void(^GFMobilePhoneLoginViewButtonActionBlock)(UIButton * button, GFMobilePhoneLoginViewButtonType buttonType);

@interface GFMobilePhoneLoginView : UIView

@property (nonatomic, copy) NSString * phoneNo;
@property (nonatomic, copy) NSString * captcha;

- (void)handleButtonActionBlock:(GFMobilePhoneLoginViewButtonActionBlock)buttonActionBlock;

@end
