//
//  GFUserNameLoginView.h
//  GFEntry
//
//  Created by huangjian on 17/3/21.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM (NSUInteger, GFUserNameLoginViewButtonType) {
    GFUserNameLoginViewButtonTypeLogin,
    GFUserNameLoginViewButtonTypeForgotPassword,
};

typedef void(^GFUserNameLoginViewButtonActionBlock)(UIButton * button, GFUserNameLoginViewButtonType buttonType);

@interface GFUserNameLoginView : UIView

@property (nonatomic, copy) NSString * username;
@property (nonatomic, copy) NSString * password;

- (void)handleButtonActionBlock:(GFUserNameLoginViewButtonActionBlock)buttonActionBlock;

@end
