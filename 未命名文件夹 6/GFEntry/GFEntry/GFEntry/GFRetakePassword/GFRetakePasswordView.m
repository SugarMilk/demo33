
//
//  GFRetakePasswordView.m
//  GFEntry
//
//  Created by huangjian on 17/3/22.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import "GFRetakePasswordView.h"
#import "GFEntryStyle.h"
#import <GFUtil/GFTextField.h>
#import <Masonry/Masonry.h>

@interface GFRetakePasswordView ()

@property (nonatomic, strong) GFTextFieldView * textFieldView;
@property (nonatomic, strong) UIButton * resetButton;
@property (nonatomic, strong) UILabel * topLabel;

@property (nonatomic, copy) id_block_t buttonActionBlock;

@end

@implementation GFRetakePasswordView

- (instancetype)init {
    if (self = [super init]) {
        [self addSubview:self.textFieldView];
        [self addSubview:self.resetButton];
        [self addSubview:self.topLabel];
    }
    return self;
}

- (void)setBindIdentifier:(NSString *)bindIdentifier {
    //TODO: 根据bindIdentifier判断是手机号还是邮箱
}

- (void)setPassword:(NSString *)password {
    self.textFieldView.textField.text = password;
}

- (NSString *)password {
    return self.textFieldView.textField.text;
}

- (void)handleButtonActionBlock:(id_block_t)buttonActionBlock {
    self.buttonActionBlock = buttonActionBlock;
}

- (void)resetButtonAction:(UIButton *)button {
    if (self.buttonActionBlock) {
        self.buttonActionBlock(button);
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self).with.insets(UIEdgeInsetsFromString(GFEntryStyle(@"retake-password.top.margin")));
        make.height.mas_equalTo(50); // TODO: 根据文本字数计算是否换行
    }];
    
    [self.textFieldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topLabel.mas_bottom).with.offset([GFEntryStyle(@"retake-password.input.margin-top") floatValue]);
        make.left.right.equalTo(self.topLabel);
        make.height.mas_equalTo([GFEntryStyle(@"retake-password.input.height") floatValue]);
    }];
    
    [self.resetButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textFieldView.mas_bottom).with.offset([GFEntryStyle(@"retake-password.reset-password.margin-top") floatValue]);
        make.left.right.equalTo(self.textFieldView);
        make.height.mas_equalTo([GFEntryStyle(@"retake-password.reset-password.height") floatValue]);
    }];
}

- (GFTextFieldView *)textFieldView {
    if (_textFieldView == nil) {
        _textFieldView = [[GFTextFieldView alloc] init];
        _textFieldView.textField.layer.borderColor = [GFEntryStyle(@"retake-password.input.border-color") CGColor];
        _textFieldView.textField.layer.borderWidth = [GFEntryStyle(@"retake-password.input.border-width") floatValue];
        _textFieldView.textField.layer.cornerRadius = [GFEntryStyle(@"retake-password.input.border-radius") floatValue];
        _textFieldView.textField.placeholder = GFEntryStyle(@"retake-password.input.placeholder");
        _textFieldView.textField.textColor = GFEntryStyle(@"retake-password.input.color");
        _textFieldView.textField.font = GFEntryStyle(@"retake-password.input.font-size");
        _textFieldView.textField.placeholderInsets = UIEdgeInsetsFromString(GFEntryStyle(@"retake-password.input.placeholder-indent"));
        _textFieldView.textField.textInsets = UIEdgeInsetsFromString(GFEntryStyle(@"retake-password.input.text-indent"));
    }
    return _textFieldView;
}

- (UIButton *)resetButton {
    if (_resetButton == nil) {
        _resetButton = [[UIButton alloc] init];
        _resetButton.titleLabel.font = GFEntryStyle(@"retake-password.reset-password.font-size");
        _resetButton.backgroundColor = GFEntryStyle(@"retake-password.reset-password.background-color");
        [_resetButton setTitle:GFEntryStyle(@"retake-password.reset-password.text") forState:UIControlStateNormal];
        [_resetButton setTitleColor:GFEntryStyle(@"retake-password.reset-password.color") forState:UIControlStateNormal];
        [_resetButton addTarget:self action:@selector(resetButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _resetButton;
}

- (UILabel *)topLabel {
    if (_topLabel == nil) {
        _topLabel = [[UILabel alloc] init];
        _topLabel.textColor = GFEntryStyle(@"retake-password.top.color");
        _topLabel.font = GFEntryStyle(@"retake-password.top.font-size");
        _topLabel.backgroundColor = GFEntryStyle(@"retake-password.top.background-color");
        _topLabel.numberOfLines = 2;
        _topLabel.text = [NSString stringWithFormat:@"%@%@%@",
                          GFEntryStyle(@"retake-password.top.text-prefix"),
                          @"156****6108",  // self.bindIdentifier
                          GFEntryStyle(@"retake-password.top.text-suffix")
                          ];
    }
    return _topLabel;
}

@end
