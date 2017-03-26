//
//  GFForgotPasswordViewController.m
//  GFEntry
//
//  Created by huangjian on 17/3/22.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import "GFForgotPasswordViewController.h"
#import "GFForgotPasswordView.h"
#import <Masonry/Masonry.h>

@interface GFForgotPasswordViewController ()

@property (nonatomic, strong) GFForgotPasswordView * forgotPasswordView;

@end

@implementation GFForgotPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.contentView addSubview:self.forgotPasswordView];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    [self.forgotPasswordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).with.insets(UIEdgeInsetsMake(50, 10, 10, 10));
    }];
}

- (GFForgotPasswordView *)forgotPasswordView {
    if (_forgotPasswordView == nil) {
        _forgotPasswordView = [[GFForgotPasswordView alloc] init];
//        _forgotPasswordView.backgroundColor = [UIColor cyanColor];
    }
    return _forgotPasswordView;
}

@end
