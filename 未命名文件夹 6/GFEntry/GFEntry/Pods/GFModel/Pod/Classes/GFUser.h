//
//  GFUser.h
//  GFModel
//
//  Created by huangjian on 17/3/17.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GFUser : NSObject <NSCoding>

@property (nonatomic, copy) NSString * userName;
@property (nonatomic, copy) NSString * uid;
@property (nonatomic, copy) NSString * token;
@property (nonatomic, copy) NSString * email;
@property (nonatomic, copy) NSString * mobile;
@property (nonatomic, copy) NSString * vipName;
@property (nonatomic, copy) NSString * vipLevel;
@property (nonatomic, copy) NSString * hasAuthed;

@property (nonatomic, assign) BOOL hasLogined;
@property (nonatomic, readonly, assign) BOOL isTryUser;

+ (instancetype)current;
- (void)reset;

@end
