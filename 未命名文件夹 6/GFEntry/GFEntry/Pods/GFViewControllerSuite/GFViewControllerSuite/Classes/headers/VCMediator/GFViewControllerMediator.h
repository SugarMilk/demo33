//
//  GFViewControllerMediator.h
//  Pods
//
//  Created by sdk－app11 on 17/3/15.
//
//

#import <Foundation/Foundation.h>

//跳转类型
typedef NS_ENUM(NSUInteger, GFControllerAnimationType)
{
    GFControllerAnimationTypeDefault =0,          //默认替换效果，用新的vc取代当前vc，当前消失
    GFControllerAnimationTypePushWithAnimat,                //Push效果,有动画
    GFControllerAnimationTypePushWithNoAnimat,              //Push效果,没有动画（比如从注册界面进入用户协议界面）
};

//返回类型
typedef NS_ENUM(NSUInteger, GFControllerAnimationBackType)
{
    GFControllerAnimationBackTypeDefault =0,          //默认替换效果，当前消失，用当前的parent返回
    GFControllerAnimationBackTypePopWithAnimat,       //Pop效果,有动画
    GFControllerAnimationBackTypePopWithNoAnimat,       //Pop效果,没有动画 （比如从用户协议界面返回注册界面）
    GFControllerAnimationBackTypeClose,                 //顶层，无需返回，直接关闭
};

@interface GFViewControllerMediator : NSObject

//rootViewController 可以被设置
@property (nonatomic ,strong) UIViewController *rootViewController;

+(instancetype)defaultMediator;

/**
 展现一个viewcontroller
 */
-(void)presentViewController:(UIViewController *)presentController hasNavigationController:(BOOL)hasNavigationController;

/**
 @param hasNavigationController 是否后续包含pushviewcontroller操作，包含则需要额外构造navigationController 构造由Mediator完成
 */
-(void)presentViewController:(UIViewController *)presentController hasNavigationController:(BOOL)hasNavigationController completion:(void(^)(BOOL finished))completion;

/**
 从某个viewcontroller跳转至下一个viewcontroller
 */
-(void)jumpToViewController:(UIViewController *)viewController fromViewController:(UIViewController *)fromViewController animationType:(GFControllerAnimationType)animationType hasNavigationController:(BOOL)hasNavigationController;

-(void)jumpToViewController:(UIViewController *)viewController fromViewController:(UIViewController *)fromViewController animationType:(GFControllerAnimationType)animationType hasNavigationController:(BOOL)hasNavigationController completion:(void(^)(BOOL finished))completion;

/**
 跳转回viewcontroller
 */
-(void)jumpBackFromViewController:(UIViewController *)fromViewController animationType:(GFControllerAnimationBackType)animationType;

/**
 跳转回viewcontroller
 */
-(void)jumpBackFromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController hasNavigationController:(BOOL)hasNavigationController animationType:(GFControllerAnimationBackType)animationType;

-(void)closeController:(UIViewController *)viewController;

@end
