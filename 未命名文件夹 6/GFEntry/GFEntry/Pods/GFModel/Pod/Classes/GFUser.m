//
//  GFUser.m
//  GFModel
//
//  Created by huangjian on 17/3/17.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import "GFUser.h"

@interface GFUser ()

@property (nonatomic, assign) BOOL isTryUser;

@end

@implementation GFUser

+ (instancetype)current {
    static GFUser * instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (void)reset {
    self.userName = self.uid = self.token = self.mobile = self.email = self.vipName = self.vipLevel = self.hasAuthed = nil;
    self.hasLogined = NO;
}

- (BOOL)isTryUser {
    return [self.userName hasSuffix:@"@t"];
}

#pragma mark - NSCoding

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.userName = [aDecoder decodeObjectForKey:@"userName"];
        self.uid = [aDecoder decodeObjectForKey:@"uid"];
        self.token = [aDecoder decodeObjectForKey:@"token"];
        self.email = [aDecoder decodeObjectForKey:@"email"];
        self.mobile = [aDecoder decodeObjectForKey:@"mobile"];
        self.vipName = [aDecoder decodeObjectForKey:@"vipName"];
        self.vipLevel = [aDecoder decodeObjectForKey:@"vipLevel"];
        self.hasAuthed = [aDecoder decodeObjectForKey:@"hasAuthed"];
        self.hasLogined = [aDecoder decodeBoolForKey:@"hasLogined"];
        self.isTryUser = [aDecoder decodeBoolForKey:@"isTryUser"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.userName forKey:@"userName"];
    [aCoder encodeObject:self.uid forKey:@"uid"];
    [aCoder encodeObject:self.token forKey:@"token"];
    [aCoder encodeObject:self.email forKey:@"email"];
    [aCoder encodeObject:self.mobile forKey:@"mobile"];
    [aCoder encodeObject:self.vipName forKey:@"vipName"];
    [aCoder encodeObject:self.vipLevel forKey:@"vipLevel"];
    [aCoder encodeObject:self.hasAuthed forKey:@"hasAuthed"];
    [aCoder encodeBool:self.hasLogined forKey:@"hasLogined"];
    [aCoder encodeBool:self.isTryUser forKey:@"isTryUser"];
}

- (NSString *)description {
    NSMutableString * string = [NSMutableString string];
    [string appendFormat:@"\n GFUser:  %p \n", self];
    [string appendFormat:@" userName:  %@ \n", self.userName];
    [string appendFormat:@" uid:  %@ \n", self.uid];
    [string appendFormat:@" token:  %@ \n", self.token];
    [string appendFormat:@" email:  %@ \n", self.email];
    [string appendFormat:@" mobile:  %@ \n", self.mobile];
    [string appendFormat:@" vipName:  %@ \n", self.vipName];
    [string appendFormat:@" vipLevel:  %@ \n", self.vipLevel];
    [string appendFormat:@" hasAuthed:  %@ \n", self.hasAuthed];
    [string appendFormat:@" hasLogined:  %d \n", self.hasLogined];
    [string appendFormat:@" isTryUser:  %d \n", self.isTryUser];
    return string;
}

@end
