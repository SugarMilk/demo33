//
//  UIViewController+MJPopupViewController.m
//  MJModalViewController
//
//  Created by Martin Juhasz on 11.05.12.
//  Copyright (c) 2012 martinjuhasz.de. All rights reserved.
//

#import "UIViewController+MJPopupViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "MJPopupBackgroundView.h"
#import <objc/runtime.h>

#define kPopupModalAnimationDuration 0.2
#define kMJSourceViewTag 23941
#define kMJPopupViewTag 23942
#define kMJBackgroundViewTag 23943
#define kMJOverlayViewTag 23945

@interface UIViewController (MJPopupViewControllerPrivate)
- (UIView*)topView;
- (void)presentPopupView:(UIView*)popupView;



@end

////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Public

@implementation UIViewController (MJPopupViewController)

- (void)presentPopupViewController:(UIViewController*)popupViewController animationType:(MJPopupViewAnimation)animationType{
    [self presentPopupViewController:popupViewController animationType:animationType completion:nil];
}

- (void)presentPopupViewController:(UIViewController*)popupViewController animationType:(MJPopupViewAnimation)animationType completion:(void(^)(BOOL finished))completion
{
    [self addChildViewController:popupViewController];
    [self presentPopupView:popupViewController.view animationType:animationType completion:completion];
}

- (void)dismissPopupViewControllerWithanimationType:(MJPopupViewAnimation)animationType{
    [self dismissPopupViewControllerWithanimationType:animationType completion:nil];
}

- (void)dismissPopupViewControllerWithanimationType:(MJPopupViewAnimation)animationType completion:(void(^)(BOOL finished))completion
{
    UIView *sourceView = [self topView];
    UIView *popupView = [sourceView viewWithTag:kMJPopupViewTag];
    UIView *overlayView = [sourceView viewWithTag:kMJOverlayViewTag];

    
    if(animationType == MJPopupViewAnimationSlideBottomTop || animationType == MJPopupViewAnimationSlideBottomBottom || animationType == MJPopupViewAnimationSlideRightLeft) {
        [self slideViewOut:popupView sourceView:sourceView overlayView:overlayView withAnimationType:animationType completion:completion];
      }
    else {
        [self fadeViewOut:popupView sourceView:sourceView overlayView:overlayView completion:completion];
    }
}



////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark View Handling

- (void)presentPopupView:(UIView*)popupView animationType:(MJPopupViewAnimation)animationType completion:(void(^)(BOOL finished))completion
{
    UIView *sourceView = [self topView];
    sourceView.tag = kMJSourceViewTag;
    popupView.tag = kMJPopupViewTag;
    
    // check if source view controller is not in destination
    if ([sourceView.subviews containsObject:popupView]) return;
    
    // customize popupView
    popupView.layer.shadowPath = [UIBezierPath bezierPathWithRect:popupView.bounds].CGPath;
    popupView.layer.masksToBounds = NO;
    popupView.layer.shadowOffset = CGSizeMake(5, 5);
    popupView.layer.shadowRadius = 5;
    popupView.layer.shadowOpacity = 0.5;
    // Add semi overlay
    UIView *overlayView = [[UIView alloc] initWithFrame:sourceView.bounds];
    overlayView.tag = kMJOverlayViewTag;
    overlayView.backgroundColor = [UIColor clearColor];

    // BackgroundView
    MJPopupBackgroundView *backgroundView = [[MJPopupBackgroundView alloc] initWithFrame:sourceView.bounds];
    backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    backgroundView.tag = kMJBackgroundViewTag;
    backgroundView.backgroundColor = [UIColor clearColor];
    backgroundView.alpha = 0.0f;
    [overlayView addSubview:backgroundView];
    // Make the Background Clickable
    UIButton * dismissButton = [UIButton buttonWithType:UIButtonTypeCustom];
    dismissButton.backgroundColor = [UIColor clearColor];
    dismissButton.frame = sourceView.bounds;
    [overlayView addSubview:dismissButton];
    popupView.alpha = 0.0f;
    [overlayView addSubview:popupView];
    CGRect frame;
    //iOS6
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_7_0)
    {
        frame = popupView.frame;
    }
    [sourceView addSubview:overlayView];
    
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_7_0)
    {
        [popupView setFrame:frame];
        popupView.center = CGPointMake(sourceView.frame.size.width/2, sourceView.frame.size.height/2);
    }

    if(animationType == MJPopupViewAnimationSlideBottomTop) {
        [self slideViewIn:popupView sourceView:sourceView overlayView:overlayView withAnimationType:animationType completion:completion];
    } else if (animationType == MJPopupViewAnimationSlideRightLeft) {
        [self slideViewIn:popupView sourceView:sourceView overlayView:overlayView withAnimationType:animationType completion:completion];
    } else if (animationType == MJPopupViewAnimationSlideBottomBottom) {
        [self slideViewIn:popupView sourceView:sourceView overlayView:overlayView withAnimationType:animationType completion:completion];
    } else {
        [self fadeViewIn:popupView sourceView:sourceView overlayView:overlayView completion:completion];
    }
    
    [dismissButton addTarget:self action:@selector(dismissButtonAction) forControlEvents:UIControlEventTouchUpInside];
}

