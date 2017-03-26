
#import <Foundation/Foundation.h>

@interface GFHudHelper : NSObject

+ (instancetype)defaultHelper;

//居中显示
-(void)showToastMessage:(NSString *)message;

//底部显示
-(void)showToastMessageAtBottom:(NSString *)message;

@end
