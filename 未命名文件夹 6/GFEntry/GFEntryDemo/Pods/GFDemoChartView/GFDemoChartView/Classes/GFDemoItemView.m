//
//  GFDemoItemView.m
//  Pods
//
//  Created by sdk－app11 on 17/1/18.
//
//

#import "GFDemoItemView.h"
#import "UIView+LayoutMethods.h"

@interface GFDemoItemView ()
@property (nonatomic ,strong) UIButton *button;
@property (nonatomic ,strong) UIButton *iconView;
@end

@implementation GFDemoItemView

+(instancetype)itemWithIconImage:(UIImage *)image
                      btnContext:(NSString *)btnContext
                      clickBlock:(void (^)(GFDemoItemView *item))block{
    GFDemoItemView *demoItemView = [[GFDemoItemView alloc] init];
    demoItemView.iconImage = image;
    demoItemView.btnContext = btnContext;
    
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:btnContext forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    [button addTarget:demoItemView action:@selector(btnClicked) forControlEvents:UIControlEventTouchUpInside];
    demoItemView.button = button;
    [demoItemView addSubview:demoItemView.button];
    
    UIButton *icon = [[UIButton alloc] init];
    [icon setImage:image forState:UIControlStateNormal];
    [icon addTarget:demoItemView action:@selector(btnClicked) forControlEvents:UIControlEventTouchUpInside];
    [demoItemView addSubview:icon];
    demoItemView.iconView = icon;
    demoItemView.buttonClickedOperationBlock = block;
    return demoItemView;
}

-(void)btnClicked{
    if (self.buttonClickedOperationBlock) {
        self.buttonClickedOperationBlock(self);
    }
}

#pragma mark - life circles

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat margin = 10;
    _iconView.frame = CGRectMake(margin, margin, self.height-margin*2, self.height-margin*4);
    _button.frame = CGRectMake(margin, _iconView.height+margin, self.width-margin*2, margin*2);
    _iconView.center = CGPointMake(self.width/2, _iconView.centerY);
    _button.center = CGPointMake(_iconView.centerX, _button.centerY);
}


@end
