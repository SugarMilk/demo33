//
//  GFSDKConfig.h
//  GFModel
//
//  Created by huangjian on 17/3/17.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, GFRealNameAuthtType){
    GFRealNameAuthtType_AllClose = 0,   // 都关闭
    GFRealNameAuthtType_OpenUC   = 2,   // 帐号管理打开
    GFRealNameAuthtType_AllOpen  = 3,   // 帐号管理和提醒都打开
};

@interface GFSDKConfig : NSObject

@property (nonatomic, assign) GFRealNameAuthtType realNameAuthStatus; // OSS后台为实名认证功能新增配置
@property (nonatomic, assign) BOOL allowedOneKeyLogin;  // 服务端一键登录是否允许使用
@property (nonatomic, strong) NSString * oneKeyLoginErrorMessage;   // 一键登录故障信息
@property (nonatomic, assign) BOOL showAssistiveTouch;  // 是否显示悬浮窗
@property (nonatomic, assign) BOOL inReviewState; // 是否处于审核状态
@property (nonatomic, assign) BOOL userInnerEnv; // 使用内网环境
@property (nonatomic, assign) BOOL platformEnabled; // 是否允许使用好玩友平台相关功能
@property (nonatomic, assign) BOOL hideBindMobile;  // 是否隐藏绑定手机
@property (nonatomic, strong) NSString * passportRule;  // pp校验开关

+ (instancetype)shared;

@end
