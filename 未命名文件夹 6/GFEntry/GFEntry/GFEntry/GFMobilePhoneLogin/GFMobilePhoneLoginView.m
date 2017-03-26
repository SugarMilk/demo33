

//
//  GFMobilePhoneLoginView.m
//  GFEntry
//
//  Created by huangjian on 17/3/21.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import "GFMobilePhoneLoginView.h"
#import "GFEntryStyle.h"
#import <GFUtil/GFTextField.h>
#import <Masonry/Masonry.h>

@interface GFMobilePhoneLoginView ()

@property (nonatomic, strong) GFTextFieldView * phoneNoTextFieldView;
@property (nonatomic, strong) GFTextFieldView * captchaTextFieldView;
@property (nonatomic, strong) UIButton * getCaptchaButton;
@property (nonatomic, strong) UIButton * notReceiveButton;
@property (nonatomic, strong) UIButton * loginButton;

@property (nonatomic, copy) GFMobilePhoneLoginViewButtonActionBlock buttonActionBlock;

@end


@implementation GFMobilePhoneLoginView

- (instancetype)init {
    if (self = [super init]) {
        [self addSubview:self.phoneNoTextFieldView];
        [self addSubview:self.captchaTextFieldView];
        [self addSubview:self.notReceiveButton];
        [self addSubview:self.loginButton];
        [self addSubview:self.getCaptchaButton];
    }
    return self;
}

- (void)setPhoneNo:(NSString *)phoneNo {
    self.phoneNoTextFieldView.textField.text = phoneNo;
}

- (NSString *)phoneNo {
    return self.phoneNoTextFieldView.textField.text;
}

- (void)setCaptcha:(NSString *)captcha {
    self.captchaTextFieldView.textField.text = captcha;
}

- (NSString *)captcha {
    return self.captchaTextFieldView.textField.text;
}

- (void)handleButtonActionBlock:(GFMobilePhoneLoginViewButtonActionBlock)buttonActionBlock {
    self.buttonActionBlock = buttonActionBlock;
}

- (void)notReceiveButtonAction:(UIButton *)button {
    if (self.buttonActionBlock) {
        self.buttonActionBlock(button, GFMobilePhoneLoginViewButtonTypeNotReceive);
    }
}

- (void)loginButtonAction:(UIButton *)button {
    if (self.buttonActionBlock) {
        self.buttonActionBlock(button, GFMobilePhoneLoginViewButtonTypeLogin);
    }
}

- (void)getCaptchaButtonAction:(UIButton *)button {
    if (self.buttonActionBlock) {
        self.buttonActionBlock(button, GFMobilePhoneLoginViewButtonTypeGetCaptcha);
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.phoneNoTextFieldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self).with.insets(UIEdgeInsetsFromString(GFEntryStyle(@"phone-login.phone.margin")));
        make.height.mas_equalTo([GFEntryStyle(@"phone-login.phone.height") floatValue]);
    }];
    
    [self.getCaptchaButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneNoTextFieldView.mas_bottom).with.offset([GFEntryStyle(@"phone-login.send.margin-top") floatValue]);
        make.right.equalTo(self.phoneNoTextFieldView.mas_right);
        make.size.mas_equalTo(CGSizeFromString(GFEntryStyle(@"phone-login.send.size")));
    }];
    
    [self.captchaTextFieldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.getCaptchaButton.mas_top);
        make.left.equalTo(self.phoneNoTextFieldView.mas_left);
        make.right.equalTo(self.getCaptchaButton.mas_left).with.offset(-[GFEntryStyle(@"phone-login.captcha.margin-right") floatValue]);
        make.height.equalTo(self.getCaptchaButton.mas_height);
    }];
    
    [self.notReceiveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.captchaTextFieldView.mas_bottom).with.offset([GFEntryStyle(@"phone-login.question.margin-top") floatValue]);
        make.right.equalTo(self.phoneNoTextFieldView.mas_right);
        make.size.mas_equalTo(CGSizeFromString(GFEntryStyle(@"phone-login.question.size")));
    }];
    
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.notReceiveButton.mas_bottom).with.offset([GFEntryStyle(@"phone-login.login.margin-top") floatValue]);
        make.left.right.equalTo(self.phoneNoTextFieldView);
        make.height.mas_equalTo([GFEntryStyle(@"phone-login.login.height") floatValue]);
    }];
}

