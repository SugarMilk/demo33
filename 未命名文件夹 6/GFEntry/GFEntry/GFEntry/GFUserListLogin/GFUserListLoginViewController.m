//
//  GFUserListLoginViewController.m
//  GFEntry
//
//  Created by huangjian on 17/3/22.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import "GFUserListLoginViewController.h"
#import "GFUserListLoginView.h"
#import <Masonry/Masonry.h>

@interface GFUserListLoginViewController ()

@property (nonatomic, strong) GFUserListLoginView * userListLoginView;

@end

@implementation GFUserListLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.contentView addSubview:self.userListLoginView];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    [self.userListLoginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).with.insets(UIEdgeInsetsMake(50, 10, 10, 10));
    }];
}

- (GFUserListLoginView *)userListLoginView {
    if (_userListLoginView == nil) {
        _userListLoginView = [[GFUserListLoginView alloc] init];
//        _userListLoginView.backgroundColor = [UIColor cyanColor];
    }
    return _userListLoginView;
}

@end
