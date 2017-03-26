//
//  GFPersistenceSandbox.m
//  GFPersistence
//
//  Created by huangjian on 17/3/14.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import "GFPersistence.h"
#import "GFPersistenceLocalFileManager.h"
#import "GFPersistenceLocalFileModel.h"
#import <UIKit/UIKit.h>
#import "JSONKit.h"
#import "XMLDictionary.h"

@interface GFPersistenceSandbox ()

@property (nonatomic, retain) NSMutableDictionary * localFileMap;

@end

@implementation GFPersistenceSandbox

+ (instancetype)shared {
    static GFPersistenceSandbox * instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
        instance.localFileMap = [[NSMutableDictionary alloc] init];
    });
    return instance;
}

+ (void)writeWithModel:(GFPersistenceLocalFileModel *)model data:(id)data {
    [[self shared] writeWithModel:model data:data];
}

+ (void)removeWithModel:(GFPersistenceLocalFileModel *)model {
    [[self shared] removeWithModel:model];
}

+ (id)dataWithModel:(GFPersistenceLocalFileModel *)model {
    return [[self shared] dataWithModel:model];
}

+ (NSString *)pathWithModel:(GFPersistenceLocalFileModel *)model {
    return [[self shared] pathWithModel:model];
}

- (void)writeWithModel:(GFPersistenceLocalFileModel *)model data:(id)data {
    NSData * contentData = data;
    
    if (model.fileType == GFPersistenceFileType_Image) {
        contentData = UIImageJPEGRepresentation(data, 1.0);
    }
    [[NSFileManager defaultManager] createFileAtPath:model.filePath contents:contentData attributes:nil];
}

- (void)removeWithModel:(GFPersistenceLocalFileModel *)model {
    [[NSFileManager defaultManager] removeItemAtPath:model.filePath error:nil];
}

- (id)dataWithModel:(GFPersistenceLocalFileModel *)model {
    switch (model.fileType) {
        case GFPersistenceFileType_Image:
            return [UIImage imageWithContentsOfFile:model.filePath];
        case GFPersistenceFileType_JSON:
            return [[NSData dataWithContentsOfFile:model.filePath] objectFromJSONData];
        case GFPersistenceFileType_XML:
            return [NSDictionary dictionaryWithXMLData:[NSData dataWithContentsOfFile:model.filePath]];
        default:
            return nil;
    }
}

- (NSString *)pathWithModel:(GFPersistenceLocalFileModel *)model {
    return model.filePath;
}

@end
