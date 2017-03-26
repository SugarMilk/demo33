//
//  UIViewController+MJPopupViewController.h
//  MJModalViewController
//
//  Created by Martin Juhasz on 11.05.12.
//  Copyright (c) 2012 martinjuhasz.de. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 !注意本代码根据业务需求修改了部分原有的代码逻辑，原代码的下载地址在:
 https://github.com/martinjuhasz/MJPopupViewController
 By lds
 */

typedef enum {
    MJPopupViewAnimationSlideBottomTop = 1,
    MJPopupViewAnimationSlideRightLeft,
    MJPopupViewAnimationSlideBottomBottom,
    MJPopupViewAnimationFade
} MJPopupViewAnimation;

@interface UIViewController (MJPopupViewController)

- (void)presentPopupViewController:(UIViewController*)popupViewController animationType:(MJPopupViewAnimation)animationType;

- (void)presentPopupViewController:(UIViewController*)popupViewController animationType:(MJPopupViewAnimation)animationType completion:(void(^)(BOOL finished))completion;

- (void)dismissPopupViewControllerWithanimationType:(MJPopupViewAnimation)animationType;

- (void)dismissPopupViewControllerWithanimationType:(MJPopupViewAnimation)animationType completion:(void(^)(BOOL finished))completion;

@end
