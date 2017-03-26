//
//  GFUserNameRegisterMediator.m
//  GFEntry
//
//  Created by huangjian on 17/3/21.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import "GFUserNameRegisterMediator.h"
#import "GFUserNameRegisterViewController.h"
#import "GFViewControllerMediator.h"

#import "GFTouristRegisterViewController.h"
#import "GFMobilePhoneLoginViewController.h"
#import "GFUserListLoginViewController.h"
#import "GFAgreementViewController.h"
#import "GFForgotPasswordViewController.h"
#import "GFGetCaptchaViewController.h"
#import "GFRetakePasswordViewController.h"
#import "GFChooseRetakeViewController.h"
#import "GFUserNameLoginViewController.h"
#import "GFEntranceViewController.h"

@interface GFUserNameRegisterMediator () <GFViewControllerBackActionDelegate>

@end

@implementation GFUserNameRegisterMediator

+ (instancetype)sharedInstance {
    static GFUserNameRegisterMediator * instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

+ (void)openEntrance:(UIViewController *)viewController {
    [[self sharedInstance] openEntrance:viewController];
}

- (void)openEntrance:(UIViewController *)viewController {
    GFUserNameRegisterViewController * registerVC = [[GFUserNameRegisterViewController alloc] init];
    registerVC.view.frame = CGRectMake(0, 0, 300, 300);
    registerVC.view.backgroundColor = [UIColor whiteColor];
    registerVC.backDelegate = self;
    [[GFViewControllerMediator defaultMediator] setRootViewController:viewController];
    [[GFViewControllerMediator defaultMediator] presentViewController:registerVC hasNavigationController:YES];
}

- (void)takeBackAction:(UIViewController *)controller {
    NSLog(@"----");
}

@end