-(UIView*)topView {
    UIViewController *recentView = self;
    
    while (recentView.parentViewController != nil) {
        recentView = recentView.parentViewController;
    }
    return recentView.view;
}

// TODO: find a better way to do this, thats horrible


- (void)dismissPopupViewControllerWithanimationTypeFade
{
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade completion:nil];
}



//////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Animations

#pragma mark --- Slide

- (void)slideViewIn:(UIView*)popupView sourceView:(UIView*)sourceView overlayView:(UIView*)overlayView withAnimationType:(MJPopupViewAnimation)animationType completion:(void(^)(BOOL finished))completion
{
    UIView *backgroundView = [overlayView viewWithTag:kMJBackgroundViewTag];
    // Generating Start and Stop Positions
    CGSize sourceSize = sourceView.bounds.size;
    CGSize popupSize = popupView.bounds.size;
    CGRect popupStartRect;
    if(animationType == MJPopupViewAnimationSlideBottomTop || animationType == MJPopupViewAnimationSlideBottomBottom) {
        popupStartRect = CGRectMake((sourceSize.width - popupSize.width) / 2, 
                                    sourceSize.height, 
                                    popupSize.width, 
                                    popupSize.height);
    } else {
        popupStartRect = CGRectMake(sourceSize.width, 
                                    (sourceSize.height - popupSize.height) / 2,
                                    popupSize.width, 
                                    popupSize.height);
    }
    CGRect popupEndRect = CGRectMake((sourceSize.width - popupSize.width) / 2, 
                                     (sourceSize.height - popupSize.height) / 2,
                                     popupSize.width, 
                                     popupSize.height);
    
    // Set starting properties
    popupView.frame = popupStartRect;
    popupView.alpha = 1.0f;
    [UIView animateWithDuration:kPopupModalAnimationDuration delay:0.0f options:UIViewAnimationCurveEaseOut animations:^{
        backgroundView.alpha = 1.0f;
        popupView.frame = popupEndRect;
    } completion:^(BOOL finished) {
        
        completion(finished);
    }];
}

