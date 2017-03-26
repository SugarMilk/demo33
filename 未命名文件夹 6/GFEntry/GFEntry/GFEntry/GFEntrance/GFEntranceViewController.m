//
//  GFEntranceViewController.m
//  GFEntry
//
//  Created by huangjian on 17/3/20.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import "GFEntranceViewController.h"
#import "GFEntranceView.h"
#import "Masonry.h"

@interface GFEntranceViewController ()

@property (nonatomic, strong) GFEntranceView * entranceView;

@end

@implementation GFEntranceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.contentView addSubview:self.entranceView];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    [self.entranceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).with.insets(UIEdgeInsetsMake(50, 10, 10, 10));
    }];
}

- (GFEntranceView *)entranceView {
    if (_entranceView == nil) {
        _entranceView = [[GFEntranceView alloc] init];
//        _entranceView.backgroundColor = [UIColor cyanColor];
    }
    return _entranceView;
}

@end
