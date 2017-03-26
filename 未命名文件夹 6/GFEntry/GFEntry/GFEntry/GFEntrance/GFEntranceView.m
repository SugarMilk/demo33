//
//  GFEntranceView.m
//  GFEntry
//
//  Created by huangjian on 17/3/20.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import "GFEntranceView.h"
#import "GFEntryStyle.h"
#import <Masonry/Masonry.h>
#import <GFUtil/UIButton+GFImagePosition.h>

@interface GFEntranceView ()

@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UIButton * touristLoginButton;
@property (nonatomic, strong) UIButton * registerButton;
@property (nonatomic, strong) UIButton * mobilePhoneLoginButton;
@property (nonatomic, strong) UIButton * userNameLoginButton;
@property (nonatomic, strong) UIImageView * lineImageView;

@property (nonatomic, copy) GFEntranceViewButtonActionBlock buttonActionBlock;

@end


@implementation GFEntranceView

- (instancetype)init {
    if (self = [super init]) {
        [self addSubview:self.touristLoginButton];
        [self addSubview:self.registerButton];
        [self addSubview:self.mobilePhoneLoginButton];
        [self addSubview:self.lineImageView];
        [self addSubview:self.userNameLoginButton];
        [self addSubview:self.titleLabel];
    }
    return self;
}

- (void)handleButtonActionBlock:(GFEntranceViewButtonActionBlock)buttonActionBlock {
    self.buttonActionBlock = buttonActionBlock;
}

- (void)touristLoginButtonAction:(UIButton *)button {
    if (self.buttonActionBlock) {
        self.buttonActionBlock(button, GFEntranceViewButtonTypeTouristLogin);
    }
}

- (void)registerButtonAction:(UIButton *)button {
    if (self.buttonActionBlock) {
        self.buttonActionBlock(button, GFEntranceViewButtonTypeRegister);
    }
}

- (void)mobilePhoneLoginButtonAction:(UIButton *)button {
    if (self.buttonActionBlock) {
        self.buttonActionBlock(button, GFEntranceViewButtonTypeMobilePhoneLogin);
    }
}

- (void)userNameLoginButtonAction:(UIButton *)button {
    if (self.buttonActionBlock) {
        self.buttonActionBlock(button, GFEntranceViewButtonTypeUserNameLogin);
    }
}

- (void)layoutSubviews {
    
    CGSize buttonSize = CGSizeFromString(GFEntryStyle(@"entrance.button-group.size"));
    CGFloat buttonPadding = [GFEntryStyle(@"entrance.button-group.padding") floatValue];
    
    [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY).with.offset([GFEntryStyle(@"entrance.button-group.center-y") floatValue]);
        make.size.mas_equalTo(buttonSize);
    }];
    
    [self.mobilePhoneLoginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.registerButton.mas_right).with.offset(buttonPadding);
        make.top.equalTo(self.registerButton);
        make.size.mas_equalTo(buttonSize);
    }];
    
    [self.touristLoginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.registerButton.mas_left).with.offset(-buttonPadding);
        make.top.equalTo(self.registerButton);
        make.size.mas_equalTo(buttonSize);
    }];
    
    [self.lineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.registerButton.mas_bottom).with.offset([GFEntryStyle(@"entrance.h-line.margin-top") floatValue]);
        make.centerX.equalTo(self.mas_centerX);
        make.left.equalTo(self.touristLoginButton.mas_left);
        make.right.equalTo(self.mobilePhoneLoginButton.mas_right);
        make.height.mas_equalTo(GFEntryStyle(@"entrance.h-line.height"));
    }];
    
    [self.userNameLoginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineImageView.mas_bottom).with.offset([GFEntryStyle(@"entrance.username-login.margin-top") floatValue]);
        make.centerX.equalTo(self.mas_centerX);
        make.size.mas_equalTo(CGSizeFromString(GFEntryStyle(@"entrance.username-login.size")));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).with.offset([GFEntryStyle(@"entrance.choose-way.margin-top") floatValue]);
        make.centerX.equalTo(self.mas_centerX);
        make.left.equalTo(self.touristLoginButton.mas_left);
        make.right.equalTo(self.mobilePhoneLoginButton.mas_right);
        make.height.mas_equalTo(GFEntryStyle(@"entrance.choose-way.height"));
    }];
    
    [super layoutSubviews];
}

