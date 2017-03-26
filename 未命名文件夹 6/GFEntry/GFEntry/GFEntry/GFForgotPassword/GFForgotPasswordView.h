//
//  GFForgotPasswordView.h
//  GFEntry
//
//  Created by huangjian on 17/3/22.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM (NSUInteger, GFForgotPasswordViewButtonType) {
    GFForgotPasswordViewButtonTypeForgotAccount,
    GFForgotPasswordViewButtonTypeNextStep,
};

typedef void(^GFForgotPasswordViewButtonActionBlock)(UIButton * button, GFForgotPasswordViewButtonType buttonType);

@interface GFForgotPasswordView : UIView

@property (nonatomic, copy) NSString * text;

- (void)handleButtonActionBlock:(GFForgotPasswordViewButtonActionBlock)buttonActionBlock;

@end
