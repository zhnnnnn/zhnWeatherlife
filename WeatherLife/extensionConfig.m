//
//  extensionConfig.m
//  zhnWeatherlife
//
//  Created by zhn on 16/8/12.
//  Copyright © 2016年 zhn. All rights reserved.
//

#import "extensionConfig.h"


@implementation extensionConfig{

    NSDictionary * weatherIconToWeatherStringDict;
    NSDictionary * weatherIconImageDict;
}

- (instancetype)init{
    
    if (self = [super init]) {
        weatherIconToWeatherStringDict = @{
                                           @"clear-day" : @"晴",
                                           @"clear-night" : @"晴",
                                           @"partly-cloudy-day" : @"多云",
                                           @"partly-cloudy-night" : @"多云",
                                           @"cloudy" : @"阴",
                                           @"rain" : @"雨",
                                           @"sleet" : @"冻雨",
                                           @"snow" : @"雪",
                                           @"wind" : @"风",
                                           @"fog" : @"雾",
                                           };
        
        weatherIconImageDict = @{
                                 
                                 @"clear-day" : @"light-clear-day-large_60x60_@2x",
                                 @"clear-night" : @"light-clear-night-large_56x62_@2x",
                                 @"partly-cloudy-day" : @"light-partlyCloudy-day-large_57x48_@2x",
                                 @"partly-cloudy-night" : @"light-partlyCloudy-night-large_59x53_@2x",
                                 @"cloudy" : @"light-cloudy-universal-large_58x40_@2x",
                                 @"rain" : @"light-rainy-universal-large_57x60_@2x",
                                 @"sleet" : @"light-hailOrSleet-universal-large_60x60_@2x",
                                 @"snow" : @"light-snowy-universal-large_57x59_@2x",
                                 @"wind" : @"light-windy-universal-large_62x38_@2x",
                                 @"fog" : @"light-foggy-day-large_58x47_@2x",
                                 };
        
        
        
    }
    return self;
}


+ (extensionConfig *)shareInstance{
    
    static extensionConfig * instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[extensionConfig alloc]init];
    });
    return instance;
    
}

- (NSString *)wl_getCurrentWeatherStringWithWeatherIcon:(NSString *)weatherIcon{
    return weatherIconToWeatherStringDict[weatherIcon];
}

- (NSString *)wl_getHomeViewIconImageWithKey:(NSString *)key{
    return weatherIconImageDict[key];
}

- (int)wl_getCtempretureUseFtempreture:(CGFloat)fTemp{
    
    int cTemp = (int)((fTemp - 32)/1.8);
    return cTemp;
    
}

@end
