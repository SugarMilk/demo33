//
//  GFUserNameLoginViewController.m
//  GFEntry
//
//  Created by huangjian on 17/3/21.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import "GFUserNameLoginViewController.h"
#import "GFUserNameLoginView.h"
#import <Masonry/Masonry.h>

@interface GFUserNameLoginViewController ()

@property (nonatomic, strong) GFUserNameLoginView * userNameLoginView;

@end

@implementation GFUserNameLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.contentView addSubview:self.userNameLoginView];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    [self.userNameLoginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).with.insets(UIEdgeInsetsMake(50, 10, 10, 10));
    }];
}

- (GFUserNameLoginView *)userNameLoginView {
    if (_userNameLoginView == nil) {
        _userNameLoginView = [[GFUserNameLoginView alloc] init];
//        _userNameLoginView.backgroundColor = [UIColor cyanColor];
    }
    return _userNameLoginView;
}

@end
