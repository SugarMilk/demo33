//
//  GFForgotPasswordView.m
//  GFEntry
//
//  Created by huangjian on 17/3/22.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import "GFForgotPasswordView.h"
#import "GFEntryStyle.h"
#import <GFUtil/GFTextField.h>
#import <Masonry/Masonry.h>

@interface GFForgotPasswordView ()

@property (nonatomic, strong) GFTextFieldView * textFieldView;
@property (nonatomic, strong) UIButton * forgotAccountButton;
@property (nonatomic, strong) UIButton * nextStepButton;

@property (nonatomic, copy) GFForgotPasswordViewButtonActionBlock buttonActionBlock;

@end

@implementation GFForgotPasswordView

- (instancetype)init {
    if (self = [super init]) {
        [self addSubview:self.textFieldView];
        [self addSubview:self.forgotAccountButton];
        [self addSubview:self.nextStepButton];
    }
    return self;
}

- (void)setText:(NSString *)text {
    self.textFieldView.textField.text = text;
}

- (NSString *)text {
    return self.textFieldView.textField.text;
}

- (void)handleButtonActionBlock:(GFForgotPasswordViewButtonActionBlock)buttonActionBlock {
    self.buttonActionBlock = buttonActionBlock;
}

- (void)forgotAccountButtonAction:(UIButton *)button {
    if (self.buttonActionBlock) {
        self.buttonActionBlock(button, GFForgotPasswordViewButtonTypeForgotAccount);
    }
}

- (void)nextStepButtonAction:(UIButton *)button {
    if (self.buttonActionBlock) {
        self.buttonActionBlock(button, GFForgotPasswordViewButtonTypeNextStep);
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.textFieldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self).with.insets(UIEdgeInsetsFromString(GFEntryStyle(@"forgot-password.input.margin")));
        make.height.mas_equalTo([GFEntryStyle(@"forgot-password.input.height") floatValue]);
    }];
    
    [self.forgotAccountButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textFieldView.mas_bottom).with.offset([GFEntryStyle(@"forgot-password.forgot-account.margin-top") floatValue]);
        make.right.equalTo(self.textFieldView.mas_right);
        make.size.mas_equalTo(CGSizeFromString(GFEntryStyle(@"forgot-password.forgot-account.size")));
    }];
    
    [self.nextStepButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.forgotAccountButton.mas_bottom).with.offset([GFEntryStyle(@"forgot-password.next-step.margin-top") floatValue]);
        make.left.right.equalTo(self.textFieldView);
        make.height.mas_equalTo([GFEntryStyle(@"forgot-password.next-step.height") floatValue]);
    }];
}

- (GFTextFieldView *)textFieldView {
    if (_textFieldView == nil) {
        _textFieldView = [[GFTextFieldView alloc] init];
        _textFieldView.textField.layer.borderColor = [GFEntryStyle(@"forgot-password.input.border-color") CGColor];
        _textFieldView.textField.layer.borderWidth = [GFEntryStyle(@"forgot-password.input.border-width") floatValue];
        _textFieldView.textField.layer.cornerRadius = [GFEntryStyle(@"forgot-password.input.border-radius") floatValue];
        _textFieldView.textField.placeholder = GFEntryStyle(@"forgot-password.input.placeholder");
        _textFieldView.textField.textColor = GFEntryStyle(@"forgot-password.input.color");
        _textFieldView.textField.font = GFEntryStyle(@"forgot-password.input.font-size");
        _textFieldView.textField.placeholderInsets = UIEdgeInsetsFromString(GFEntryStyle(@"forgot-password.input.placeholder-indent"));
        _textFieldView.textField.textInsets = UIEdgeInsetsFromString(GFEntryStyle(@"forgot-password.input.text-indent"));
    }
    return _textFieldView;
}

- (UIButton *)forgotAccountButton {
    if (_forgotAccountButton == nil) {
        _forgotAccountButton = [[UIButton alloc] init];
        _forgotAccountButton.contentHorizontalAlignment = [GFEntryStyle(@"forgot-password.forgot-account.text-align") integerValue];
        _forgotAccountButton.backgroundColor = GFEntryStyle(@"forgot-password.forgot-account.background-color");
        _forgotAccountButton.titleLabel.font = GFEntryStyle(@"forgot-password.forgot-account.font-size");
        [_forgotAccountButton setTitle:GFEntryStyle(@"forgot-password.forgot-account.text") forState:UIControlStateNormal];
        [_forgotAccountButton setTitleColor:GFEntryStyle(@"forgot-password.forgot-account.color") forState:UIControlStateNormal];
        [_forgotAccountButton addTarget:self action:@selector(forgotAccountButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _forgotAccountButton;
}

- (UIButton *)nextStepButton {
    if (_nextStepButton == nil) {
        _nextStepButton = [[UIButton alloc] init];
        _nextStepButton.titleLabel.font = GFEntryStyle(@"forgot-password.next-step.font-size");
        _nextStepButton.backgroundColor = GFEntryStyle(@"forgot-password.next-step.background-color");
        [_nextStepButton setTitle:GFEntryStyle(@"forgot-password.next-step.text") forState:UIControlStateNormal];
        [_nextStepButton setTitleColor:GFEntryStyle(@"forgot-password.next-step.color") forState:UIControlStateNormal];
        [_nextStepButton addTarget:self action:@selector(nextStepButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextStepButton;
}

@end
