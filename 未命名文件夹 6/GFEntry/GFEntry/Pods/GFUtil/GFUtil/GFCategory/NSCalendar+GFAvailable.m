//
//  NSCalendar+GFAvailable.m
//  GFUtil
//
//  Created by huangjian on 17/3/20.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import <Foundation/Foundation.h>

@implementation NSCalendar (GFAvailable)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"

- (NSComparisonResult)compareDate:(NSDate *)date1 toDate:(NSDate *)date2 toUnitGranularity:(NSCalendarUnit)unit{
    NSDateComponents *c1 = [self components:unit fromDate:date1];
    NSDateComponents *c2 = [self components:unit fromDate:date2];
    date1 = [self dateFromComponents:c1];
    date2 = [self dateFromComponents:c2];
    return [date1 compare:date2];
}

#pragma clang diagnostic pop

@end
