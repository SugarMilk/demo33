//
//  GFUserListLoginPopView.h
//  GFEntry
//
//  Created by huangjian on 17/3/22.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM (NSUInteger, GFUserListLoginPopViewActionType) {
    GFUserListLoginPopViewActionTypeSelect,
    GFUserListLoginPopViewActionTypeRemove,
};

typedef BOOL(^GFUserListLoginPopViewActionBlock)(NSIndexPath * indexPath, GFUserListLoginPopViewActionType actionType);

@interface GFUserListLoginPopView : UIView

- (void)setDataSourceArray:(NSArray *)array;
- (void)handlePopViewActionBlock:(GFUserListLoginPopViewActionBlock)actionBlock;

@end