- (GFTextFieldView *)phoneNoTextFieldView {
    if (_phoneNoTextFieldView == nil) {
        _phoneNoTextFieldView = [[GFTextFieldView alloc] init];
        
        [_phoneNoTextFieldView addWithButtonType:GFTextFieldButtonTypeLeft width:[GFEntryStyle(@"phone-login.phone.left-width") floatValue]];
        _phoneNoTextFieldView.leftButton.titleLabel.font = GFEntryStyle(@"phone-login.phone.font-size");
        [_phoneNoTextFieldView.leftButton setTitle:GFEntryStyle(@"phone-login.phone.left-text") forState:UIControlStateNormal];
        [_phoneNoTextFieldView.leftButton setTitleColor:GFEntryStyle(@"phone-login.phone.color") forState:UIControlStateNormal];
        _phoneNoTextFieldView.leftButton.contentEdgeInsets = UIEdgeInsetsFromString(GFEntryStyle(@"phone-login.phone.left-inset"));
        
        _phoneNoTextFieldView.layer.borderWidth = [GFEntryStyle(@"phone-login.phone.border-width") floatValue];
        _phoneNoTextFieldView.layer.borderColor = [GFEntryStyle(@"phone-login.phone.border-color") CGColor];
        _phoneNoTextFieldView.layer.cornerRadius = [GFEntryStyle(@"phone-login.phone.border-radius") floatValue];
        _phoneNoTextFieldView.textField.placeholder = GFEntryStyle(@"phone-login.phone.placeholder");
        _phoneNoTextFieldView.textField.placeholderInsets = UIEdgeInsetsFromString(GFEntryStyle(@"phone-login.phone.placeholder-indent"));
        _phoneNoTextFieldView.textField.textInsets = UIEdgeInsetsFromString(GFEntryStyle(@"phone-login.phone.text-indent"));
        _phoneNoTextFieldView.textField.textColor = GFEntryStyle(@"phone-login.phone.color");
        _phoneNoTextFieldView.textField.font = GFEntryStyle(@"phone-login.phone.font-size");
    }
    return _phoneNoTextFieldView;
}

- (GFTextFieldView *)captchaTextFieldView {
    if (_captchaTextFieldView == nil) {
        _captchaTextFieldView = [[GFTextFieldView alloc] init];
        
        [_captchaTextFieldView addWithButtonType:GFTextFieldButtonTypeLeft width:[GFEntryStyle(@"phone-login.captcha.left-width") floatValue]];
        _captchaTextFieldView.leftButton.titleLabel.font = GFEntryStyle(@"phone-login.captcha.font-size");
        [_captchaTextFieldView.leftButton setTitle:GFEntryStyle(@"phone-login.captcha.left-text") forState:UIControlStateNormal];
        [_captchaTextFieldView.leftButton setTitleColor:GFEntryStyle(@"phone-login.captcha.color") forState:UIControlStateNormal];
        _captchaTextFieldView.leftButton.contentEdgeInsets = UIEdgeInsetsFromString(GFEntryStyle(@"phone-login.captcha.left-inset"));
        
        _captchaTextFieldView.layer.borderWidth = [GFEntryStyle(@"phone-login.captcha.border-width") floatValue];
        _captchaTextFieldView.layer.borderColor = [GFEntryStyle(@"phone-login.captcha.border-color") CGColor];
        _captchaTextFieldView.layer.cornerRadius = [GFEntryStyle(@"phone-login.captcha.border-radius") floatValue];
        _captchaTextFieldView.textField.placeholder = GFEntryStyle(@"phone-login.captcha.placeholder");
        _captchaTextFieldView.textField.placeholderInsets = UIEdgeInsetsFromString(GFEntryStyle(@"phone-login.captcha.placeholder-indent"));
        _captchaTextFieldView.textField.textInsets = UIEdgeInsetsFromString(GFEntryStyle(@"phone-login.captcha.text-indent"));
        _captchaTextFieldView.textField.textColor = GFEntryStyle(@"phone-login.captcha.color");
        _captchaTextFieldView.textField.font = GFEntryStyle(@"phone-login.captcha.font-size");
    }
    return _captchaTextFieldView;
}

- (UIButton *)notReceiveButton {
    if (_notReceiveButton == nil) {
        _notReceiveButton = [[UIButton alloc] init];
        _notReceiveButton.titleLabel.font = GFEntryStyle(@"phone-login.question.font-size");
        _notReceiveButton.backgroundColor = GFEntryStyle(@"phone-login.question.background-color");
        _notReceiveButton.contentHorizontalAlignment = [GFEntryStyle(@"phone-login.question.text-align") integerValue];
        [_notReceiveButton setTitle:GFEntryStyle(@"phone-login.question.text") forState:UIControlStateNormal];
        [_notReceiveButton setTitleColor:GFEntryStyle(@"phone-login.question.color") forState:UIControlStateNormal];
        [_notReceiveButton addTarget:self action:@selector(notReceiveButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _notReceiveButton;
}

- (UIButton *)loginButton {
    if (_loginButton == nil) {
        _loginButton = [[UIButton alloc] init];
        _loginButton.titleLabel.font = GFEntryStyle(@"phone-login.login.font-size");
        _loginButton.backgroundColor = GFEntryStyle(@"phone-login.login.background-color");
        [_loginButton setTitle:GFEntryStyle(@"phone-login.login.text") forState:UIControlStateNormal];
        [_loginButton setTitleColor:GFEntryStyle(@"phone-login.login.color") forState:UIControlStateNormal];
        [_loginButton addTarget:self action:@selector(loginButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}

- (UIButton *)getCaptchaButton {
    if (_getCaptchaButton == nil) {
        _getCaptchaButton = [[UIButton alloc] init];
        _getCaptchaButton.titleLabel.font = GFEntryStyle(@"phone-login.send.font-size");
        _getCaptchaButton.backgroundColor = GFEntryStyle(@"phone-login.send.background-color");
        [_getCaptchaButton setTitle:GFEntryStyle(@"phone-login.send.normal-text") forState:UIControlStateNormal];
        [_getCaptchaButton setTitleColor:GFEntryStyle(@"phone-login.send.color") forState:UIControlStateNormal];
        [_getCaptchaButton addTarget:self action:@selector(getCaptchaButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _getCaptchaButton;
}

@end
