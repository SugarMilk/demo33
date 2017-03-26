//
//  GFAgreementViewController.m
//  GFEntry
//
//  Created by huangjian on 17/3/22.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import "GFAgreementViewController.h"
#import <Masonry/Masonry.h>

@interface GFAgreementViewController ()

@property (nonatomic, strong) UIView * agreementView;

@end

@implementation GFAgreementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.contentView addSubview:self.agreementView];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    [self.agreementView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).with.insets(UIEdgeInsetsMake(10, 10, 10, 10));
    }];
}

- (UIView *)agreementView {
    if (_agreementView == nil) {
        _agreementView = [[UIView alloc] init];
        _agreementView.backgroundColor = [UIColor cyanColor];
    }
    return _agreementView;
}

@end
