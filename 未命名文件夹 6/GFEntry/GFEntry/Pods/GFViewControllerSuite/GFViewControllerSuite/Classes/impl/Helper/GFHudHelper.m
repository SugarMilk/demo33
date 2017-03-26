

#import "GFHudHelper.h"
#import "UIView+Toast.h"

@implementation GFHudHelper

+ (instancetype)defaultHelper{
    static dispatch_once_t onceToken;
    static GFHudHelper *defaultHelper;
    dispatch_once(&onceToken, ^{
        defaultHelper = [[self alloc] init];
    });
    return defaultHelper;
}

-(void)showToastMessage:(NSString *)message{
    if (!message) {
        [GFLogger debug:@"can not toast nil str"];
        return;
    }
    [GFLogger debug:message];
    UIView *view = [[UIApplication sharedApplication]keyWindow].rootViewController.view;
    [CSToastManager setQueueEnabled:NO];
    [view makeToast:message duration:1 position:CSToastPositionCenter];
}

-(void)showToastMessageAtBottom:(NSString *)message{
    [GFLogger debug:message];
    UIView *view = [[UIApplication sharedApplication]keyWindow].rootViewController.view;
    [CSToastManager setQueueEnabled:NO];
    [view makeToast:message duration:1 position:CSToastPositionBottom];
}

@end
