//
//  GFMobilePhoneLoginViewController.m
//  GFEntry
//
//  Created by huangjian on 17/3/21.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import "GFMobilePhoneLoginViewController.h"
#import "GFMobilePhoneLoginView.h"
#import <Masonry/Masonry.h>

@interface GFMobilePhoneLoginViewController ()

@property (nonatomic, strong) GFMobilePhoneLoginView * mobilePhoneLoginView;

@end

@implementation GFMobilePhoneLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.contentView addSubview:self.mobilePhoneLoginView];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    [self.mobilePhoneLoginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).with.insets(UIEdgeInsetsMake(50, 10, 10, 10));
    }];
}

- (GFMobilePhoneLoginView *)mobilePhoneLoginView {
    if (_mobilePhoneLoginView == nil) {
        _mobilePhoneLoginView = [[GFMobilePhoneLoginView alloc] init];
//        _mobilePhoneLoginView.backgroundColor = [UIColor cyanColor];
    }
    return _mobilePhoneLoginView;
}

@end
