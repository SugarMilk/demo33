//
//  GFTouristRegisterViewController.m
//  GFEntry
//
//  Created by huangjian on 17/3/21.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import "GFTouristRegisterViewController.h"
#import "GFTouristRegisterView.h"
#import <Masonry/Masonry.h>

@interface GFTouristRegisterViewController ()

@property (nonatomic, strong) GFTouristRegisterView * touristRegisterView;

@end

@implementation GFTouristRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.contentView addSubview:self.touristRegisterView];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    [self.touristRegisterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).with.insets(UIEdgeInsetsMake(50, 10, 10, 10));
    }];
}

- (GFTouristRegisterView *)touristRegisterView {
    if (_touristRegisterView == nil) {
        _touristRegisterView = [[GFTouristRegisterView alloc] init];
//        _touristRegisterView.backgroundColor = [UIColor cyanColor];
    }
    return _touristRegisterView;
}

@end
