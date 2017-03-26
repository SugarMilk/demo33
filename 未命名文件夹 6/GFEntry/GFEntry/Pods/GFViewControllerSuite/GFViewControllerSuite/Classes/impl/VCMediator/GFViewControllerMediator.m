//
//  GFViewControllerMediator.m
//  Pods
//
//  Created by sdk－app11 on 17/3/15.
//
//

#import "GFViewControllerMediator.h"
#import "UIViewController+MJPopupViewController.h"

@interface GFViewControllerMediator ()

@property (nonatomic ,assign) BOOL isAnimating;

@end

@implementation GFViewControllerMediator

#pragma mark - public method
+ (instancetype)defaultMediator{
    static dispatch_once_t onceToken;
    static GFViewControllerMediator *sharedInstance = nil;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[GFViewControllerMediator alloc] init];
            });
    return sharedInstance;
}

-(void)presentViewController:(UIViewController *)presentController hasNavigationController:(BOOL)hasNavigationController{
    [self presentViewController:presentController hasNavigationController:hasNavigationController completion:nil];
}

-(void)presentViewController:(UIViewController *)presentController hasNavigationController:(BOOL)hasNavigationController completion:(void(^)(BOOL finished))completion{
    
    self.isAnimating= YES;
    [self waitForLastAnimating];
    
    UINavigationController * rootNavigationController =nil;
    if(hasNavigationController){
        rootNavigationController = [[UINavigationController alloc] initWithRootViewController:presentController];
        [rootNavigationController.view setFrame:presentController.view.frame];
        [rootNavigationController setNavigationBarHidden:YES];
    }
    [self.rootViewController  presentPopupViewController: hasNavigationController ? rootNavigationController :  presentController animationType:MJPopupViewAnimationFade completion:^(BOOL finished) {
        self.isAnimating= NO;
    }];
}

-(void)jumpToViewController:(UIViewController *)viewController fromViewController:(UIViewController *)fromViewController animationType:(GFControllerAnimationType)animationType hasNavigationController:(BOOL)hasNavigationController{
    [self jumpToViewController:viewController fromViewController:fromViewController animationType:animationType hasNavigationController:hasNavigationController completion:nil];
}

-(void)jumpToViewController:(UIViewController *)viewController fromViewController:(UIViewController *)fromViewController animationType:(GFControllerAnimationType)animationType hasNavigationController:(BOOL)hasNavigationController completion:(void(^)(BOOL finished))completion{
    
    self.isAnimating= YES;
    
    switch (animationType) {
        case GFControllerAnimationTypeDefault:
        {
            [self closeController:fromViewController completion:^(BOOL finished) {
                if (finished) {
                    [self presentViewController:viewController hasNavigationController:hasNavigationController completion:^(BOOL finished) {
                        self.isAnimating= NO;
                        if (completion) {
                            completion(finished);
                        }
                    }];
                }
            }];
        }
            break;
        case GFControllerAnimationTypePushWithAnimat:
        {
            [fromViewController.navigationController pushViewController:viewController animated:YES];
            if (completion) {
                completion(YES);
            }
            self.isAnimating= NO;
        }
            break;
            
        case GFControllerAnimationTypePushWithNoAnimat:
        {
            [fromViewController.navigationController pushViewController:viewController animated:NO];
            if (completion) {
                completion(YES);
            }
            self.isAnimating= NO;
        }
            break;
        default:
            break;
    }
}

-(void)jumpBackFromViewController:(UIViewController *)fromViewController animationType:(GFControllerAnimationBackType)animationType{
    [self jumpBackFromViewController:fromViewController toViewController:nil hasNavigationController:NO animationType:animationType];
}

-(void)jumpBackFromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController hasNavigationController:(BOOL)hasNavigationController animationType:(GFControllerAnimationBackType)animationType{
    
    if (!toViewController && animationType == GFControllerAnimationBackTypeDefault) {
        [GFLogger debug:@"toViewController can not be nil when animationType is GFControllerAnimationBackTypeDefault"];
        return;
    }
    
    self.isAnimating= YES;
    [self waitForLastAnimating];
    
    switch (animationType) {
        case GFControllerAnimationBackTypeDefault:
        {
            [self closeController:fromViewController];
            [self presentViewController:toViewController hasNavigationController:hasNavigationController completion:^(BOOL finished) {
                self.isAnimating= NO;
            }];
        }
            break;
        case GFControllerAnimationBackTypePopWithAnimat:
        {
            [fromViewController.navigationController popViewControllerAnimated:YES];
            self.isAnimating= NO;
        }
            break;
        case GFControllerAnimationBackTypePopWithNoAnimat:
        {
            [fromViewController.navigationController popViewControllerAnimated:NO];
            self.isAnimating= NO;
        }
            break;
        case GFControllerAnimationBackTypeClose:
        {
            [self.rootViewController dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade completion:^(BOOL finished) {
                self.isAnimating= NO;
            }];
        }
            break;
        default:
            break;
    }
}

-(void)closeController:(UIViewController *)viewController{
    [self closeController:viewController completion:nil];
}

-(void)closeController:(UIViewController *)viewController completion:(void(^)(BOOL finished))completion{
    
    self.isAnimating = YES;
    [self waitForLastAnimating];
    
    [self.rootViewController dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade completion:^(BOOL finished) {
        self.isAnimating = NO;
        if (completion) {
            completion(finished);
        }
    }];
}

#pragma mark - NSRunloop for wait last the animating is over
-(void)waitForLastAnimating{
    while (!_isAnimating) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }
}


@end
