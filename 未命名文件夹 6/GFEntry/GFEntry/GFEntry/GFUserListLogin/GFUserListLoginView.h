//
//  GFUserListLoginView.h
//  GFEntry
//
//  Created by huangjian on 17/3/22.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM (NSUInteger, GFUserListLoginViewButtonType) {
    GFUserListLoginViewButtonTypeRemove,        // object 为本地存储的用户对象，进行移除操作
    GFUserListLoginViewButtonTypeLogin,         // object 为本地存储的用户对象，使用该帐号进行登录
    GFUserListLoginViewButtonTypeSwitchAccount, // object 为切换帐号的按钮，进行页面跳转
};

typedef BOOL(^GFUserListLoginViewButtonActionBlock)(id object, GFUserListLoginViewButtonType buttonType);

@interface GFUserListLoginView : UIView

- (void)setDataSourceArray:(NSArray *)array;
- (void)handleButtonActionBlock:(GFUserListLoginViewButtonActionBlock)buttonActionBlock;

@end
