//
//  GFUserListLoginView.m
//  GFEntry
//
//  Created by huangjian on 17/3/22.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import "GFUserListLoginView.h"
#import "GFEntryStyle.h"
#import <GFUtil/GFTextField.h>
#import <Masonry/Masonry.h>
#import "GFUserListLoginPopView.h"

@interface GFUserListLoginView ()

@property (nonatomic, strong) GFTextFieldView * usernameTextFieldView;
@property (nonatomic, strong) UIButton * loginButton;
@property (nonatomic, strong) UIImageView * lineImageView;
@property (nonatomic, strong) UIButton * switchAccountButton;
@property (nonatomic, strong) GFUserListLoginPopView * popView;
@property (nonatomic, retain) NSMutableArray * dataSource;
@property (nonatomic, assign) BOOL popViewHidden;

@property (nonatomic, copy) GFUserListLoginViewButtonActionBlock buttonActionBlock;

@end

@implementation GFUserListLoginView

- (instancetype)init {
    if (self = [super init]) {
        [self addSubview:self.usernameTextFieldView];
        [self addSubview:self.loginButton];
        [self addSubview:self.lineImageView];
        [self addSubview:self.switchAccountButton];
        [self addSubview:self.popView];
        self.popViewHidden = YES;
    }
    return self;
}

- (void)setPopViewHidden:(BOOL)popViewHidden {
    self.popView.hidden = _popViewHidden = popViewHidden;
}

- (void)setDataSourceArray:(NSArray *)array {
    self.dataSource = [NSMutableArray arrayWithArray:array];
}

- (void)handleButtonActionBlock:(GFUserListLoginViewButtonActionBlock)buttonActionBlock {
    self.buttonActionBlock = buttonActionBlock;
}

- (void)loginButtonAction:(UIButton *)button {
    if (self.buttonActionBlock) {
#warning 用户列表登录回调内容
        self.buttonActionBlock(nil, GFUserListLoginViewButtonTypeLogin);
    }
}

- (void)switchAccountButtonAction:(UIButton *)button {
    if (self.buttonActionBlock) {
        self.buttonActionBlock(button, GFUserListLoginViewButtonTypeSwitchAccount);
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.popView.backgroundColor = [UIColor orangeColor];
    
    [self.usernameTextFieldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self).with.insets(UIEdgeInsetsFromString(GFEntryStyle(@"userlist-login.input.margin")));
        make.height.mas_equalTo([GFEntryStyle(@"userlist-login.input.height") floatValue]);
    }];
    
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.usernameTextFieldView.mas_bottom).with.offset([GFEntryStyle(@"userlist-login.login.margin-top") floatValue]);
        make.left.right.equalTo(self.usernameTextFieldView);
        make.height.mas_equalTo([GFEntryStyle(@"userlist-login.login.height") floatValue]);
    }];
    
    [self.lineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.loginButton.mas_bottom).with.offset([GFEntryStyle(@"userlist-login.h-line.margin-top") floatValue]);
        make.left.and.right.equalTo(self.usernameTextFieldView).with.insets(UIEdgeInsetsFromString(GFEntryStyle(@"userlist-login.h-line.margin-h")));
        make.height.mas_equalTo([GFEntryStyle(@"userlist-login.h-line.height") floatValue]);
    }];
    
    [self.switchAccountButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineImageView.mas_bottom).with.offset([GFEntryStyle(@"userlist-login.switch.margin-top") floatValue]);
        make.centerX.equalTo(self.mas_centerX);
        make.size.mas_equalTo(CGSizeFromString(GFEntryStyle(@"userlist-login.switch.size")));
    }];
    
    [self.popView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.usernameTextFieldView.mas_bottom).with.offset(2);
        make.left.and.right.equalTo(self.usernameTextFieldView);
        make.height.mas_equalTo(100);
    }];
}

