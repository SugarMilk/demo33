//
//  GFUserNameRegisterView.m
//  GFEntry
//
//  Created by huangjian on 17/3/21.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import "GFUserNameRegisterView.h"
#import "GFEntryStyle.h"
#import <GFUtil/GFTextField.h>
#import <Masonry/Masonry.h>

@interface GFUserNameRegisterView ()

@property (nonatomic, strong) GFTextFieldView * usernameTextFieldView;
@property (nonatomic, strong) GFTextFieldView * passwordTextFieldView;
@property (nonatomic, strong) UIButton * registerButton;
@property (nonatomic, strong) UIButton * agreementButton;
@property (nonatomic, strong) UILabel * usernameTipLabel;
@property (nonatomic, strong) UILabel * passwordTipLabel;

@property (nonatomic, copy) GFUserNameRegisterViewButtonActionBlock buttonActionBlock;

@end

@implementation GFUserNameRegisterView

- (instancetype)init {
    if (self = [super init]) {
        [self addSubview:self.usernameTextFieldView];
        [self addSubview:self.passwordTextFieldView];
        [self addSubview:self.registerButton];
        [self addSubview:self.agreementButton];
        [self addSubview:self.usernameTipLabel];
        [self addSubview:self.passwordTipLabel];
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

- (void)handleButtonActionBlock:(GFUserNameRegisterViewButtonActionBlock)buttonActionBlock {
    self.buttonActionBlock = buttonActionBlock;
}

- (void)registerButtonAction:(UIButton *)button {
    if (self.buttonActionBlock) {
        self.buttonActionBlock(button, GFUserNameRegisterViewButtonTypeRegister);
    }
}

- (void)agreementButtonAction:(UIButton *)button {
    if (self.buttonActionBlock) {
        self.buttonActionBlock(button, GFUserNameRegisterViewButtonTypeAgreement);
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.usernameTipLabel.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.8];
    self.passwordTipLabel.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.8];
    
    [self.usernameTextFieldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self).with.insets(UIEdgeInsetsFromString(GFEntryStyle(@"username-register.textfield-group.margin")));
        make.height.mas_equalTo([GFEntryStyle(@"username-register.textfield-group.height") floatValue]);
    }];
    
    [self.passwordTextFieldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.usernameTextFieldView.mas_bottom).with.offset([GFEntryStyle(@"username-register.textfield-group.padding") floatValue]);
        make.left.right.equalTo(self.usernameTextFieldView);
        make.height.mas_equalTo([GFEntryStyle(@"username-register.textfield-group.height") floatValue]);
    }];
    
    [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passwordTextFieldView.mas_bottom).with.offset([GFEntryStyle(@"username-register.register.margin-top") floatValue]);
        make.left.right.equalTo(self.passwordTextFieldView);
        make.height.mas_equalTo([GFEntryStyle(@"username-register.register.height") floatValue]);
    }];
    
    [self.usernameTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.usernameTextFieldView.mas_bottom);
        make.left.right.equalTo(self.usernameTextFieldView);
        make.height.mas_equalTo(13);
    }];
    
    [self.passwordTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passwordTextFieldView.mas_bottom);
        make.left.right.equalTo(self.passwordTextFieldView);
        make.height.mas_equalTo(13);
    }];
    
    [self.agreementButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.registerButton.mas_bottom).with.offset([GFEntryStyle(@"username-register.agreement.margin-top") floatValue]);
        make.centerX.equalTo(self.mas_centerX);
        make.size.mas_equalTo(CGSizeFromString(GFEntryStyle(@"username-register.agreement.size")));
    }];
}

- (GFTextFieldView *)usernameTextFieldView {
    if (_usernameTextFieldView == nil) {
        _usernameTextFieldView = [[GFTextFieldView alloc] init];
        
        [_usernameTextFieldView addWithButtonType:GFTextFieldButtonTypeLeft width:[GFEntryStyle(@"username-register.textfield-group.left-width") floatValue]];
        _usernameTextFieldView.leftButton.titleLabel.font = GFEntryStyle(@"username-register.textfield-group.font-size");
        _usernameTextFieldView.leftButton.contentEdgeInsets = UIEdgeInsetsFromString(GFEntryStyle(@"username-register.textfield-group.left-inset"));
        [_usernameTextFieldView.leftButton setTitle:GFEntryStyle(@"username-register.textfield-group.left-texts")[0] forState:UIControlStateNormal];
        [_usernameTextFieldView.leftButton setTitleColor:GFEntryStyle(@"username-register.textfield-group.color") forState:UIControlStateNormal];
        
        _usernameTextFieldView.textField.layer.borderColor = [GFEntryStyle(@"username-register.textfield-group.border-color") CGColor];
        _usernameTextFieldView.textField.layer.borderWidth = [GFEntryStyle(@"username-register.textfield-group.border-width") floatValue];
        _usernameTextFieldView.textField.layer.cornerRadius = [GFEntryStyle(@"username-register.textfield-group.border-radius") floatValue];
        _usernameTextFieldView.textField.placeholder = GFEntryStyle(@"username-register.textfield-group.placeholders")[0];
        _usernameTextFieldView.textField.textColor = GFEntryStyle(@"username-register.textfield-group.color");
        _usernameTextFieldView.textField.font = GFEntryStyle(@"username-register.textfield-group.font-size");
        _usernameTextFieldView.textField.placeholderInsets = UIEdgeInsetsFromString(GFEntryStyle(@"username-register.textfield-group.placeholder-indent"));
        _usernameTextFieldView.textField.textInsets = UIEdgeInsetsFromString(GFEntryStyle(@"username-register.textfield-group.text-indent"));
        _usernameTextFieldView.textField.clearButtonMode = [GFEntryStyle(@"username-register.textfield-group.clean-mode") integerValue];
    }
    return _usernameTextFieldView;
}

