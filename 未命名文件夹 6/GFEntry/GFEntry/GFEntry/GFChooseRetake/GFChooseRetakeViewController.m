//
//  GFChooseRetakeViewController.m
//  GFEntry
//
//  Created by huangjian on 17/3/22.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import "GFChooseRetakeViewController.h"
#import "GFChooseRetakeView.h"
#import <Masonry/Masonry.h>

@interface GFChooseRetakeViewController ()

@property (nonatomic, strong) GFChooseRetakeView * chooseRetakeView;

@end

@implementation GFChooseRetakeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.contentView addSubview:self.chooseRetakeView];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    [self.chooseRetakeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).with.insets(UIEdgeInsetsMake(50, 10, 10, 10));
    }];
}

- (GFChooseRetakeView *)chooseRetakeView {
    if (_chooseRetakeView == nil) {
        _chooseRetakeView = [[GFChooseRetakeView alloc] init];
//        _chooseRetakeView.backgroundColor = [UIColor cyanColor];
    }
    return _chooseRetakeView;
}

@end