- (GFTextFieldView *)usernameTextFieldView {
    if (_usernameTextFieldView == nil) {
        _usernameTextFieldView = [[GFTextFieldView alloc] init];
        _usernameTextFieldView.shouldBeEdited = NO;
        _usernameTextFieldView.textField.text = @"hwy123456";
        
        [_usernameTextFieldView addWithButtonType:GFTextFieldButtonTypeLeft width:[GFEntryStyle(@"userlist-login.input.left-width") floatValue]];
        [_usernameTextFieldView addWithButtonType:GFTextFieldButtonTypeRight width:[GFEntryStyle(@"userlist-login.input.right-width") floatValue]];
        _usernameTextFieldView.leftButton.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.3];
        _usernameTextFieldView.rightButton.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.3];
        
        _usernameTextFieldView.textField.layer.borderColor = [GFEntryStyle(@"userlist-login.input.border-color") CGColor];
        _usernameTextFieldView.textField.layer.borderWidth = [GFEntryStyle(@"userlist-login.input.border-width") floatValue];
        _usernameTextFieldView.textField.layer.cornerRadius = [GFEntryStyle(@"userlist-login.input.border-radius") floatValue];
        _usernameTextFieldView.textField.textColor = GFEntryStyle(@"userlist-login.input.color");
        _usernameTextFieldView.textField.font = GFEntryStyle(@"userlist-login.input.font-size");
        
        [_usernameTextFieldView handleRightButtonAction:^(UIButton *button) {
            self.popViewHidden = !self.popViewHidden;
        }];
    }
    return _usernameTextFieldView;
}

- (UIButton *)loginButton {
    if (_loginButton == nil) {
        _loginButton = [[UIButton alloc] init];
        _loginButton.titleLabel.font = GFEntryStyle(@"userlist-login.login.font-size");
        _loginButton.backgroundColor = GFEntryStyle(@"userlist-login.login.background-color");
        [_loginButton setTitle:GFEntryStyle(@"userlist-login.login.text") forState:UIControlStateNormal];
        [_loginButton setTitleColor:GFEntryStyle(@"userlist-login.login.color") forState:UIControlStateNormal];
        [_loginButton addTarget:self action:@selector(loginButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}

- (UIButton *)switchAccountButton {
    if (_switchAccountButton == nil) {
        _switchAccountButton = [[UIButton alloc] init];
        _switchAccountButton.titleLabel.font = GFEntryStyle(@"userlist-login.switch.font-size");
        _switchAccountButton.backgroundColor = GFEntryStyle(@"userlist-login.switch.background-color");
        [_switchAccountButton setTitle:GFEntryStyle(@"userlist-login.switch.text") forState:UIControlStateNormal];
        [_switchAccountButton setTitleColor:GFEntryStyle(@"userlist-login.switch.color") forState:UIControlStateNormal];
        [_switchAccountButton addTarget:self action:@selector(switchAccountButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _switchAccountButton;
}

- (UIImageView *)lineImageView {
    if (_lineImageView == nil) {
        _lineImageView = [[UIImageView alloc] init];
        _lineImageView.backgroundColor = GFEntryStyle(@"userlist-login.h-line.background-color");
    }
    return _lineImageView;
}

- (GFUserListLoginPopView *)popView {
    if (_popView == nil) {
        _popView = [[GFUserListLoginPopView alloc] init];
        [_popView handlePopViewActionBlock:^BOOL(NSIndexPath *indexPath, GFUserListLoginPopViewActionType actionType) {
#warning 用户列表移除回调内容
            if (actionType == GFUserListLoginPopViewActionTypeRemove) {
                if (self.buttonActionBlock) {
                    if (self.buttonActionBlock(nil, GFUserListLoginViewButtonTypeRemove)) {
                        return YES;
                    }
                }
            } else if (actionType == GFUserListLoginPopViewActionTypeSelect) {
                return YES;
            }
            return NO;
        }];
    }
    return _popView;
}

@end
