//
//  GFDateFormater.h
//  GameFriendSDK
//
//  Created by  好玩友2 on 16/1/18.
//  Copyright © 2016年  好玩友2. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <Foundation/Foundation.h>

typedef enum {
    GFDateFormatterStyleDefault,
    GFDateFormatterStyleYMD,
    GFDateFormatterStyleUpdate
} GFDateFormatterStyle;

// time interval
#define GFMINUTE 60
#define GFHOUR   (60 * GFMINUTE)
#define GFDAY    (24 * GFHOUR)
#define GFMONTH    (30 * GFDAY)

@interface GFDateFormatter : NSObject

// Date format: 09:05 AM
+ (NSString *)formatTime:(NSDate *)date;

// Date format: Sept 27, '09
+ (NSString*)formatDate:(NSDate *)date;

+ (NSString*)formatDate:(NSDate *)date style:(GFDateFormatterStyle)style;

// Date format: Sept 27, '09 09:05 AM
+ (NSString *)formatDateTime:(NSDate *)date;

// Today, Yesterday, others: Sept 27, '09
+ (NSString*)formatDay:(NSDate *)date;

// Today 09:05 AM, Yesterday 09:05 AM, others: Sept 27, '09 09:05 AM
+ (NSString*)formatDayTime:(NSDate *)date;

+ (NSString *)formatRelativeTime:(NSDate *)date;

// Date format: September
+ (NSString*)formatMonth:(NSDate *)date;

// Date format: 2009
+ (NSString*)formatYear:(NSDate *)date;

// source string is like 2011-08-11T09:38:49+0000
+ (NSDate *)dateFromGMTString:(NSString *)str;

+ (NSString*)formatTimeForChat:(NSDate *)date;

//比较两个时间是否属于同一秒
+ (BOOL)isEqualInMinute:(NSDate *)date compareDate:(NSDate *)compareDate;

@end
