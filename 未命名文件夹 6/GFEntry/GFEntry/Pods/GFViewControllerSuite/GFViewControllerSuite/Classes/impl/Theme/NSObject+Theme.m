
#import "NSObject+Theme.h"
#import "GFThemeManager.h"


@implementation NSObject(NSObject)

#pragma mark - 在class name节点下查找属性的theme值

- (id)themeValueForKey:(NSString *)key {
    return [[GFThemeManager defaultManager] themeValueWithObject:self key:key inGlobal:NO];
}

- (UIColor *)colorForKey:(NSString *)key {
    return [[GFThemeManager defaultManager] colorWithObject:self key:key inGlobal:NO];
}

- (UIImage *)imageForKey:(NSString *)key {
    return [[GFThemeManager defaultManager] imageWithObject:self key:key inGlobal:NO];
}

- (UIFont *)fontForKey:(NSString *)key {
    return [[GFThemeManager defaultManager] fontWithObject:self key:key inGlobal:NO];
}

#pragma mark - 在Global节点下查找属性的theme值

- (id)themeValueInGlobalForKey:(NSString *)key {
    return [[GFThemeManager defaultManager] themeValueWithObject:self key:key inGlobal:YES];
}

- (UIColor *)colorInGlobalForKey:(NSString *)key {
    return [[GFThemeManager defaultManager] colorWithObject:self key:key inGlobal:YES];
}

- (UIImage *)imageInGlobalForKey:(NSString *)key {
    return [[GFThemeManager defaultManager] imageWithObject:self key:key inGlobal:YES];
}

- (UIFont *)fontInGlobalForKey:(NSString *)key {
    return [[GFThemeManager defaultManager] fontWithObject:self key:key inGlobal:YES];
}

@end
