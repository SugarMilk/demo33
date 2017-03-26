//
//  GFPersistenceLocalFileModel.m
//  GFPersistence
//
//  Created by huangjian on 17/3/14.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import "GFPersistenceLocalFileModel.h"
#import "GFPersistenceLocalFileManager.h"

@implementation GFPersistenceLocalFileModel

+ (GFPersistenceLocalFileModel *)modelWithFileName:(NSString *)fileName fileType:(GFPersistenceFileType)fileType {
    GFPersistenceLocalFileModel * model = [[GFPersistenceLocalFileModel alloc] init];
    model.fileType = fileType;
    
    NSString * path;
    switch (fileType) {
        case GFPersistenceFileType_Image:
            model.fileTypeShortName = @"img";
            model.fileName = [NSString stringWithFormat:@"%@.jpg", fileName];
            path = [NSString stringWithFormat:@"/imageCache"];
            break;
        case GFPersistenceFileType_JSON:
            model.fileTypeShortName = @"json";
            model.fileName = [NSString stringWithFormat:@"%@.json", fileName];
            path = [NSString stringWithFormat:@"/gfsdkcache"];
            break;
        case GFPersistenceFileType_XML:
            model.fileTypeShortName = @"xml";
            model.fileName = [NSString stringWithFormat:@"%@.xml", fileName];
            path = [NSString stringWithFormat:@"/gfsdkcache"];
            break;
        default:
            break;
    }
    model.filePath = [[[GFPersistenceLocalFileManager shared] cachesPathWithDir:path] stringByAppendingPathComponent:model.fileName];
    return model;
}

@end
