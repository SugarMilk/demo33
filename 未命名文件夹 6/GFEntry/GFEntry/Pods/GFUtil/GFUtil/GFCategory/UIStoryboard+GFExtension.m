//
//  UIStoryboard+GFExtension.m
//  GFUtil
//
//  Created by huangjian on 17/3/20.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import "UIStoryboard+GFExtension.h"

@implementation UIStoryboard (GFExtension)

+ (id)gf_storyboardWithName:(NSString *)name identifier:(NSString *)identifier {
    UIStoryboard * storyboard = [self storyboardWithName:name bundle:nil];
    UIViewController * viewController;
    if (identifier) {
        viewController = [storyboard instantiateViewControllerWithIdentifier:identifier];
    } else {
        viewController = [storyboard instantiateInitialViewController];
    }
    return viewController;
}

@end
