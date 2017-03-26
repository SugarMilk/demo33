//
//  GFUserListLoginPopViewCell.h
//  GFEntry
//
//  Created by huangjian on 17/3/22.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GFCommon.h"

@interface GFUserListLoginPopViewCell : UITableViewCell

@property (nonatomic, copy) NSString * username;

- (void)handlePopViewCellRemoveAction:(id_block_t)actionBlock;

@end
