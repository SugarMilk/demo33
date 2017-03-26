//
//  GFDemoItemView.h
//  Pods
//
//  Created by sdk－app11 on 17/1/18.
//
//

#import <UIKit/UIKit.h>

@interface GFDemoItemView : UIView

@property (nonatomic, copy) void (^buttonClickedOperationBlock)(GFDemoItemView *item);

@property (nonatomic, strong) UIImage *iconImage;

@property (nonatomic, strong) NSString *btnContext;

+(instancetype)itemWithIconImage:(UIImage *)image
                      btnContext:(NSString *)btnContext
                      clickBlock:(void (^)(GFDemoItemView *item))block;


@end
