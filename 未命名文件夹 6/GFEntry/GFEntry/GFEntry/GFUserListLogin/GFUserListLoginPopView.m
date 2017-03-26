//
//  GFUserListLoginPopView.m
//  GFEntry
//
//  Created by huangjian on 17/3/22.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import "GFUserListLoginPopView.h"
#import "GFUserListLoginPopViewCell.h"
#import <GFUtil/UIColor+GFHex.h>

@interface GFUserListLoginPopView () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, retain) NSMutableArray * dataSource;

@property (nonatomic, copy) GFUserListLoginPopViewActionBlock actionBlock;

@end

@implementation GFUserListLoginPopView

- (instancetype)init {
    if (self = [super init]) {
        [self addSubview:self.tableView];
    }
    return self;
}

- (void)setDataSourceArray:(NSArray *)array {
    self.dataSource = [NSMutableArray arrayWithArray:array];
}

- (void)handlePopViewActionBlock:(GFUserListLoginPopViewActionBlock)actionBlock {
    self.actionBlock = actionBlock;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * identifier = @"GFUserListLoginPopViewCell";
    
    GFUserListLoginPopViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[GFUserListLoginPopViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.contentView.backgroundColor = GFHexRandomColor;
    cell.username = @(indexPath.row).stringValue;
    
    [cell handlePopViewCellRemoveAction:^(id object) {
        if (self.actionBlock) {
            if (self.actionBlock(indexPath, GFUserListLoginPopViewActionTypeRemove)) {
                [self.dataSource removeObjectAtIndex:indexPath.row];
                [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            }
        }
    }];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.actionBlock) {
        self.actionBlock(indexPath, GFUserListLoginPopViewActionTypeSelect);
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.tableView.frame = self.bounds;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

@end
