//
//  GFDateFormater.m
//  GameFriendSDK
//
//  Created by  好玩友2 on 16/1/18.
//  Copyright © 2016年  好玩友2. All rights reserved.
//

#import "GFDateFormatter.h"

NSLocale *GFCurrentLocale() {
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSArray* languages = [defaults objectForKey:@"AppleLanguages"];
    if (languages.count > 0) {
        NSString* currentLanguage = [languages objectAtIndex:0];
        return [[NSLocale alloc] initWithLocaleIdentifier:currentLanguage];
    } else {
        return [NSLocale currentLocale];
    }
}

NSString *GFStringValue(id value) {
    if ([value isKindOfClass:[NSNull class]]) {
        return nil;
    } else if ([value isKindOfClass:[NSNumber class]]) {
        return [value stringValue];
    } else {
        return value;
    }
}

static NSDateFormatter *formatter = nil;

@implementation GFDateFormatter

+ (NSDateFormatter *)sharedFormatter
{
    if (formatter == nil) {
        formatter = [[NSDateFormatter alloc] init];
        formatter.locale = GFCurrentLocale();
        [formatter setAMSymbol:@"AM"];
        [formatter setPMSymbol:@"PM"];
    }
    return formatter;
}

+ (NSString *)formatTime:(NSDate *)date
{
    [GFDateFormatter sharedFormatter].dateFormat = NSLocalizedString(@"hh:mm a", @"Date format: 09:05 AM");
    return [[GFDateFormatter sharedFormatter] stringFromDate:date];
}

+ (NSString *)formatDate:(NSDate *)date {
    return [GFDateFormatter formatDate:date style:GFDateFormatterStyleDefault];
}

+ (NSString*)formatDate:(NSDate *)date style:(GFDateFormatterStyle)style
{
    NSString *dateFormat = NSLocalizedString(@"MMM d, ''yy", @"Date format: Sept 27, '09");
    switch (style) {
        case GFDateFormatterStyleYMD:
            dateFormat = NSLocalizedString(@"yyyy-MM-dd", @"2000-01-01");
            break;
        case GFDateFormatterStyleUpdate:
            return [self getUpdateDateWith:date];
            break;
        default:
            break;
    }
    [GFDateFormatter sharedFormatter].dateFormat = dateFormat;
    return [[GFDateFormatter sharedFormatter] stringFromDate:date];
}

+ (NSString *)formatDateTime:(NSDate *)date
{
    [GFDateFormatter sharedFormatter].dateFormat = NSLocalizedString(@"MMM d, ''yy hh:mm a", @"Date format: Sept 27, '09 09:05 AM");
    return [[GFDateFormatter sharedFormatter] stringFromDate:date];
}

+ (NSString*)formatDay:(NSDate *)date
{
    NSCalendar* cal = [NSCalendar currentCalendar];
    NSDateComponents* day = [cal components:NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit
                                   fromDate:date];
    NSDateComponents* today = [cal components:NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit
                                     fromDate:[NSDate date]];
    NSDateComponents* yesterday = [cal components:NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit
                                         fromDate:[[NSDate date] dateByAddingTimeInterval:-GFDAY]];
    
    if (day.day == today.day && day.month == today.month && day.year == today.year) {
        return NSLocalizedString(@"Today", @"");
    } else if (day.day == yesterday.day && day.month == yesterday.month
               && day.year == yesterday.year) {
        return NSLocalizedString(@"Yesterday", @"");
    } else {
        return [GFDateFormatter formatDate:date];
    }
}

+ (NSString*)formatDayTime:(NSDate *)date
{
    NSCalendar* cal = [NSCalendar currentCalendar];
    NSDateComponents* day = [cal components:NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit
                                   fromDate:date];
    NSDateComponents* today = [cal components:NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit
                                     fromDate:[NSDate date]];
    NSDateComponents* yesterday = [cal components:NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit
                                         fromDate:[[NSDate date] dateByAddingTimeInterval:-GFDAY]];
    
    if (day.day == today.day && day.month == today.month && day.year == today.year) {
        return [NSString stringWithFormat:@"%@ %@", NSLocalizedString(@"Today", @""), [GFDateFormatter formatTime:date]];
    } else if (day.day == yesterday.day && day.month == yesterday.month
               && day.year == yesterday.year) {
        return [NSString stringWithFormat:@"%@ %@", NSLocalizedString(@"Yesterday", @""), [GFDateFormatter formatTime:date]];
    } else {
        return [GFDateFormatter formatDateTime:date];
    }
}