- (GFTextFieldView *)passwordTextFieldView {
    if (_passwordTextFieldView == nil) {
        _passwordTextFieldView = [[GFTextFieldView alloc] init];
        
        [_passwordTextFieldView addWithButtonType:GFTextFieldButtonTypeLeft width:[GFEntryStyle(@"username-register.textfield-group.left-width") floatValue]];
        _passwordTextFieldView.leftButton.titleLabel.font = GFEntryStyle(@"username-register.textfield-group.font-size");
        _passwordTextFieldView.leftButton.contentEdgeInsets = UIEdgeInsetsFromString(GFEntryStyle(@"username-register.textfield-group.left-inset"));
        [_passwordTextFieldView.leftButton setTitle:GFEntryStyle(@"username-register.textfield-group.left-texts")[1] forState:UIControlStateNormal];
        [_passwordTextFieldView.leftButton setTitleColor:GFEntryStyle(@"username-register.textfield-group.color") forState:UIControlStateNormal];
        
        _passwordTextFieldView.textField.layer.borderColor = [GFEntryStyle(@"username-register.textfield-group.border-color") CGColor];
        _passwordTextFieldView.textField.layer.borderWidth = [GFEntryStyle(@"username-register.textfield-group.border-width") floatValue];
        _passwordTextFieldView.textField.layer.cornerRadius = [GFEntryStyle(@"username-register.textfield-group.border-radius") floatValue];
        _passwordTextFieldView.textField.placeholder = GFEntryStyle(@"username-register.textfield-group.placeholders")[1];
        _passwordTextFieldView.textField.textColor = GFEntryStyle(@"username-register.textfield-group.color");
        _passwordTextFieldView.textField.font = GFEntryStyle(@"username-register.textfield-group.font-size");
        _passwordTextFieldView.textField.placeholderInsets = UIEdgeInsetsFromString(GFEntryStyle(@"username-register.textfield-group.placeholder-indent"));
        _passwordTextFieldView.textField.textInsets = UIEdgeInsetsFromString(GFEntryStyle(@"username-register.textfield-group.text-indent"));
        _passwordTextFieldView.textField.clearButtonMode = [GFEntryStyle(@"username-register.textfield-group.clean-mode") integerValue];
    }
    return _passwordTextFieldView;
}

- (UIButton *)registerButton {
    if (_registerButton == nil) {
        _registerButton = [[UIButton alloc] init];
        _registerButton.titleLabel.font = GFEntryStyle(@"username-register.register.font-size");
        _registerButton.backgroundColor = GFEntryStyle(@"username-register.register.background-color");
        [_registerButton setTitle:GFEntryStyle(@"username-register.register.text") forState:UIControlStateNormal];
        [_registerButton setTitleColor:GFEntryStyle(@"username-register.register.color") forState:UIControlStateNormal];
        [_registerButton addTarget:self action:@selector(registerButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerButton;
}

- (UIButton *)agreementButton {
    if (_agreementButton == nil) {
        _agreementButton = [[UIButton alloc] init];
        _agreementButton = [[UIButton alloc] init];
        _agreementButton.titleLabel.font = GFEntryStyle(@"username-register.agreement.font-size");
        NSString * prefix = GFEntryStyle(@"username-register.agreement.prefix-text");
        NSString * suffix = GFEntryStyle(@"username-register.agreement.suffix-text");
        NSMutableAttributedString * string = [[NSMutableAttributedString alloc] initWithString:
                                       [NSString stringWithFormat:@"%@%@",
                                        prefix,
                                        suffix
                                        ]];
        [string addAttribute:NSForegroundColorAttributeName
                       value:GFEntryStyle(@"username-register.agreement.suffix-color")
                       range:NSMakeRange(prefix.length, suffix.length)];
        [_agreementButton setAttributedTitle:string forState:UIControlStateNormal];
        [_agreementButton addTarget:self action:@selector(agreementButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _agreementButton;
}

- (UILabel *)usernameTipLabel {
    if (_usernameTipLabel == nil) {
        _usernameTipLabel = [[UILabel alloc] init];
        _usernameTipLabel.hidden = YES;
    }
    return _usernameTipLabel;
}

- (UILabel *)passwordTipLabel {
    if (_passwordTipLabel == nil) {
        _passwordTipLabel = [[UILabel alloc] init];
        _passwordTipLabel.hidden = YES;
    }
    return _passwordTipLabel;
}

@end
