//
//  GFUserNameRegisterView.h
//  GFEntry
//
//  Created by huangjian on 17/3/21.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM (NSUInteger, GFUserNameRegisterViewButtonType) {
    GFUserNameRegisterViewButtonTypeRegister,
    GFUserNameRegisterViewButtonTypeAgreement,
};

typedef void(^GFUserNameRegisterViewButtonActionBlock)(UIButton * button, GFUserNameRegisterViewButtonType buttonType);

@interface GFUserNameRegisterView : UIView

@property (nonatomic, copy) NSString * username;
@property (nonatomic, copy) NSString * password;

- (void)handleButtonActionBlock:(GFUserNameRegisterViewButtonActionBlock)buttonActionBlock;

@end
