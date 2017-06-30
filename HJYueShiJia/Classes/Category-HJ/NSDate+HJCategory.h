//
//  NSDate+HJCategory.h
//
//  Created by huangjian on 16/4/20.
//  Copyright © 2016年 huangjian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (HJCategory)
/**
 *  是否为今天
 */
- (BOOL)isToday;
/**
 *  是否为昨天
 */
- (BOOL)isYesterday;
/**
 *  是否为今年
 */
- (BOOL)isThisYear;

/**
 *  返回一个只有年月日的时间
 */
- (NSDate *)dateWithYMD;

/**
 *  获得与当前时间的差距
 */
- (NSDateComponents *)deltaWithNow;

//获取今天周几
- (NSInteger)getNowWeekday;

//判断时间
+ (NSString *)readableDateWithDate:(NSString *)dateString;

- (NSDate *)hj_dateByAddingYears:(NSInteger)years; /// 从这个日期加上N年
- (NSDate *)hj_dateByAddingMonths:(NSInteger)months; /// 从这个日期加上N月
- (NSDate *)hj_dateByAddingWeeks:(NSInteger)weeks; /// 从这个日期加上N日
- (NSDate *)hj_dateByAddingDays:(NSInteger)days; /// 从这个日期加上N天
- (NSDate *)hj_dateByAddingHours:(NSInteger)hours; /// 从这个日期加上N小时
- (NSDate *)hj_dateByAddingMinutes:(NSInteger)minutes; /// 从这个日期加上N分钟
- (NSDate *)hj_dateByAddingSeconds:(NSInteger)seconds; /// 从这个日期加上N秒
@end
