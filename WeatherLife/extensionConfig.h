//
//  extensionConfig.h
//  zhnWeatherlife
//
//  Created by zhn on 16/8/12.
//  Copyright © 2016年 zhn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface extensionConfig : NSObject

+ (extensionConfig *)shareInstance;

/**
 *  获取当前的天气描述
 *
 *  @param weatherIcon 天气
 *
 *  @return 天气
 */

- (NSString *)wl_getCurrentWeatherStringWithWeatherIcon:(NSString *)weatherIcon;

/**
 *  通过key获取首页的天气图标大图
 *
 *  @param key 键值
 *
 *  @return 天气图标
 */
- (NSString *)wl_getHomeViewIconImageWithKey:(NSString *)key;

/**
 *  华氏度转化成摄氏度
 *
 *  @param fTemp 华氏度
 *
 *  @return 摄氏度
 */
- (int)wl_getCtempretureUseFtempreture:(CGFloat)fTemp;
@end
