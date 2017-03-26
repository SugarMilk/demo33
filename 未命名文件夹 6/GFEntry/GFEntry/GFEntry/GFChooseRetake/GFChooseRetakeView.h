//
//  GFChooseRetakeView.h
//  GFEntry
//
//  Created by huangjian on 17/3/22.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM (NSUInteger, GFChooseRetakeViewButtonType) {
    GFGetCaptchaViewButtonTypeFindByMobilePhone,
    GFGetCaptchaViewButtonTypeFindByEmail,
};

typedef void(^GFChooseRetakeViewButtonActionBlock)(UIButton * button, GFChooseRetakeViewButtonType buttonType);

@interface GFChooseRetakeView : UIView

- (void)handleButtonActionBlock:(GFChooseRetakeViewButtonActionBlock)buttonActionBlock;

@end
