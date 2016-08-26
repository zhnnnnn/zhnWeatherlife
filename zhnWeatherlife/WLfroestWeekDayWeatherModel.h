//
//  WLfroestWeekDayWeatherModel.h
//  zhnWeatherlife
//
//  Created by zhn on 16/8/7.
//  Copyright © 2016年 zhn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLfroestWeekDayWeatherModel : NSObject
/**
 *  最高温度
 */
@property (nonatomic,assign) CGFloat temperatureMax;
/**
 *  最低温度
 */
@property (nonatomic,assign) CGFloat temperatureMin;
/**
 *  降雨概率
 */
@property (nonatomic,assign) CGFloat precipProbability;
/**
 *  天气
 */
@property (nonatomic,copy) NSString * icon;
/**
 *  星期几
 */
@property (nonatomic,copy) NSString * weekDayString;
/**
 *  是否是第一行
 */
@property (nonatomic,getter = isFirstRow) BOOL firstRow;
/**
 *  太阳升起的时间
 */
@property (nonatomic,assign) NSInteger sunriseTime;
/**
 *  太阳落下的时间
 */
@property (nonatomic,assign) NSInteger sunsetTime;

@end
