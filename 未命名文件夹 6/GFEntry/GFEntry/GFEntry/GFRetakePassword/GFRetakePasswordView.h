//
//  GFRetakePasswordView.h
//  GFEntry
//
//  Created by huangjian on 17/3/22.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GFCommon.h"

@interface GFRetakePasswordView : UIView

@property (nonatomic, copy) NSString * bindIdentifier;
@property (nonatomic, copy) NSString * password;

- (void)handleButtonActionBlock:(id_block_t)buttonActionBlock;

@end
