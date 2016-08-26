//
//  WLconfig.h
//  zhnWeatherlife
//
//  Created by zhn on 16/8/5.
//  Copyright © 2016年 zhn. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface WLconfig : NSObject

+ (WLconfig *)shareInstance;

/**
 *  获取当前的天气描述
 *
 *  @param weatherIcon 天气
 *
 *  @return 天气
 */

- (NSString *)wl_getCurrentWeatherStringWithWeatherIcon:(NSString *)weatherIcon;
/**
 *  华氏度转化成摄氏度
 *
 *  @param fTemp 华氏度
 *
 *  @return 摄氏度
 */
- (int)wl_getCtempretureUseFtempreture:(CGFloat)fTemp;

/**
 *  获取星期的字符串
 *
 *  @param weekNumber 星期
 *
 *  @return 星期字符
 */
- (NSString *)wl_getWeekDayStringWithNumber:(int)weekNumber;
/**
 *  通过key获取首页的天气图标大图
 *
 *  @param key 键值
 *
 *  @return 天气图标
 */
- (UIImage *)wl_getHomeViewIconImageWithKey:(NSString *)key;
/**
 *  通过key值获取cell的天气图标
 *
 *  @param key 键值
 *
 *  @return 天气图标
 */
- (UIImage *)wl_getCellIconImageWithKey:(NSString *)key;
/**
 *  获取当前的太阳升起的时间
 *
 *  @param TimeInterval 时间戳
 *
 *  @return 太阳升起的时间
 */
- (NSString *)wl_getCurrentSunriseTimeWithTimeInterval:(NSInteger)TimeInterval;
/**
 *  缓存今天的太阳升起的时间和太阳落下的时间
 *
 *  @param sunRiseTime 太阳升起的时间
 *  @param sunSetTime  太阳落下的时间
 */
- (void)wl_cachedayOrNightWithSunRiseTime:(NSInteger)sunRiseTime sunSetTime:(NSInteger)sunSetTime;
/**
 *  现在是白天还是黑夜
 *
 *  @return kdayValue 代表白天 knightValue 代表黑夜
 */
- (NSString *)wl_getDayOrNight;
/**
 *  用key拿到天气图标的大图
 *
 *  @param key 键值
 *
 *  @return 天气突图标的字符串
 */
- (NSString *)wl_getHomeImageIconImageStringWithKey:(NSString *)key;
/**
 *  用key拿到天气图标的小图
 *
 *  @param key 键值
 *
 *  @return 天气图标的字符串
 */
- (NSString *)wl_getCellIconImageStringWithKey:(NSString *)key;

- (void)wl_cacheLocationWithKey:(NSString *)key value:(CGFloat)value;

@end
