
#import <Foundation/Foundation.h>

@interface NSObject(NSObject)

#pragma mark - 在class name节点下查找属性的theme值

- (id)themeValueForKey:(NSString *)key;
- (UIColor *)colorForKey:(NSString *)key;
- (UIImage *)imageForKey:(NSString *)key;
- (UIFont *)fontForKey:(NSString *)key;

#pragma mark - 在Global节点下查找属性的theme值

- (id)themeValueInGlobalForKey:(NSString *)key;
- (UIColor *)colorInGlobalForKey:(NSString *)key;
- (UIImage *)imageInGlobalForKey:(NSString *)key;
- (UIFont *)fontInGlobalForKey:(NSString *)key;

@end
