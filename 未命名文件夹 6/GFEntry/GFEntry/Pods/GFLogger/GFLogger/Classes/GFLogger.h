//
//  GFLogger.h
//  Pods
//
//  Created by sdk－app11 on 16/12/26.
//
//

#import <Foundation/Foundation.h>
#include <CoreGraphics/CGGeometry.h>

typedef enum {
    GFLogLevelDebug=0,
    GFLogLevelInfo,
    GFLogLevelWarn,
    GFLogLevelError,
    GFLogLevelFatal
} GFLogLevel;

@interface GFLogger : NSObject

// default error level
+ (void)setLogLevel:(GFLogLevel)level;

+ (void)debug:(NSString *)format, ...;
+ (void)info:(NSString *)format, ...;
+ (void)warn:(NSString *)format, ...;
+ (void)error:(NSString *)format, ...;
+ (void)fatal:(NSString *)format, ...;

+ (void)debugWithRect:(CGRect)rect prefix:(NSString *)prefix;
+ (void)debugWithPoint:(CGPoint)point prefix:(NSString *)prefix;
+ (void)debugWithSize:(CGSize)size prefix:(NSString *)prefix;
+ (void)debugWithViewGF:(UIView *)v prefix:(NSString *)prefix;

// log pannel
+ (void)showLogPanel;
+ (void)hideLogPanel;


@end
