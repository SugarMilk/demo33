
//
//  GFUserNameLoginView.m
//  GFEntry
//
//  Created by huangjian on 17/3/21.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import "GFUserNameLoginView.h"
#import "GFEntryStyle.h"
#import <GFUtil/GFTextField.h>
#import <Masonry/Masonry.h>

@interface GFUserNameLoginView ()

@property (nonatomic, strong) GFTextFieldView * usernameTextFieldView;
@property (nonatomic, strong) GFTextFieldView * passwordTextFieldView;
@property (nonatomic, strong) UIButton * forgotPasswordButton;
@property (nonatomic, strong) UIButton * loginButton;

@property (nonatomic, copy) GFUserNameLoginViewButtonActionBlock buttonActionBlock;
@end


@implementation GFUserNameLoginView

- (instancetype)init {
    if (self = [super init]) {
        [self addSubview:self.usernameTextFieldView];
        [self addSubview:self.passwordTextFieldView];
        [self addSubview:self.forgotPasswordButton];
        [self addSubview:self.loginButton];
    }
    return self;
}

- (void)setUsername:(NSString *)username {
    self.usernameTextFieldView.textField.text = username;
}

- (NSString *)username {
    return self.usernameTextFieldView.textField.text;
}

- (void)setPassword:(NSString *)password {
    self.passwordTextFieldView.textField.text = password;
}

- (NSString *)password {
    return self.passwordTextFieldView.textField.text;
}

- (void)handleButtonActionBlock:(GFUserNameLoginViewButtonActionBlock)buttonActionBlock {
    self.buttonActionBlock = buttonActionBlock;
}

- (void)forgotPasswordButtonAction:(UIButton *)button {
    if (self.buttonActionBlock) {
        self.buttonActionBlock(button, GFUserNameLoginViewButtonTypeForgotPassword);
    }
}

- (void)loginButtonAction:(UIButton *)button {
    if (self.buttonActionBlock) {
        self.buttonActionBlock(button, GFUserNameLoginViewButtonTypeLogin);
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.usernameTextFieldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self).with.insets(UIEdgeInsetsFromString(GFEntryStyle(@"username-login.textfield-group.margin")));
        make.height.mas_equalTo([GFEntryStyle(@"username-login.textfield-group.height") floatValue]);
    }];
    
    [self.passwordTextFieldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.usernameTextFieldView.mas_bottom).with.offset([GFEntryStyle(@"username-login.textfield-group.padding") floatValue]);
        make.left.right.equalTo(self.usernameTextFieldView);
        make.height.mas_equalTo([GFEntryStyle(@"username-login.textfield-group.height") floatValue]);
    }];
    
    [self.forgotPasswordButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passwordTextFieldView.mas_bottom).with.offset([GFEntryStyle(@"username-login.forgot-password.margin-top") floatValue]);
        make.right.equalTo(self.passwordTextFieldView.mas_right);
        make.size.mas_equalTo(CGSizeFromString(GFEntryStyle(@"username-login.forgot-password.size")));
    }];
    
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.forgotPasswordButton.mas_bottom).with.offset([GFEntryStyle(@"username-login.login.margin-top") floatValue]);
        make.left.right.equalTo(self.passwordTextFieldView);
        make.height.mas_equalTo([GFEntryStyle(@"username-login.login.height") floatValue]);
    }];
}

- (GFTextFieldView *)usernameTextFieldView {
    if (_usernameTextFieldView == nil) {
        _usernameTextFieldView = [[GFTextFieldView alloc] init];
        
        [_usernameTextFieldView addWithButtonType:GFTextFieldButtonTypeLeft width:[GFEntryStyle(@"username-login.textfield-group.left-width") floatValue]];
        _usernameTextFieldView.leftButton.titleLabel.font = GFEntryStyle(@"username-login.textfield-group.font-size");
        _usernameTextFieldView.leftButton.contentEdgeInsets = UIEdgeInsetsFromString(GFEntryStyle(@"username-login.textfield-group.left-inset"));
        [_usernameTextFieldView.leftButton setTitle:GFEntryStyle(@"username-login.textfield-group.left-texts")[0] forState:UIControlStateNormal];
        [_usernameTextFieldView.leftButton setTitleColor:GFEntryStyle(@"username-login.textfield-group.color") forState:UIControlStateNormal];
        
        _usernameTextFieldView.textField.layer.borderColor = [GFEntryStyle(@"username-login.textfield-group.border-color") CGColor];
        _usernameTextFieldView.textField.layer.borderWidth = [GFEntryStyle(@"username-login.textfield-group.border-width") floatValue];
        _usernameTextFieldView.textField.layer.cornerRadius = [GFEntryStyle(@"username-login.textfield-group.border-radius") floatValue];
        _usernameTextFieldView.textField.placeholder = GFEntryStyle(@"username-login.textfield-group.placeholders")[0];
        _usernameTextFieldView.textField.textColor = GFEntryStyle(@"username-login.textfield-group.color");
        _usernameTextFieldView.textField.font = GFEntryStyle(@"username-login.textfield-group.font-size");
        _usernameTextFieldView.textField.placeholderInsets = UIEdgeInsetsFromString(GFEntryStyle(@"username-login.textfield-group.placeholder-indent"));
        _usernameTextFieldView.textField.textInsets = UIEdgeInsetsFromString(GFEntryStyle(@"username-login.textfield-group.text-indent"));
        _usernameTextFieldView.textField.clearButtonMode = [GFEntryStyle(@"username-login.textfield-group.clean-mode") integerValue];
    }
    return _usernameTextFieldView;
}

