
#import <Foundation/Foundation.h>

@interface GFLabelHelper : NSObject

+(UILabel *)labelWithText:(NSString *)labelText fontSize:(CGFloat)fontSize fontColor:(UIColor *)fontColor;

+(UILabel *)mulitLineLabelWithSize:(CGSize)size
                         labelText:(NSString *)labelText
                          fontSize:(CGFloat)fontSize
                         fontColor:(UIColor *)fontColor;

@end
