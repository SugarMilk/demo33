//
//  GFCommon.h
//  GFEntry
//
//  Created by huangjian on 17/3/20.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^id_block_t)(id object);

#define kGFTouchesBeganAndEndEditing \
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event { \
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES]; \
}

