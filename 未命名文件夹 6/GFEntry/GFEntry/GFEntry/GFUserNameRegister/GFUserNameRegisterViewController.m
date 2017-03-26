//
//  GFUserNameRegisterViewController.m
//  GFEntry
//
//  Created by huangjian on 17/3/21.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import "GFUserNameRegisterViewController.h"
#import "GFUserNameRegisterView.h"
#import <Masonry/Masonry.h>

@interface GFUserNameRegisterViewController ()

@property (nonatomic, strong) GFUserNameRegisterView * registerView;

@end

@implementation GFUserNameRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.contentView addSubview:self.registerView];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    [self.registerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).with.insets(UIEdgeInsetsMake(50, 10, 10, 10));
    }];
}

- (GFUserNameRegisterView *)registerView {
    if (_registerView == nil) {
        _registerView = [[GFUserNameRegisterView alloc] init];
//        _registerView.backgroundColor = [UIColor cyanColor];
    }
    return _registerView;
}

@end
