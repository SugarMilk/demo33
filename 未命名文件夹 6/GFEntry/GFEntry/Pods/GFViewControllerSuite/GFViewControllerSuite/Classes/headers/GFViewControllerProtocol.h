//
//  GFViewControllerProtocol.h
//  Pods
//
//  Created by sdk－app11 on 17/3/14.
//
//

#import <UIKit/UIKit.h>

/**
 控制器 AOP
 */
@protocol GFViewControllerInterceptor <NSObject>

@optional

-(void)beforeCloseController:(UIViewController *)controller;
-(void)afterCloseController:(UIViewController *)controller;

//是否允许关闭当前controller
-(BOOL)shouldCloseController:(UIViewController *)controller;

@end

@protocol GFViewControllerBackActionDelegate <NSObject>

-(void)takeBackAction:(UIViewController *)controller;

@end
