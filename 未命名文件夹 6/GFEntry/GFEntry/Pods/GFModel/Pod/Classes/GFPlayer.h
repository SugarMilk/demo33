//
//  GFPlayer.h
//  GFModel
//
//  Created by huangjian on 17/3/17.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GFPlayer : NSObject <NSCoding>

@property (nonatomic, copy) NSString * serverId;
@property (nonatomic, copy) NSString * serverName;
@property (nonatomic, copy) NSString * roleId;
@property (nonatomic, copy) NSString * roleName;
@property (nonatomic, copy) NSString * roleLevel;
@property (nonatomic, copy) NSString * rolePartyId;
@property (nonatomic, copy) NSString * rolePartyName;
@property (nonatomic, copy) NSString * roleVocation;

@property (nonatomic, assign) BOOL hasLoginedInGame;

+ (instancetype)current;
- (void)reset;

@end
