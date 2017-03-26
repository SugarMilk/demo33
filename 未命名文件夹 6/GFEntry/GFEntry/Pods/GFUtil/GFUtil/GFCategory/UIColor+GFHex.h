//
//  UIColor+GFHex.h
//  GFUtil
//
//  Created by huangjian on 17/3/20.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import <UIKit/UIKit.h>

#define GFHexRandomColor         [UIColor gf_randomColor]
#define GFHexStringColor(string) [UIColor gf_colorWithHexString:string]
#define GFHexRGBColor(R, G, B)   [UIColor gf_colorWith8BitRed:R green:G blue:B]

@interface UIColor (GFHex)

+ (UIColor *)gf_randomColor;

+ (UIColor *)gf_colorWithHexString:(NSString *)color;
+ (UIColor *)gf_colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

+ (UIColor *)gf_colorWith8BitRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue;
+ (UIColor *)gf_colorWith8BitRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue alpha:(CGFloat)alpha;

@end
