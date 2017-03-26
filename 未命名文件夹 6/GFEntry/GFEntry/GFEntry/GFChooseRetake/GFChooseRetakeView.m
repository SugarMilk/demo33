//
//  GFChooseRetakeView.m
//  GFEntry
//
//  Created by huangjian on 17/3/22.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import "GFChooseRetakeView.h"
#import "GFEntryStyle.h"
#import <Masonry/Masonry.h>

@interface GFChooseRetakeView ()

@property (nonatomic, strong) UILabel * topLabel;
@property (nonatomic, strong) UIButton * findByMobilePhoneButton;
@property (nonatomic, strong) UIButton * findByEmailButton;

@property (nonatomic, copy) GFChooseRetakeViewButtonActionBlock buttonActionBlock;

@end

@implementation GFChooseRetakeView

- (instancetype)init {
    if (self = [super init]) {
        [self addSubview:self.findByMobilePhoneButton];
        [self addSubview:self.findByEmailButton];
        [self addSubview:self.topLabel];
    }
    return self;
}

- (void)handleButtonActionBlock:(GFChooseRetakeViewButtonActionBlock)buttonActionBlock {
    self.buttonActionBlock = buttonActionBlock;
}

- (void)findByMobilePhoneButtonAction:(UIButton *)button {
    if (self.buttonActionBlock) {
        self.buttonActionBlock(button, GFGetCaptchaViewButtonTypeFindByMobilePhone);
    }
}

- (void)findByEmailButtonAction:(UIButton *)button {
    if (self.buttonActionBlock) {
        self.buttonActionBlock(button, GFGetCaptchaViewButtonTypeFindByEmail);
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self).with.insets(UIEdgeInsetsFromString(GFEntryStyle(@"choose-retake.top.margin")));
        make.height.mas_equalTo([GFEntryStyle(@"choose-retake.top.height") floatValue]);
    }];
    
    [self.findByMobilePhoneButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topLabel.mas_bottom).with.offset([GFEntryStyle(@"choose-retake.button-group.margin-top") floatValue]);
        make.left.right.equalTo(self.topLabel);
        make.height.mas_equalTo([GFEntryStyle(@"choose-retake.button-group.height") floatValue]);
    }];
    
    [self.findByEmailButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.findByMobilePhoneButton.mas_bottom).with.offset([GFEntryStyle(@"choose-retake.button-group.padding") floatValue]);
        make.left.right.equalTo(self.findByMobilePhoneButton);
        make.height.mas_equalTo([GFEntryStyle(@"choose-retake.button-group.height") floatValue]);
    }];
}

- (UIButton *)findByMobilePhoneButton {
    if (_findByMobilePhoneButton == nil) {
        _findByMobilePhoneButton = [[UIButton alloc] init];
        _findByMobilePhoneButton.backgroundColor = GFEntryStyle(@"choose-retake.button-group.background-color");
        _findByMobilePhoneButton.titleLabel.font = GFEntryStyle(@"choose-retake.button-group.font-size");
        [_findByMobilePhoneButton setTitle:GFEntryStyle(@"choose-retake.button-group.texts")[0] forState:UIControlStateNormal];
        [_findByMobilePhoneButton setTitleColor:GFEntryStyle(@"choose-retake.button-group.color") forState:UIControlStateNormal];
        [_findByMobilePhoneButton addTarget:self action:@selector(findByMobilePhoneButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _findByMobilePhoneButton;
}

- (UIButton *)findByEmailButton {
    if (_findByEmailButton == nil) {
        _findByEmailButton = [[UIButton alloc] init];
        _findByEmailButton.backgroundColor = GFEntryStyle(@"choose-retake.button-group.background-color");
        _findByEmailButton.titleLabel.font = GFEntryStyle(@"choose-retake.button-group.font-size");
        [_findByEmailButton setTitle:GFEntryStyle(@"choose-retake.button-group.texts")[1] forState:UIControlStateNormal];
        [_findByEmailButton setTitleColor:GFEntryStyle(@"choose-retake.button-group.color") forState:UIControlStateNormal];
        [_findByEmailButton addTarget:self action:@selector(findByEmailButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _findByEmailButton;
}

- (UILabel *)topLabel {
    if (_topLabel == nil) {
        _topLabel = [[UILabel alloc] init];
        _topLabel.text = GFEntryStyle(@"choose-retake.top.text");
        _topLabel.backgroundColor = GFEntryStyle(@"choose-retake.top.background-color");
        _topLabel.font = GFEntryStyle(@"choose-retake.top.font-size");
        _topLabel.textColor = GFEntryStyle(@"choose-retake.top.color");
        _topLabel.numberOfLines = 2;
    }
    return _topLabel;
}

@end
