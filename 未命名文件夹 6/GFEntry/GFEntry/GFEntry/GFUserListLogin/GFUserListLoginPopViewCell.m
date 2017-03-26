//
//  GFUserListLoginPopViewCell.m
//  GFEntry
//
//  Created by huangjian on 17/3/22.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import "GFUserListLoginPopViewCell.h"
#import <Masonry/Masonry.h>

@interface GFUserListLoginPopViewCell ()

@property (nonatomic, strong) UIImageView * iconImageView;
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UIButton * removeButton;
@property (nonatomic, copy) id_block_t actionBlock;

@end

@implementation GFUserListLoginPopViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.iconImageView];
        [self addSubview:self.titleLabel];
        [self addSubview:self.removeButton];
    }
    return self;
}

- (void)setUsername:(NSString *)username {
    self.titleLabel.text = _username = username;
}

- (void)handlePopViewCellRemoveAction:(id_block_t)actionBlock {
    self.actionBlock = actionBlock;
}

- (void)removeButtonAction:(UIButton *)button {
    if (self.actionBlock) {
        self.actionBlock(button);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.iconImageView.backgroundColor = [UIColor yellowColor];
    self.removeButton.backgroundColor = [UIColor magentaColor];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(self);
        make.width.mas_equalTo(45);
    }];
    
    [self.removeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(self).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        make.width.mas_equalTo(45);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(self.iconImageView.mas_right);
        make.right.equalTo(self.removeButton.mas_left);
    }];
}

- (UIImageView *)iconImageView {
    if (_iconImageView == nil) {
        _iconImageView = [[UIImageView alloc] init];
    }
    return _iconImageView;
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
    }
    return _titleLabel;
}

- (UIButton *)removeButton {
    if (_removeButton == nil) {
        _removeButton = [[UIButton alloc] init];
        [_removeButton addTarget:self action:@selector(removeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _removeButton;
}

@end
