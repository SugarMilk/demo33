
#import "GFThemeManager.h"
#import <objc/runtime.h>
#import "GFColorUtil.h"
#import "UIImageAdditions.h"
#import "NSStringAdditions.h"

@interface GFThemeManager()

@property (nonatomic, strong) NSDictionary *themeData;
@property (nonatomic, strong) NSString *resourceDir;
@property (nonatomic, strong) NSString *themeStyle;

@end

@implementation GFThemeManager

@synthesize themeData,themeStyle,resourceDir;

#pragma mark - public methods
+ (instancetype)defaultManager{
    static dispatch_once_t onceToken;
    static GFThemeManager *defaultCenter;
    dispatch_once(&onceToken, ^{
        defaultCenter = [[GFThemeManager alloc] init];
        NSString *themeBundle = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"SDKResource.bundle"];
        [defaultCenter setResourceFilesDirectory:themeBundle];
        NSString *themeConfig = [themeBundle stringByAppendingPathComponent:@"ThemeConfig.plist"];
        [defaultCenter setThemeConfigPlist:themeConfig];
        
        //default style
        defaultCenter.themeStyle=@"default";
    });
    return defaultCenter;
}

- (void)setThemeConfigPlist:(NSString *)filePath {
    self.themeData = [NSDictionary dictionaryWithContentsOfFile:filePath];
}

- (void)setResourceFilesDirectory:(NSString *)dir {
    self.resourceDir = dir;
}

-(void)setStyle:(GFThemeStyle)style{
    self.themeStyle = style==GFThemeStyleDefault ? @"default": @"";
}

#pragma mark - 根据key获取theme里配置的值

// 获取以class name为key的dictionary, 如果未找到，继续从父类中寻找
- (id)getValueWithClass:(Class)class key:(NSString *)key {
    if (themeData == nil) {
        [GFLogger warn:@"theme config file not set"];
    }
    NSDictionary *classDict = [themeData objectForKey:[NSString stringWithUTF8String:class_getName(class)]];
    NSDictionary *styleDict = [classDict objectForKey:[NSString stringWithFormat:@"%@", themeStyle]];
    id result = [styleDict objectForKey:key];
    if (result == nil && [class superclass] != [NSObject class]) {
        return [self getValueWithClass:[class superclass] key:key];
    }
    return result;
}

// 在GlobalThemeKeys中查找
- (id)getValueInGlobalWithKey:(NSString *)key {
    if (themeData == nil) {
        [GFLogger warn:@"theme config file not set"];
    }
    NSDictionary *classDict = [themeData objectForKey:@"GlobalThemeKeys"];
    NSDictionary *styleDict = [classDict objectForKey:[NSString stringWithFormat:@"%@", themeStyle]];
    id result = [styleDict objectForKey:key];
    return result;
}

- (id)themeValueWithObject:(id)object key:(NSString *)key inGlobal:(BOOL)inGlobal {
    if (inGlobal) {
        return [self getValueInGlobalWithKey:key];
    }
    return [self getValueWithClass:[object class] key:key];
}

- (UIColor *)colorWithObject:(id)object key:(NSString *)key inGlobal:(BOOL)inGlobal {
    id themeValue = [self themeValueWithObject:object key:key inGlobal:inGlobal];
    if (themeValue) {
        NSArray *tokens = [themeValue componentsSeparatedByString:@","];
        if (tokens.count == 2) {
            themeValue = [GFColorUtil colorWithHexString:[tokens objectAtIndex:0] alpha:[[tokens objectAtIndex:1] floatValue]];
        } else if (tokens.count == 1) {
            themeValue = [GFColorUtil colorWithHexString:[tokens objectAtIndex:0] alpha:1.0];
        } else {
            [GFLogger error:@"%@:Unrecognized color format.", [self class]];
        }
    }
    return themeValue;
}

- (UIImage *)imageWithObject:(id)object key:(NSString *)key inGlobal:(BOOL)inGlobal {
    
    id themeValue = [self themeValueWithObject:object key:key inGlobal:inGlobal];
    
    NSArray *tokens = [themeValue componentsSeparatedByString:@","];
    NSString *path = [tokens objectAtIndex:0];
    UIImage *image = nil;
    
    if (path) {
        if (resourceDir) {
            NSString *imagePath = [resourceDir stringByAppendingPathComponent:path];
            image = [UIImage imageWithContentsOfFile:imagePath];
        } else {
            image = [UIImage imageNamed:path];
        }
    }
    
    if ([tokens count] == 5) {
        UIEdgeInsets capInsets = UIEdgeInsetsMake([[tokens objectAtIndex:1] floatValue], [[tokens objectAtIndex:2] floatValue], [[tokens objectAtIndex:3] floatValue], [[tokens objectAtIndex:4] floatValue]);
        image = [image resizableImageForAlliOSVersionWithCapInsets:capInsets];
    }
    
    return image;
}

- (UIFont *)fontWithObject:(id)object key:(NSString *)key inGlobal:(BOOL)inGlobal {
    id themeValue = [self themeValueWithObject:object key:key inGlobal:inGlobal];
    if (themeValue) {
        NSArray *tokens = [themeValue componentsSeparatedByString:@","];
        if (tokens.count == 2) {
            CGFloat size = [[tokens objectAtIndex:1] floatValue];
            if ([[[tokens objectAtIndex:0] trimedString] isEqualToString:@"b"]) {
                themeValue = [UIFont boldSystemFontOfSize:size];
            } else {
                themeValue = [UIFont italicSystemFontOfSize:size];
            }
        } else if (tokens.count == 1) {
            CGFloat size = [[tokens objectAtIndex:0] floatValue];
            themeValue = [UIFont systemFontOfSize:size];
        } else {
            [GFLogger error:@"%@:Unrecognized font format.", [self class]];
        }
    }
    return themeValue;
}

@end
