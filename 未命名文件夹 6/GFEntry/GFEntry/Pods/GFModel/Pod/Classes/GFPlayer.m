//
//  GFPlayer.m
//  GFModel
//
//  Created by huangjian on 17/3/17.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import "GFPlayer.h"

@implementation GFPlayer

+ (instancetype)current {
    static GFPlayer * instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (void)reset {
    self.serverId = self.serverName = self.roleId = self.roleName = self.roleLevel = self.rolePartyId = self.rolePartyName = self.roleVocation = nil;
    self.hasLoginedInGame = NO;
}

#pragma mark - NSCoding

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.serverId = [aDecoder decodeObjectForKey:@"serverId"];
        self.serverName = [aDecoder decodeObjectForKey:@"serverName"];
        self.roleId = [aDecoder decodeObjectForKey:@"roleId"];
        self.roleName = [aDecoder decodeObjectForKey:@"roleName"];
        self.roleLevel = [aDecoder decodeObjectForKey:@"roleLevel"];
        self.rolePartyId = [aDecoder decodeObjectForKey:@"rolePartyId"];
        self.rolePartyName = [aDecoder decodeObjectForKey:@"rolePartyName"];
        self.roleVocation = [aDecoder decodeObjectForKey:@"roleVocation"];
        self.hasLoginedInGame = [aDecoder decodeBoolForKey:@"hasLoginedInGame"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.serverId forKey:@"serverId"];
    [aCoder encodeObject:self.serverName forKey:@"serverName"];
    [aCoder encodeObject:self.roleId forKey:@"roleId"];
    [aCoder encodeObject:self.roleName forKey:@"roleName"];
    [aCoder encodeObject:self.roleLevel forKey:@"roleLevel"];
    [aCoder encodeObject:self.rolePartyId forKey:@"rolePartyId"];
    [aCoder encodeObject:self.rolePartyName forKey:@"rolePartyName"];
    [aCoder encodeObject:self.roleVocation forKey:@"roleVocation"];
    [aCoder encodeBool:self.hasLoginedInGame forKey:@"hasLoginedInGame"];
}

- (NSString *)description {
    NSMutableString * string = [NSMutableString string];
    [string appendFormat:@"\n GFPlayer:  %p \n", self];
    [string appendFormat:@" serverId:  %@ \n", self.serverId];
    [string appendFormat:@" serverName:  %@ \n", self.serverName];
    [string appendFormat:@" roleId:  %@ \n", self.roleId];
    [string appendFormat:@" roleName:  %@ \n", self.roleName];
    [string appendFormat:@" roleLevel:  %@ \n", self.roleLevel];
    [string appendFormat:@" rolePartyId:  %@ \n", self.rolePartyId];
    [string appendFormat:@" rolePartyName:  %@ \n", self.rolePartyName];
    [string appendFormat:@" roleVocation:  %@ \n", self.roleVocation];
    [string appendFormat:@" hasLoginedInGame:  %d \n", self.hasLoginedInGame];
    return string;
}

@end
