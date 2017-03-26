//
//  GFGetCaptchaView.m
//  GFEntry
//
//  Created by huangjian on 17/3/22.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import "GFGetCaptchaView.h"
#import "GFEntryStyle.h"
#import <GFUtil/GFTextField.h>
#import <Masonry/Masonry.h>

@interface GFGetCaptchaView ()

@property (nonatomic, strong) GFTextFieldView * textFieldView;
@property (nonatomic, strong) UIButton * getCaptchaButton;
@property (nonatomic, strong) UIButton * notReceiveButton;
@property (nonatomic, strong) UIButton * nextStepButton;
@property (nonatomic, strong) UILabel * topLabel;

@property (nonatomic, copy) GFGetCaptchaViewButtonActionBlock buttonActionBlock;

@end

@implementation GFGetCaptchaView

- (instancetype)init {
    if (self = [super init]) {
        [self addSubview:self.textFieldView];
        [self addSubview:self.getCaptchaButton];
        [self addSubview:self.notReceiveButton];
        [self addSubview:self.nextStepButton];
        [self addSubview:self.topLabel];
    }
    return self;
}

- (void)setBindIdentifier:(NSString *)bindIdentifier {
    
}

- (NSString *)bindIdentifier {
    return nil;
}

- (void)setCaptcha:(NSString *)captcha {
    self.textFieldView.textField.text = captcha;
}

- (NSString *)captcha {
    return self.textFieldView.textField.text;
}

- (void)handleButtonActionBlock:(GFGetCaptchaViewButtonActionBlock)buttonActionBlock {
    self.buttonActionBlock = buttonActionBlock;
}

- (void)notReceiveButtonAction:(UIButton *)button {
    if (self.buttonActionBlock) {
        self.buttonActionBlock(button, GFGetCaptchaViewButtonTypeNotReceive);
    }
}

- (void)nextStepButtonAction:(UIButton *)button {
    if (self.buttonActionBlock) {
        self.buttonActionBlock(button, GFGetCaptchaViewButtonTypeNextStep);
    }
}

- (void)getCaptchaButtonAction:(UIButton *)button {
    if (self.buttonActionBlock) {
        self.buttonActionBlock(button, GFGetCaptchaViewButtonTypeGetCaptcha);
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self).with.insets(UIEdgeInsetsFromString(GFEntryStyle(@"get-captcha.top.margin")));
        make.height.mas_equalTo([GFEntryStyle(@"get-captcha.top.height") floatValue]);
    }];
    
    [self.getCaptchaButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topLabel.mas_bottom).with.offset([GFEntryStyle(@"get-captcha.send.margin-top") floatValue]);
        make.right.equalTo(self.topLabel.mas_right);
        make.size.mas_equalTo(CGSizeFromString(GFEntryStyle(@"get-captcha.send.size")));
    }];
    
    [self.textFieldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.getCaptchaButton.mas_top);
        make.left.equalTo(self.topLabel.mas_left);
        make.right.equalTo(self.getCaptchaButton.mas_left).with.offset(-[GFEntryStyle(@"get-captcha.input.margin-right") floatValue]);
        make.height.equalTo(self.getCaptchaButton.mas_height);
    }];
    
    [self.notReceiveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.getCaptchaButton.mas_bottom).with.offset([GFEntryStyle(@"get-captcha.question.margin-top") floatValue]);
        make.right.equalTo(self.getCaptchaButton.mas_right);
        make.size.mas_equalTo(CGSizeFromString(GFEntryStyle(@"get-captcha.question.size")));
    }];
    
    [self.nextStepButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.notReceiveButton.mas_bottom).with.offset([GFEntryStyle(@"get-captcha.next-step.margin-top") floatValue]);
        make.left.equalTo(self.textFieldView.mas_left);
        make.right.equalTo(self.getCaptchaButton.mas_right);
        make.height.mas_equalTo([GFEntryStyle(@"get-captcha.next-step.height") floatValue]);
    }];
}