- (GFTextFieldView *)passwordTextFieldView {
    if (_passwordTextFieldView == nil) {
        _passwordTextFieldView = [[GFTextFieldView alloc] init];
        
        [_passwordTextFieldView addWithButtonType:GFTextFieldButtonTypeLeft width:[GFEntryStyle(@"username-login.textfield-group.left-width") floatValue]];
        _passwordTextFieldView.leftButton.titleLabel.font = GFEntryStyle(@"username-login.textfield-group.font-size");
        _passwordTextFieldView.leftButton.contentEdgeInsets = UIEdgeInsetsFromString(GFEntryStyle(@"username-login.textfield-group.left-inset"));
        [_passwordTextFieldView.leftButton setTitle:GFEntryStyle(@"username-login.textfield-group.left-texts")[1] forState:UIControlStateNormal];
        [_passwordTextFieldView.leftButton setTitleColor:GFEntryStyle(@"username-login.textfield-group.color") forState:UIControlStateNormal];
        
        _passwordTextFieldView.textField.layer.borderColor = [GFEntryStyle(@"username-login.textfield-group.border-color") CGColor];
        _passwordTextFieldView.textField.layer.borderWidth = [GFEntryStyle(@"username-login.textfield-group.border-width") floatValue];
        _passwordTextFieldView.textField.layer.cornerRadius = [GFEntryStyle(@"username-login.textfield-group.border-radius") floatValue];
        _passwordTextFieldView.textField.placeholder = GFEntryStyle(@"username-login.textfield-group.placeholders")[1];
        _passwordTextFieldView.textField.textColor = GFEntryStyle(@"username-login.textfield-group.color");
        _passwordTextFieldView.textField.font = GFEntryStyle(@"username-login.textfield-group.font-size");
        _passwordTextFieldView.textField.placeholderInsets = UIEdgeInsetsFromString(GFEntryStyle(@"username-login.textfield-group.placeholder-indent"));
        _passwordTextFieldView.textField.textInsets = UIEdgeInsetsFromString(GFEntryStyle(@"username-login.textfield-group.text-indent"));
        _passwordTextFieldView.textField.clearButtonMode = [GFEntryStyle(@"username-login.textfield-group.clean-mode") integerValue];
    }
    return _passwordTextFieldView;
}

- (UIButton *)forgotPasswordButton {
    if (_forgotPasswordButton == nil) {
        _forgotPasswordButton = [[UIButton alloc] init];
        _forgotPasswordButton.contentHorizontalAlignment = [GFEntryStyle(@"username-login.forgot-password.text-align") integerValue];
        _forgotPasswordButton.titleLabel.font = GFEntryStyle(@"username-login.forgot-password.font-size");
        [_forgotPasswordButton setTitle:GFEntryStyle(@"username-login.forgot-password.text") forState:UIControlStateNormal];
        [_forgotPasswordButton setTitleColor:GFEntryStyle(@"username-login.forgot-password.color") forState:UIControlStateNormal];
        [_forgotPasswordButton addTarget:self action:@selector(forgotPasswordButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _forgotPasswordButton;
}

- (UIButton *)loginButton {
    if (_loginButton == nil) {
        _loginButton = [[UIButton alloc] init];
        _loginButton.titleLabel.font = GFEntryStyle(@"username-login.login.font-size");
        _loginButton.backgroundColor = GFEntryStyle(@"username-login.login.background-color");
        [_loginButton setTitle:GFEntryStyle(@"username-login.login.text") forState:UIControlStateNormal];
        [_loginButton setTitleColor:GFEntryStyle(@"username-login.login.color") forState:UIControlStateNormal];
        [_loginButton addTarget:self action:@selector(loginButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}

@end
