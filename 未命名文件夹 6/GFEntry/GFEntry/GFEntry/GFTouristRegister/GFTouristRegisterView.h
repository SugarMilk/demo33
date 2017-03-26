//
//  GFTouristRegisterView.h
//  GFEntry
//
//  Created by huangjian on 17/3/21.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM (NSUInteger, GFTouristRegisterViewButtonType) {
    GFTouristRegisterViewButtonTypeRegister,
    GFTouristRegisterViewButtonTypeAgreement,
    GFTouristRegisterViewButtonTypeSwitchAccount,
};

typedef void(^GFTouristRegisterViewButtonActionBlock)(UIButton * button, GFTouristRegisterViewButtonType buttonType);

@interface GFTouristRegisterView : UIView

@property (nonatomic, copy) NSString * username;
@property (nonatomic, copy) NSString * password;

- (void)handleButtonActionBlock:(GFTouristRegisterViewButtonActionBlock)buttonActionBlock;

@end
