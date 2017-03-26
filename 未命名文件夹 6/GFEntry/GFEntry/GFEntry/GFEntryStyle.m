//
//  GFEntryStyle.m
//  GFEntry
//
//  Created by huangjian on 17/3/23.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import "GFEntryStyle.h"

@interface GFEntryStyleManager : NSObject

@property (nonatomic, retain) NSDictionary * sheet;

@end

@implementation GFEntryStyleManager

+ (instancetype)sharedInstance {
    static GFEntryStyleManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (NSDictionary *)sheet {
    if (_sheet == nil) {
        _sheet = @{
                 @"common": @{
                         @"vc-view": @{
                                 @"border-radius": @5,
                                 @"content-size": NSStringFromCGSize(CGSizeMake(250, 250)),
                                 @"background-color": [UIColor clearColor],
                                 },
                         },
                 @"entrance": @{
                         @"vc-view": @{
                                 @"background-color": [UIColor greenColor],
                                 },
                         @"choose-way": @{
                                 @"font-size": [UIFont systemFontOfSize:16],
                                 @"color": GFHexStringColor(@"#aaaaaa"),
                                 @"margin-top": @20,
                                 @"height": @20,
                                 @"text": @"选择登录方式",
                                 @"text-align": @(NSTextAlignmentCenter),
                                 @"background-color": [UIColor clearColor],
                                 },
                         @"button-group": @{
                                 @"center-y": @(-10),
                                 @"texts": @[@"游客试玩", @"快速注册", @"手机登录"],
                                 @"background-color": [UIColor clearColor],
                                 @"images": @[[UIImage imageNamed:@"touristPlay"], [UIImage imageNamed:@"quickRegister"], [UIImage imageNamed:@"phoneLogin"]],
                                 @"size": NSStringFromCGSize(CGSizeMake(70, 92)),
                                 @"padding": @15,
                                 @"font-size": [UIFont systemFontOfSize:15],
                                 @"color": GFHexStringColor(@"#424242"),
                                 @"image-text-inset": @12,
                                 },
                         @"h-line": @{
                                 @"height": @1,
                                 @"margin-top": @35,
                                 @"background-color": GFHexStringColor(@"#cccccc"),
                                 },
                         @"username-login": @{
                                 @"margin-top": @8,
                                 @"font-size": [UIFont systemFontOfSize:18],
                                 @"color": GFHexStringColor(@"4cc0fc"),
                                 @"size": NSStringFromCGSize(CGSizeMake(120, 40)),
                                 @"background-color": [UIColor clearColor],
                                 @"text": @"已有帐号>",
                                 },
                         },
                 @"forgot-password": @{
                         @"input": @{
                                 @"margin": NSStringFromUIEdgeInsets(UIEdgeInsetsMake(50, 10, 0, 10)),
                                 @"border-color": GFHexStringColor(@"#cccccc"),
                                 @"border-width": @1,
                                 @"border-radius": @2,
                                 @"placeholder": @"请输入帐号/手机号/邮箱",
                                 @"color": [UIColor blackColor],
                                 @"font-size": [UIFont systemFontOfSize:15],
                                 @"placeholder-indent": NSStringFromUIEdgeInsets(UIEdgeInsetsMake(0, 8, 0, 0)),
                                 @"text-indent": NSStringFromUIEdgeInsets(UIEdgeInsetsMake(0, 6, 0, 0)),
                                 @"height": @35,
                                 },
                         @"forgot-account": @{
                                 @"margin-top": @5,
                                 @"size": NSStringFromCGSize(CGSizeMake(80, 20)),
                                 @"text": @"忘记帐号？",
                                 @"color": GFHexStringColor(@"#aaaaaa"),
                                 @"font-size": [UIFont systemFontOfSize:12],
                                 @"background-color": [UIColor clearColor],
                                 @"text-align": @(UIControlContentHorizontalAlignmentRight),
                                 },
                         @"next-step": @{
                                 @"background-color": GFHexStringColor(@"#4cc0fc"),
                                 @"text": @"下一步",
                                 @"color": [UIColor whiteColor],
                                 @"font-size": [UIFont systemFontOfSize:16],
                                 @"margin-top": @20,
                                 @"height": @35,
                                 },
                         },
                 @"retake-password": @{
                         @"top": @{
                                 @"margin": NSStringFromUIEdgeInsets(UIEdgeInsetsMake(30, 10, 0, 10)),
                                 @"text-prefix": @"验证通过，请为",
                                 @"text-suffix": @"设置新密码",
                                 @"color": GFHexStringColor(@"#424242"),
                                 @"font-size": [UIFont systemFontOfSize:15],
                                 @"background-color": [UIColor clearColor],
                                 },
                         @"input": @{
                                 @"border-color": GFHexStringColor(@"#dddddd"),
                                 @"border-width": @1,
                                 @"border-radius": @2,
                                 @"placeholder": @"请输入密码",
                                 @"color": [UIColor blackColor],
                                 @"font-size": [UIFont systemFontOfSize:15],
                                 @"placeholder-indent": NSStringFromUIEdgeInsets(UIEdgeInsetsMake(0, 8, 0, 0)),
                                 @"text-indent": NSStringFromUIEdgeInsets(UIEdgeInsetsMake(0, 6, 0, 0)),
                                 @"height": @35,
                                 @"margin-top": @15,
                                 },
                         @"reset-password":@{
                                 @"background-color": GFHexStringColor(@"#4cc0fc"),
                                 @"text": @"重置密码",
                                 @"color": [UIColor whiteColor],
                                 @"font-size": [UIFont systemFontOfSize:16],
                                 @"margin-top": @20,
                                 @"height": @35,
                                 },
                         },
                 @"choose-retake": @{
                         @"top": @{
                                 @"margin": NSStringFromUIEdgeInsets(UIEdgeInsetsMake(30, 10, 0, 10)),
                                 @"text": @"该帐号已绑定手机和邮箱，可选择其中一种方式来找回密码",
                                 @"color": GFHexStringColor(@"#424242"),
                                 @"font-size": [UIFont systemFontOfSize:15],
                                 @"background-color": [UIColor clearColor],
                                 @"height": @50,
                                 },
                         @"button-group": @{
                                 @"texts": @[@"手机找回", @"邮箱找回"],
                                 @"background-color": GFHexStringColor(@"#4cc0fc"),
                                 @"height": @35,
                                 @"margin-top": @20,
                                 @"padding": @15,
                                 @"font-size": [UIFont systemFontOfSize:15],
                                 @"color": [UIColor whiteColor],
                                 },
                         },
                 @"get-captcha": @{
                         @"top": @{
                                 @"text-prefix": @"已发送验证码至绑定",
                                 @"text-phone": @"手机",
                                 @"text-email": @"邮箱",
                                 @"text-align": @(NSTextAlignmentCenter),
                                 @"margin": NSStringFromUIEdgeInsets(UIEdgeInsetsMake(20, 10, 0, 10)),
                                 @"color": GFHexStringColor(@"#424242"),
                                 @"font-size": [UIFont systemFontOfSize:16],
                                 @"background-color": [UIColor clearColor],
                                 @"height": @50,
                                 },
                         @"send": @{
                                 @"normal-text": @"获取验证码",
                                 @"run-text-prefix": @"",
                                 @"run-text-suffix": @"S",
                                 @"end-text": @"重发",
                                 @"size": NSStringFromCGSize(CGSizeMake(90, 35)),
                                 @"margin-top": @15,
                                 @"background-color": GFHexStringColor(@"#4cc0fc"),
                                 @"font-size": [UIFont systemFontOfSize:14],
                                 @"color": [UIColor whiteColor],
                                 },
                         @"input": @{
                                 @"placeholder": @"请输入验证码",
                                 @"border-color": GFHexStringColor(@"#dddddd"),
                                 @"border-width": @1,
                                 @"border-radius": @2,
                                 @"color": [UIColor blackColor],
                                 @"font-size": [UIFont systemFontOfSize:15],
                                 @"placeholder-indent": NSStringFromUIEdgeInsets(UIEdgeInsetsMake(0, 8, 0, 0)),
                                 @"text-indent": NSStringFromUIEdgeInsets(UIEdgeInsetsMake(0, 6, 0, 0)),
                                 @"margin-right": @5,
                                 },
                         @"question":@{
                                 @"text": @"验证码收不到？",
                                 @"margin-top": @5,
                                 @"size": NSStringFromCGSize(CGSizeMake(90, 20)),
                                 @"color": GFHexStringColor(@"#aaaaaa"),
                                 @"font-size": [UIFont systemFontOfSize:12],
                                 @"background-color": [UIColor clearColor],
                                 @"text-align": @(UIControlContentHorizontalAlignmentRight),
                                 },
                         @"next-step": @{
                                 @"background-color": GFHexStringColor(@"#4cc0fc"),
                                 @"text": @"下一步",
                                 @"color": [UIColor whiteColor],
                                 @"font-size": [UIFont systemFontOfSize:16],
                                 @"margin-top": @20,
                                 @"height": @35,
                                 },
                         },
                 @"phone-login": @{
                         @"phone": @{
                                 @"left-text": @"手机号",
                                 @"left-width": @60,
                                 @"left-inset": NSStringFromUIEdgeInsets(UIEdgeInsetsMake(-0.5, 0, 0, 0)),
                                 @"margin": NSStringFromUIEdgeInsets(UIEdgeInsetsMake(30, 10, 0, 10)),
                                 @"placeholder": @"请输入手机号",
                                 @"border-color": GFHexStringColor(@"#dddddd"),
                                 @"border-width": @1,
                                 @"border-radius": @2,
                                 @"color": GFHexStringColor(@"#424242"),
                                 @"font-size": [UIFont systemFontOfSize:15],
                                 @"placeholder-indent": NSStringFromUIEdgeInsets(UIEdgeInsetsMake(0, 3+60, 0, 0)),
                                 @"text-indent": NSStringFromUIEdgeInsets(UIEdgeInsetsMake(0, 0+60, 0, 0)),
                                 @"margin-right": @5,
                                 @"height": @35,
                                 },
                         @"send": @{
                                 @"normal-text": @"获取验证码",
                                 @"run-text-prefix": @"",
                                 @"run-text-suffix": @"S",
                                 @"end-text": @"重发",
                                 @"size": NSStringFromCGSize(CGSizeMake(90, 35)),
                                 @"margin-top": @15,
                                 @"background-color": GFHexStringColor(@"#4cc0fc"),
                                 @"font-size": [UIFont systemFontOfSize:14],
                                 @"color": [UIColor whiteColor],
                                 },
                         @"captcha": @{
                                 @"left-text": @"验证码",
                                 @"left-width": @60,
                                 @"left-inset": NSStringFromUIEdgeInsets(UIEdgeInsetsMake(-0.5, 0, 0, 0)),
                                 @"placeholder": @"请输入验证码",
                                 @"border-color": GFHexStringColor(@"#dddddd"),
                                 @"border-width": @1,
                                 @"border-radius": @2,
                                 @"color": [UIColor blackColor],
                                 @"font-size": [UIFont systemFontOfSize:15],
                                 @"placeholder-indent": NSStringFromUIEdgeInsets(UIEdgeInsetsMake(0, 3+60, 0, 0)),
                                 @"text-indent": NSStringFromUIEdgeInsets(UIEdgeInsetsMake(0, 0+60, 0, 0)),
                                 @"margin-right": @5,
                                 },
                         @"question":@{
                                 @"text": @"验证码收不到？",
                                 @"margin-top": @5,
                                 @"size": NSStringFromCGSize(CGSizeMake(90, 20)),
                                 @"color": GFHexStringColor(@"#aaaaaa"),
                                 @"font-size": [UIFont systemFontOfSize:12],
                                 @"background-color": [UIColor clearColor],
                                 @"text-align": @(UIControlContentHorizontalAlignmentRight),
                                 },
                         @"login": @{
                                 @"background-color": GFHexStringColor(@"#4cc0fc"),
                                 @"text": @"登录",
                                 @"color": [UIColor whiteColor],
                                 @"font-size": [UIFont systemFontOfSize:16],
                                 @"margin-top": @20,
                                 @"height": @35,
                                 },
                         },
                 @"tourist-register": @{
                         @"textfield-group": @{
                                 @"left-texts": @[@"帐号", @"密码"],
                                 @"placeholders": @[@"请输入帐号", @"请输入密码"],
                                 @"left-width": @50,
                                 @"left-inset": NSStringFromUIEdgeInsets(UIEdgeInsetsMake(-0.5, 0, 0, 0)),
                                 @"margin": NSStringFromUIEdgeInsets(UIEdgeInsetsMake(20, 10, 0, 10)),
                                 @"border-color": GFHexStringColor(@"#dddddd"),
                                 @"border-width": @1,
                                 @"border-radius": @2,
                                 @"color": GFHexStringColor(@"#424242"),
                                 @"font-size": [UIFont systemFontOfSize:15],
                                 @"placeholder-indent": NSStringFromUIEdgeInsets(UIEdgeInsetsMake(0, 3+50, 0, 0)),
                                 @"text-indent": NSStringFromUIEdgeInsets(UIEdgeInsetsMake(0, 0+50, 0, 0)),
                                 @"padding": @10,
                                 @"height": @35,
                                 @"clean-mode": @(UITextFieldViewModeWhileEditing),
                                 },
                         @"register": @{
                                 @"background-color": GFHexStringColor(@"#4cc0fc"),
                                 @"text": @"立即转正",
                                 @"color": [UIColor whiteColor],
                                 @"font-size": [UIFont systemFontOfSize:16],
                                 @"margin-top": @20,
                                 @"height": @35,
                                 },
                         @"agreement": @{
                                 @"font-size": [UIFont systemFontOfSize:12],
                                 @"prefix-text": @"注册即同意",
                                 @"prefix-color": GFHexStringColor(@"#aaaaaa"),
                                 @"suffix-text": @"《好玩友用户协议》",
                                 @"suffix-color": GFHexStringColor(@"4cc0fc"),
                                 @"margin-top": @10,
                                 @"size": NSStringFromCGSize(CGSizeMake(180, 20)),
                                 },
                         @"h-line": @{
                                 @"height": @1,
                                 @"margin-top": @15,
                                 @"margin-h": NSStringFromUIEdgeInsets(UIEdgeInsetsMake(0, 30, 0, 30)),
                                 @"background-color": GFHexStringColor(@"#cccccc"),
                                 },
                         @"switch": @{
                                 @"background-color": [UIColor clearColor],
                                 @"text": @"切换帐号>",
                                 @"color": GFHexStringColor(@"4cc0fc"),
                                 @"font-size": [UIFont systemFontOfSize:16],
                                 @"margin-top": @10,
                                 @"size": NSStringFromCGSize(CGSizeMake(100, 30)),
                                 },
                         },
                 @"userlist-login": @{
                                     @"input": @{
                                                 //@"left-image": [UIImage imageNamed:@""],
                                                 @"left-width": @45,
                                                 //@"right-image": [UIImage imageNamed:@""],
                                                 @"right-width": @45,
                                                 @"left-inset": NSStringFromUIEdgeInsets(UIEdgeInsetsMake(-0.5, 0, 0, 0)),
                                                 @"margin": NSStringFromUIEdgeInsets(UIEdgeInsetsMake(40, 10, 0, 10)),
                                                 @"border-color": GFHexStringColor(@"#dddddd"),
                                                 @"border-width": @1,
                                                 @"border-radius": @2,
                                                 @"color": GFHexStringColor(@"#424242"),
                                                 @"font-size": [UIFont systemFontOfSize:15],
                                                 @"height": @35,
                                                 },
                                     @"login": @{
                                                 @"background-color": GFHexStringColor(@"#4cc0fc"),
                                                 @"text": @"登录",
                                                 @"color": [UIColor whiteColor],
                                                 @"font-size": [UIFont systemFontOfSize:16],
                                                 @"margin-top": @20,
                                                 @"height": @35,
                                                 },
                                     @"h-line": @{
                                                 @"height": @1,
                                                 @"margin-top": @70,
                                                 @"margin-h": NSStringFromUIEdgeInsets(UIEdgeInsetsMake(0, 30, 0, 30)),
                                                 @"background-color": GFHexStringColor(@"#cccccc"),
                                                 },
                                     @"switch": @{
                                                 @"background-color": [UIColor clearColor],
                                                 @"text": @"使用其他帐号登录>",
                                                 @"color": GFHexStringColor(@"4cc0fc"),
                                                 @"font-size": [UIFont systemFontOfSize:16],
                                                 @"margin-top": @10,
                                                 @"size": NSStringFromCGSize(CGSizeMake(180, 30)),
                                                 },
                                     },
                 @"username-login": @{
                                     @"textfield-group": @{
                                             @"left-texts": @[@"帐号", @"密码"],
                                             @"placeholders": @[@"请输入帐号", @"请输入密码"],
                                             @"left-width": @50,
                                             @"left-inset": NSStringFromUIEdgeInsets(UIEdgeInsetsMake(-0.5, 0, 0, 0)),
                                             @"margin": NSStringFromUIEdgeInsets(UIEdgeInsetsMake(40, 10, 0, 10)),
                                             @"border-color": GFHexStringColor(@"#dddddd"),
                                             @"border-width": @1,
                                             @"border-radius": @2,
                                             @"color": GFHexStringColor(@"#424242"),
                                             @"font-size": [UIFont systemFontOfSize:15],
                                             @"placeholder-indent": NSStringFromUIEdgeInsets(UIEdgeInsetsMake(0, 3+50, 0, 0)),
                                             @"text-indent": NSStringFromUIEdgeInsets(UIEdgeInsetsMake(0, 0+50, 0, 0)),
                                             @"padding": @15,
                                             @"height": @35,
                                             @"clean-mode": @(UITextFieldViewModeWhileEditing),
                                                       },
                                     @"forgot-password": @{
                                             @"text": @"忘记密码？",
                                             @"margin-top": @5,
                                             @"size": NSStringFromCGSize(CGSizeMake(70, 20)),
                                             @"color": GFHexStringColor(@"#aaaaaa"),
                                             @"font-size": [UIFont systemFontOfSize:12],
                                             @"background-color": [UIColor clearColor],
                                             @"text-align": @(UIControlContentHorizontalAlignmentRight),
                                                           },
                                     @"login": @{
                                             @"background-color": GFHexStringColor(@"#4cc0fc"),
                                             @"text": @"登录",
                                             @"color": [UIColor whiteColor],
                                             @"font-size": [UIFont systemFontOfSize:16],
                                             @"margin-top": @20,
                                             @"height": @35,
                                                 },
                                     },
                 @"username-register": @{
                         @"textfield-group": @{
                                 @"left-texts": @[@"帐号", @"密码"],
                                 @"placeholders": @[@"请输入帐号", @"请输入密码"],
                                 @"left-width": @50,
                                 @"left-inset": NSStringFromUIEdgeInsets(UIEdgeInsetsMake(-0.5, 0, 0, 0)),
                                 @"margin": NSStringFromUIEdgeInsets(UIEdgeInsetsMake(40, 10, 0, 10)),
                                 @"border-color": GFHexStringColor(@"#dddddd"),
                                 @"border-width": @1,
                                 @"border-radius": @2,
                                 @"color": GFHexStringColor(@"#424242"),
                                 @"font-size": [UIFont systemFontOfSize:15],
                                 @"placeholder-indent": NSStringFromUIEdgeInsets(UIEdgeInsetsMake(0, 3+50, 0, 0)),
                                 @"text-indent": NSStringFromUIEdgeInsets(UIEdgeInsetsMake(0, 0+50, 0, 0)),
                                 @"padding": @15,
                                 @"height": @35,
                                 @"clean-mode": @(UITextFieldViewModeWhileEditing),
                                 @"tips": @[@"", @""],
                                 },
                         @"register": @{
                                 @"background-color": GFHexStringColor(@"#4cc0fc"),
                                 @"text": @"注册",
                                 @"color": [UIColor whiteColor],
                                 @"font-size": [UIFont systemFontOfSize:16],
                                 @"margin-top": @20,
                                 @"height": @35,
                                 },
                         @"agreement": @{
                                 @"font-size": [UIFont systemFontOfSize:12],
                                 @"prefix-text": @"注册即同意",
                                 @"prefix-color": GFHexStringColor(@"#aaaaaa"),
                                 @"suffix-text": @"《好玩友用户协议》",
                                 @"suffix-color": GFHexStringColor(@"4cc0fc"),
                                 @"margin-top": @10,
                                 @"size": NSStringFromCGSize(CGSizeMake(180, 20)),
                                 },
                         },
                 };
    }
    return _sheet;
}

@end


id GFEntryStyle(NSString * identifier) {
    NSArray * array = [identifier componentsSeparatedByString:@"."];
    if (array.count == 1) {
        return [GFEntryStyleManager sharedInstance].sheet[array[0]];
    } else if (array.count == 2) {
        return [GFEntryStyleManager sharedInstance].sheet[array[0]][array[1]];
    } else if (array.count == 3) {
        return [GFEntryStyleManager sharedInstance].sheet[array[0]][array[1]][array[2]];
    }
    return nil;
}
