
#import <Foundation/Foundation.h>

typedef NS_ENUM (NSUInteger, GFThemeStyle){
    GFThemeStyleDefault
};    //目前只有默认类型

@interface GFThemeManager : NSObject

/**
 主题管理，从plist文件中获取对应键值的颜色，图片名称等
 */
+ (GFThemeManager *)defaultManager;

/**
 设置theme配置文件的路径，文件类型为plist。
 如果未设置，系统默认在main bundle的根目录下读取theme.plist。
 */
- (void)setThemeConfigPlist:(NSString *)filePath;

/**
 设置theme中配置的资源文件所在的目录。
 如果未设置，系统默认在main bundle的根目录下读取资源文件。
 */
- (void)setResourceFilesDirectory:(NSString *)dir;

-(void)setStyle:(GFThemeStyle)themeStyle;

//////////////////////根据key获取theme里配置的值////////////////////////

/**
 获取某个对象中指定key在所对应theme的值。
 调用此方法之前需确保object已经设置了style。
 如果object的class name下没有找到key对应的值，就从父类class name对应的dictionary中寻找。
 @param inGlobal 在GlobalThemeKeys中查找
 */
- (id)themeValueWithObject:(id)object key:(NSString *)key inGlobal:(BOOL)inGlobal;

/**
 value in plist: hexValue, [alpha]
 例如#000000, 0.5或者#000000
 */
- (UIColor *)colorWithObject:(id)object key:(NSString *)key inGlobal:(BOOL)inGlobal;

/**
 value in plist: xxx/xxx.png或者xxx.png
 */
- (UIImage *)imageWithObject:(id)object key:(NSString *)key inGlobal:(BOOL)inGlobal;

/**
 value in plist: b/i, fontSize或者fontSize（默认是systemFontOfSize）
 b boldSystemFontOfSize
 i italicSystemFontOfSize
 例如 b, 14.0或者14.0
 */
- (UIFont *)fontWithObject:(id)object key:(NSString *)key inGlobal:(BOOL)inGlobal;





@end
