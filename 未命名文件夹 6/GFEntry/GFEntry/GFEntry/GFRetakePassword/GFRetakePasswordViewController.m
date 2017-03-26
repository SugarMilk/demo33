//
//  GFRetakePasswordViewController.m
//  GFEntry
//
//  Created by huangjian on 17/3/22.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import "GFRetakePasswordViewController.h"
#import "GFRetakePasswordView.h"
#import <Masonry/Masonry.h>

@interface GFRetakePasswordViewController ()

@property (nonatomic, strong) GFRetakePasswordView * retakePasswordView;

@end

@implementation GFRetakePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.contentView addSubview:self.retakePasswordView];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    [self.retakePasswordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).with.insets(UIEdgeInsetsMake(50, 10, 10, 10));
    }];
}

- (GFRetakePasswordView *)retakePasswordView {
    if (_retakePasswordView == nil) {
        _retakePasswordView = [[GFRetakePasswordView alloc] init];
//        _retakePasswordView.backgroundColor = [UIColor cyanColor];
    }
    return _retakePasswordView;
}

@end