- (UIButton *)touristLoginButton {
    if (_touristLoginButton == nil) {
        _touristLoginButton = [[UIButton alloc] init];
        _touristLoginButton.backgroundColor = GFEntryStyle(@"entrance.button-group.background-color");
        _touristLoginButton.titleLabel.font = GFEntryStyle(@"entrance.button-group.font-size");
        [_touristLoginButton setTitle:GFEntryStyle(@"entrance.button-group.texts")[0] forState:UIControlStateNormal];
        [_touristLoginButton setTitleColor:GFEntryStyle(@"entrance.button-group.color") forState:UIControlStateNormal];
        [_touristLoginButton setImage:GFEntryStyle(@"entrance.button-group.images")[0] forState:UIControlStateNormal];
        [_touristLoginButton addTarget:self action:@selector(touristLoginButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_touristLoginButton gf_setImagePosition:GFImagePositionTop inset:[GFEntryStyle(@"entrance.button-group.image-text-inset") floatValue]];
    }
    return _touristLoginButton;
}

- (UIButton *)registerButton {
    if (_registerButton == nil) {
        _registerButton = [[UIButton alloc] init];
        _registerButton.backgroundColor = GFEntryStyle(@"entrance.button-group.background-color");
        _registerButton.titleLabel.font = GFEntryStyle(@"entrance.button-group.font-size");
        [_registerButton setTitle:GFEntryStyle(@"entrance.button-group.texts")[1] forState:UIControlStateNormal];
        [_registerButton setTitleColor:GFEntryStyle(@"entrance.button-group.color") forState:UIControlStateNormal];
        [_registerButton setImage:GFEntryStyle(@"entrance.button-group.images")[1] forState:UIControlStateNormal];
        [_registerButton addTarget:self action:@selector(registerButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_registerButton gf_setImagePosition:GFImagePositionTop inset:[GFEntryStyle(@"entrance.button-group.image-text-inset") floatValue]];
    }
    return _registerButton;
}

- (UIButton *)mobilePhoneLoginButton {
    if (_mobilePhoneLoginButton == nil) {
        _mobilePhoneLoginButton = [[UIButton alloc] init];
        _mobilePhoneLoginButton.backgroundColor = GFEntryStyle(@"entrance.button-group.background-color");
        _mobilePhoneLoginButton.titleLabel.font = GFEntryStyle(@"entrance.button-group.font-size");
        [_mobilePhoneLoginButton setTitle:GFEntryStyle(@"entrance.button-group.texts")[2] forState:UIControlStateNormal];
        [_mobilePhoneLoginButton setTitleColor:GFEntryStyle(@"entrance.button-group.color") forState:UIControlStateNormal];
        [_mobilePhoneLoginButton setImage:GFEntryStyle(@"entrance.button-group.images")[2] forState:UIControlStateNormal];
        [_mobilePhoneLoginButton addTarget:self action:@selector(mobilePhoneLoginButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_mobilePhoneLoginButton gf_setImagePosition:GFImagePositionTop inset:[GFEntryStyle(@"entrance.button-group.image-text-inset") floatValue]];
    }
    return _mobilePhoneLoginButton;
}

- (UIButton *)userNameLoginButton {
    if (_userNameLoginButton == nil) {
        _userNameLoginButton = [[UIButton alloc] init];
        _userNameLoginButton.titleLabel.font = GFEntryStyle(@"entrance.username-login.font-size");
        _userNameLoginButton.backgroundColor = GFEntryStyle(@"entrance.username-login.background-color");
        [_userNameLoginButton setTitle:GFEntryStyle(@"entrance.username-login.text") forState:UIControlStateNormal];
        [_userNameLoginButton setTitleColor:GFEntryStyle(@"entrance.username-login.color") forState:UIControlStateNormal];
        [_userNameLoginButton addTarget:self action:@selector(userNameLoginButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _userNameLoginButton;
}

- (UIImageView *)lineImageView {
    if (_lineImageView == nil) {
        _lineImageView = [[UIImageView alloc] init];
        _lineImageView.backgroundColor = GFEntryStyle(@"entrance.h-line.background-color");
    }
    return _lineImageView;
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = GFEntryStyle(@"entrance.choose-way.text");
        _titleLabel.textAlignment = [GFEntryStyle(@"entrance.choose-way.text-align") integerValue];
        _titleLabel.textColor = GFEntryStyle(@"entrance.choose-way.color");
        _titleLabel.font = GFEntryStyle(@"entrance.choose-way.font-size");
        _titleLabel.backgroundColor = GFEntryStyle(@"entrance.choose-way.background-color");
    }
    return _titleLabel;
}

@end
