//
//  GFGetCaptchaViewController.m
//  GFEntry
//
//  Created by huangjian on 17/3/22.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import "GFGetCaptchaViewController.h"
#import "GFGetCaptchaView.h"
#import <Masonry/Masonry.h>

@interface GFGetCaptchaViewController ()

@property (nonatomic, strong) GFGetCaptchaView * getCaptchaView;

@end

@implementation GFGetCaptchaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.contentView addSubview:self.getCaptchaView];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    [self.getCaptchaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).with.insets(UIEdgeInsetsMake(50, 10, 10, 10));
    }];
}

- (GFGetCaptchaView *)getCaptchaView {
    if (_getCaptchaView == nil) {
        _getCaptchaView = [[GFGetCaptchaView alloc] init];
//        _getCaptchaView.backgroundColor = [UIColor cyanColor];
    }
    return _getCaptchaView;
}

@end