+ (NSString *)formatRelativeTime:(NSDate *)date
{
    NSTimeInterval elHTed = [date timeIntervalSinceNow];
    if (elHTed > 0) {
        if (elHTed <= 1) {
            return NSLocalizedString(@"in just a moment", @"");
        } else if (elHTed < GFMINUTE) {
            int seconds = (int)(elHTed);
            return [NSString stringWithFormat:NSLocalizedString(@"in %d seconds", @""), seconds];
        } else if (elHTed < 2*GFMINUTE) {
            return NSLocalizedString(@"in about a minute", @"");
        } else if (elHTed < GFHOUR) {
            int mins = (int)(elHTed/GFMINUTE);
            return [NSString stringWithFormat:NSLocalizedString(@"in %d minutes", @""), mins];
        } else if (elHTed < GFHOUR*1.5) {
            return NSLocalizedString(@"in about an hour", @"");
        } else if (elHTed < GFDAY) {
            int hours = (int)((elHTed+GFHOUR/2)/GFHOUR);
            return [NSString stringWithFormat:NSLocalizedString(@"in %d hours", @""), hours];
        } else {
            return [GFDateFormatter formatDateTime:date];
        }
    } else {
        elHTed = -elHTed;
        if (elHTed <= 1) {
            return NSLocalizedString(@"just a moment ago", @"");
        } else if (elHTed < GFMINUTE) {
            int seconds = (int)(elHTed);
            return [NSString stringWithFormat:NSLocalizedString(@"%d seconds ago", @""), seconds];
        } else if (elHTed < 2*GFMINUTE) {
            return NSLocalizedString(@"about a minute ago", @"");
        } else if (elHTed < GFHOUR) {
            int mins = (int)(elHTed/GFMINUTE);
            return [NSString stringWithFormat:NSLocalizedString(@"%d minutes ago", @""), mins];
        } else if (elHTed < GFHOUR*1.5) {
            return NSLocalizedString(@"about an hour ago", @"");
        } else if (elHTed < GFDAY) {
            int hours = (int)((elHTed+GFHOUR/2)/GFHOUR);
            return [NSString stringWithFormat:NSLocalizedString(@"%d hours ago", @""), hours];
        } else {
            return [GFDateFormatter formatDayTime:date];
        }
    }
}

+ (NSString*)formatMonth:(NSDate *)date
{
    [GFDateFormatter sharedFormatter].dateFormat = NSLocalizedString(@"MMMM", @"Date format: July");
    return [[GFDateFormatter sharedFormatter] stringFromDate:date];
}

+ (NSString*)formatYear:(NSDate *)date
{
    [GFDateFormatter sharedFormatter].dateFormat = NSLocalizedString(@"yyyy", @"Date format: 2009");
    return [[GFDateFormatter sharedFormatter] stringFromDate:date];
}

+ (NSDate *)dateFromGMTString:(NSString *)str
{
    [GFDateFormatter sharedFormatter].dateFormat = NSLocalizedString(@"yyyy-MM-dd HH:mm:ss", @"");
    return [[GFDateFormatter sharedFormatter] dateFromString:str];
}

