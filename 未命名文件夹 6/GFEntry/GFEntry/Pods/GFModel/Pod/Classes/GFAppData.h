//
//  GFAppData.h
//  GFModel
//
//  Created by huangjian on 17/3/21.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GFAppData : NSObject

@property (nonatomic, copy) NSString * channelID;       //渠道号
@property (nonatomic, copy) NSString * adID;
@property (nonatomic, copy) NSString * productID;       //产品ID
@property (nonatomic, copy) NSString * appid;           //应用唯一ID
@property (nonatomic, copy) NSString * uuid;            //客户端唯一ID
@property (nonatomic, copy) NSString * time;
@property (nonatomic, copy) NSString * platformid;      //平台标识ID
@property (nonatomic, copy) NSString * version;         //好玩友SDK版本号
@property (nonatomic, copy) NSString * gameVersion;     //游戏版本
@property (nonatomic, copy) NSString * mac;             //mac串
@property (nonatomic, copy) NSString * device;
@property (nonatomic, copy) NSString * model;
@property (nonatomic, copy) NSString * appKey;
@property (nonatomic, readonly) BOOL isReachable;
@property (nonatomic, assign)   BOOL isSandbox;
@property (nonatomic, copy) NSString * tryKey;          //游客试玩key
@property (nonatomic, strong) NSString * gameid;        //工单分类(can't be nil)
@property (nonatomic, strong) NSString * sort;          //工单分类(can't be nil)
@property (nonatomic, strong) NSString * clientType;    //客户端类型
@property (nonatomic, strong) NSString * os;            //移动设备的操作系统

+ (instancetype)current;

@end