- (GFTextFieldView *)textFieldView {
    if (_textFieldView == nil) {
        _textFieldView = [[GFTextFieldView alloc] init];
        _textFieldView.textField.placeholder = GFEntryStyle(@"get-captcha.input.placeholder");
        _textFieldView.textField.layer.borderColor = [GFEntryStyle(@"get-captcha.input.border-color") CGColor];
        _textFieldView.textField.layer.borderWidth = [GFEntryStyle(@"get-captcha.input.border-width") floatValue];
        _textFieldView.textField.layer.cornerRadius = [GFEntryStyle(@"get-captcha.input.border-radius") floatValue];
        _textFieldView.textField.font = GFEntryStyle(@"get-captcha.input.font-size");
        _textFieldView.textField.textColor = GFEntryStyle(@"get-captcha.input.color");
        _textFieldView.textField.placeholderInsets = UIEdgeInsetsFromString(GFEntryStyle(@"get-captcha.input.placeholder-indent"));
        _textFieldView.textField.textInsets = UIEdgeInsetsFromString(GFEntryStyle(@"get-captcha.input.text-indent"));
    }
    return _textFieldView;
}

- (UIButton *)notReceiveButton {
    if (_notReceiveButton == nil) {
        _notReceiveButton = [[UIButton alloc] init];
        _notReceiveButton.titleLabel.font = GFEntryStyle(@"get-captcha.question.font-size");
        _notReceiveButton.backgroundColor = GFEntryStyle(@"get-captcha.question.background-color");
        _notReceiveButton.contentHorizontalAlignment = [GFEntryStyle(@"get-captcha.question.text-align") integerValue];
        [_notReceiveButton setTitle:GFEntryStyle(@"get-captcha.question.text") forState:UIControlStateNormal];
        [_notReceiveButton setTitleColor:GFEntryStyle(@"get-captcha.question.color") forState:UIControlStateNormal];
        [_notReceiveButton addTarget:self action:@selector(notReceiveButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _notReceiveButton;
}

- (UIButton *)nextStepButton {
    if (_nextStepButton == nil) {
        _nextStepButton = [[UIButton alloc] init];
        _nextStepButton.titleLabel.font = GFEntryStyle(@"get-captcha.next-step.font-size");
        _nextStepButton.backgroundColor = GFEntryStyle(@"get-captcha.next-step.background-color");
        [_nextStepButton setTitle:GFEntryStyle(@"get-captcha.next-step.text") forState:UIControlStateNormal];
        [_nextStepButton setTitleColor:GFEntryStyle(@"get-captcha.next-step.color") forState:UIControlStateNormal];
        [_nextStepButton addTarget:self action:@selector(nextStepButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextStepButton;
}

- (UIButton *)getCaptchaButton {
    if (_getCaptchaButton == nil) {
        _getCaptchaButton = [[UIButton alloc] init];
        _getCaptchaButton.backgroundColor = GFEntryStyle(@"get-captcha.send.background-color");
        _getCaptchaButton.titleLabel.font = GFEntryStyle(@"get-captcha.send.font-size");
        [_getCaptchaButton setTitle:GFEntryStyle(@"get-captcha.send.normal-text") forState:UIControlStateNormal];
        [_getCaptchaButton setTitleColor:GFEntryStyle(@"get-captcha.send.color") forState:UIControlStateNormal];
        [_getCaptchaButton addTarget:self action:@selector(getCaptchaButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _getCaptchaButton;
}

- (UILabel *)topLabel {
    if (_topLabel == nil) {
        _topLabel = [[UILabel alloc] init];
        _topLabel.textColor = GFEntryStyle(@"get-captcha.top.color");
        _topLabel.font = GFEntryStyle(@"get-captcha.top.font-size");
        _topLabel.backgroundColor = GFEntryStyle(@"get-captcha.top.background-color");
        _topLabel.textAlignment = [GFEntryStyle(@"get-captcha.top.text-align") integerValue];
        _topLabel.numberOfLines = 2;
        _topLabel.text = [NSString stringWithFormat:@"%@%@\n%@",
                          GFEntryStyle(@"get-captcha.top.text-prefix"),
                          GFEntryStyle(@"get-captcha.top.text-email"),
                          @"121****518@qq.com"
                          ];
    }
    return _topLabel;
}

@end
