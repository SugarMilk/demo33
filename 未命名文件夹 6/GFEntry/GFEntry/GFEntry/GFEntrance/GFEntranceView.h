//
//  GFEntranceView.h
//  GFEntry
//
//  Created by huangjian on 17/3/20.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, GFEntranceViewButtonType) {
    GFEntranceViewButtonTypeTouristLogin,
    GFEntranceViewButtonTypeRegister,
    GFEntranceViewButtonTypeMobilePhoneLogin,
    GFEntranceViewButtonTypeUserNameLogin,
};

typedef void(^GFEntranceViewButtonActionBlock)(UIButton * button, GFEntranceViewButtonType buttonType);

@interface GFEntranceView : UIView

- (void)handleButtonActionBlock:(GFEntranceViewButtonActionBlock)buttonActionBlock;

@end
