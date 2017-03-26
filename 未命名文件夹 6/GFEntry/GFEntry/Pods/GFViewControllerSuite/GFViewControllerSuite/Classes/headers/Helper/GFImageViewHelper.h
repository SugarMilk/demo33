

#import <Foundation/Foundation.h>

@interface GFImageViewHelper : NSObject

//封装了SDWebimage 用于异步显示
+(UIImageView *)imageViewWithUrl:(NSString *)urlString;

//根据性别展示默认头像
+(UIImageView *)imageViewWithSexStr:(NSString *)sexStr;

@end
