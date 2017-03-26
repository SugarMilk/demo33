//
//  GFPersistenceLocalFileModel.h
//  GFPersistence
//
//  Created by huangjian on 17/3/14.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM (NSUInteger, GFPersistenceFileType){
    GFPersistenceFileType_Image,
    GFPersistenceFileType_JSON,
    GFPersistenceFileType_XML,
};

@interface GFPersistenceLocalFileModel : NSObject

@property (nonatomic, copy) NSString * fileName;
@property (nonatomic, copy) NSString * filePath;
@property (nonatomic, copy) NSString * fileTypeShortName;
@property (nonatomic, assign) GFPersistenceFileType fileType;

+ (GFPersistenceLocalFileModel *)modelWithFileName:(NSString *)fileName fileType:(GFPersistenceFileType)fileType;

@end