+ (NSString*)formatTimeForChat:(NSDate *)date{
    NSTimeInterval elHTed = [date timeIntervalSinceNow];
    NSTimeInterval dateNow = [[NSDate date] timeIntervalSince1970];
    NSDateFormatter *dateFormat = [GFDateFormatter sharedFormatter];
    elHTed = -elHTed;
    if (elHTed<(int)dateNow%GFDAY) {
        [dateFormat setAMSymbol:@"上午"];
        [dateFormat setPMSymbol:@"下午"];
        [dateFormat setDateFormat:@"a HH:mm"];
        return [dateFormat stringFromDate:date];
    }
    else if (elHTed<(int)dateNow%GFDAY + GFDAY){
        [dateFormat setDateFormat:@"昨天 HH:mm"];
        return [dateFormat stringFromDate:date];
    }
    else if (elHTed < GFDAY*7) {
        NSArray *weekdayAry = [NSArray arrayWithObjects:@"星期天", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil];
        [dateFormat  setShortWeekdaySymbols:weekdayAry];
        [dateFormat setDateFormat:@"eee HH:mm"];
        return [dateFormat stringFromDate:date];
    }
    else if (elHTed < GFMONTH){
        dateFormat.dateFormat = NSLocalizedString(@"MM-dd HH:mm", @"");
        return [dateFormat stringFromDate:date];
    }
    else{
        dateFormat.dateFormat = NSLocalizedString(@"yyyy-MM-dd HH:mm", @"");
        return [dateFormat stringFromDate:date];
    }


}


+ (BOOL)isEqualInMinute:(NSDate *)date compareDate:(NSDate *)compareDate{
    NSTimeInterval interval = [date timeIntervalSince1970];
    NSTimeInterval compareInterval = [compareDate timeIntervalSince1970];
    return (int)interval/(int)GFMINUTE == (int)compareInterval/(int)GFMINUTE;
}

#pragma private method
+(NSString *)getUpdateDateWith:(NSDate*)date{
    NSTimeInterval elHTed = [date timeIntervalSinceNow];
    if (elHTed > 0) {
        if (elHTed < GFMINUTE) {
            int seconds = (int)(elHTed);
            return [NSString stringWithFormat:NSLocalizedString(@"刚刚", @""), seconds];
        }
        else if (elHTed < GFHOUR) {
            int mins = (int)(elHTed/GFMINUTE);
            return [NSString stringWithFormat:NSLocalizedString(@"%d分钟前", @""), mins];
        }
        else if (elHTed < GFDAY) {
            int hours = (int)((elHTed+GFHOUR/2)/GFHOUR);
            return [NSString stringWithFormat:NSLocalizedString(@"%d小时前", @""), hours];
        }
        else if (elHTed < GFMONTH) {
            int days = (int)((elHTed+GFDAY/2)/GFDAY);
            return [NSString stringWithFormat:NSLocalizedString(@"%d天前", @""), days];
        }
        else if (elHTed > GFMONTH) {
            int month = (int)((elHTed+GFMONTH/2)/GFMONTH);
            return [NSString stringWithFormat:NSLocalizedString(@">1个月", @""), month];
        }
        else {
            return [GFDateFormatter formatDateTime:date];
        }
    }
    else{
        elHTed = -elHTed;
        if (elHTed < GFMINUTE) {
            int seconds = (int)(elHTed);
            return [NSString stringWithFormat:NSLocalizedString(@"刚刚", @""), seconds];
        }
        else if (elHTed < GFHOUR) {
            int mins = (int)(elHTed/GFMINUTE);
            return [NSString stringWithFormat:NSLocalizedString(@"%d分钟前", @""), mins];
        }
        else if (elHTed < GFDAY) {
            int hours = (int)((elHTed+GFHOUR/2)/GFHOUR);
            return [NSString stringWithFormat:NSLocalizedString(@"%d小时前", @""), hours];
        }
        else if (elHTed < GFMONTH) {
            int days = (int)((elHTed+GFDAY/2)/GFDAY);
            return [NSString stringWithFormat:NSLocalizedString(@"%d天前", @""), days];
        }
        else if (elHTed > GFMONTH) {
            int month = (int)((elHTed+GFMONTH/2)/GFMONTH);
            return [NSString stringWithFormat:NSLocalizedString(@"%d个月以前", @""), month];
        }
        else {
            return [GFDateFormatter formatDateTime:date];
        }
    }
    return @"";
}

@end