- (void)slideViewOut:(UIView*)popupView sourceView:(UIView*)sourceView overlayView:(UIView*)overlayView withAnimationType:(MJPopupViewAnimation)animationType completion:(void(^)(BOOL finished))completion
{
    UIView *backgroundView = [overlayView viewWithTag:kMJBackgroundViewTag];
    // Generating Start and Stop Positions
    CGSize sourceSize = sourceView.bounds.size;
    CGSize popupSize = popupView.bounds.size;
    CGRect popupEndRect;
    if(animationType == MJPopupViewAnimationSlideBottomTop) {
        popupEndRect = CGRectMake((sourceSize.width - popupSize.width) / 2, 
                                  -popupSize.height, 
                                  popupSize.width, 
                                  popupSize.height);
    } else if(animationType == MJPopupViewAnimationSlideBottomBottom) {
        popupEndRect = CGRectMake((sourceSize.width - popupSize.width) / 2, 
                                  sourceSize.height, 
                                  popupSize.width, 
                                  popupSize.height);
    } else {
        popupEndRect = CGRectMake(-popupSize.width, 
                                  popupView.frame.origin.y, 
                                  popupSize.width, 
                                  popupSize.height);
    }
    
    [UIView animateWithDuration:kPopupModalAnimationDuration delay:0.0f options:UIViewAnimationCurveEaseIn animations:^{
        popupView.frame = popupEndRect;
        backgroundView.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [popupView removeFromSuperview];
        [overlayView removeFromSuperview];
        
        completion(finished);
    }];
}

#pragma mark --- Fade

- (void)fadeViewIn:(UIView*)popupView sourceView:(UIView*)sourceView overlayView:(UIView*)overlayView completion:(void(^)(BOOL finished))completion
{
    UIView *backgroundView = [overlayView viewWithTag:kMJBackgroundViewTag];
    // Generating Start and Stop Positions
    CGSize sourceSize = sourceView.bounds.size;
    CGSize popupSize = popupView.bounds.size;
    CGRect popupEndRect = CGRectMake((sourceSize.width - popupSize.width) / 2,
                                     (sourceSize.height - popupSize.height) / 2,
                                     popupSize.width, 
                                     popupSize.height);
    
    // Set starting properties
    popupView.frame = popupEndRect;
    popupView.alpha = 0.0f;
    
    [UIView animateWithDuration:kPopupModalAnimationDuration animations:^{
        backgroundView.alpha = 0.5f;
        popupView.alpha = 1.0f;
    } completion:^(BOOL finished) {
        
        completion(finished);
    }];
}

- (void)fadeViewOut:(UIView*)popupView sourceView:(UIView*)sourceView overlayView:(UIView*)overlayView completion:(void(^)(BOOL finished))completion
{
    UIView *backgroundView = [overlayView viewWithTag:kMJBackgroundViewTag];
    [UIView animateWithDuration:kPopupModalAnimationDuration animations:^{
        backgroundView.alpha = 0.0f;
        popupView.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [popupView removeFromSuperview];
        [overlayView removeFromSuperview];
        
        completion(finished);
    }];
}

-(void)dismissButtonAction{
//    //因为动画异步，添加以下代码防止动画过程中导致的按钮无法点击
//    if ([BJVCMediator defaultMediator].isAnimating||![BJVCMediator defaultMediator].currentController) {
//        return;
//    }
//    if ([BJVCMediator defaultMediator].keyboardIsVisible) {
//        [[[UIApplication sharedApplication]keyWindow] endEditing:YES];
//        [BJVCMediator defaultMediator].keyboardIsVisible = NO;
//        return;
//    }
//    switch ([BJVCMediator defaultMediator].currentVCBackType) {
//        case BJVCBackTypeClose:
//            //            [self dismissPopupViewControllerWithanimationTypeFade];
//            [[BJVCMediator defaultMediator] closeController:[BJVCMediator defaultMediator].currentController];
//            break;
//        case BJVCBackTypeDefault:
//            [[BJVCMediator defaultMediator] jumpBackFrom:[BJVCMediator defaultMediator].currentController withParams:nil];
//            break;
//        case BJVCBackTypePopWithAnimat:
//            [[BJVCMediator defaultMediator] jumpBackFrom:[BJVCMediator defaultMediator].currentController withParams:nil];
//            break;
//        case BJVCBackTypePopWithNoAnimat:
//            [[BJVCMediator defaultMediator] jumpBackFrom:[BJVCMediator defaultMediator].currentController withParams:nil];
//            break;
//        case BJVCBackTypeForbidden:
//            break;
//        default:
//            break;
//    }
}
@end
