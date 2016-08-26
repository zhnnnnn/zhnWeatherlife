//
//  WLconfig.m
//  zhnWeatherlife
//
//  Created by zhn on 16/8/5.
//  Copyright © 2016年 zhn. All rights reserved.
//

#import "WLconfig.h"

@implementation WLconfig{
    NSDictionary * weatherIconToWeatherStringDict;
    NSDictionary * weatherIconImageDict;
    NSDictionary * weatherCellIconImageDict;
    NSArray * weekDayStringArray;
    NSDictionary * weathrIconImageStringDict;
    NSDictionary * weatherCellIconImageStringDict;
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
        
        weekDayStringArray = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
        
        weatherIconImageDict = @{
                                 
                @"clear-day" : [UIImage imageNamed:@"light-clear-day-large_60x60_"],
                @"clear-night" : [UIImage imageNamed:@"light-clear-night-large_56x62_"],
                @"partly-cloudy-day" : [UIImage imageNamed:@"light-partlyCloudy-day-large_57x48_"],
                @"partly-cloudy-night" : [UIImage imageNamed:@"light-partlyCloudy-night-large_59x53_"],
                @"cloudy" : [UIImage imageNamed:@"light-cloudy-universal-large_58x40_"],
                @"rain" : [UIImage imageNamed:@"light-rainy-universal-large_57x60_"],
                @"sleet" : [UIImage imageNamed:@"light-hailOrSleet-universal-large_60x60_"],
                @"snow" : [UIImage imageNamed:@"light-snowy-universal-large_57x59_"],
                @"wind" : [UIImage imageNamed:@"light-windy-universal-large_62x38_"],
                @"fog" : [UIImage imageNamed:@"light-foggy-day-large_58x47_"],
        };
        
        weatherCellIconImageDict = @{
                                     
                @"clear-day" : [UIImage imageNamed:@"light-clear-day-small_24x24_"],
                @"clear-night" : [UIImage imageNamed:@"light-clear-night-small_23x25_"],
                @"partly-cloudy-day" : [UIImage imageNamed:@"light-partlyCloudy-day-small_28x24_"],
                @"partly-cloudy-night" : [UIImage imageNamed:@"light-partlyCloudy-night-small_30x27_"],
                @"cloudy" : [UIImage imageNamed:@"light-cloudy-universal-small_29x20_"],
                @"rain" : [UIImage imageNamed:@"light-rainy-universal-small_28x30_"],
                @"sleet" : [UIImage imageNamed:@"light-hailOrSleet-universal-small_30x31_"],
                @"snow" : [UIImage imageNamed:@"light-snowy-universal-small_29x30_"],
                @"wind" : [UIImage imageNamed:@"light-windy-universal-small_30x18_"],
                @"fog" : [UIImage imageNamed:@"light-foggy-day-small_29x23_"],
            };
        
        weathrIconImageStringDict = @{
                @"clear-day" : @"light-clear-day-large_60x60_",
                @"clear-night" : @"light-clear-night-large_56x62_",
                @"partly-cloudy-day" : @"light-partlyCloudy-day-large_57x48_",
                @"partly-cloudy-night" : @"light-partlyCloudy-night-large_59x53_",
                @"cloudy" : @"light-cloudy-universal-large_58x40_",
                @"rain" : @"light-rainy-universal-large_57x60_",
                @"sleet" : @"light-hailOrSleet-universal-large_60x60_",
                @"snow" : @"light-snowy-universal-large_57x59_",
                @"wind" : @"light-windy-universal-large_62x38_",
                @"fog" : @"light-foggy-day-large_58x47_",
                                      
            };
        
        weatherCellIconImageStringDict = @{
                                          
                @"clear-day" : @"light-clear-day-small_24x24_",
                @"clear-night" : @"light-clear-night-small_23x25_",
                @"partly-cloudy-day" : @"light-partlyCloudy-day-small_28x24_",
                @"partly-cloudy-night" : @"light-partlyCloudy-night-small_30x27_",
                @"cloudy" : @"light-cloudy-universal-small_29x20_",
                @"rain" : @"light-rainy-universal-small_28x30_",
                @"sleet" : @"light-hailOrSleet-universal-small_30x31_",
                @"snow" : @"light-snowy-universal-small_29x30_",
                @"wind" : @"light-windy-universal-small_30x18_",
                @"fog" : @"light-foggy-day-small_29x23_",
                                           
            };
        
    }
    return self;
}


+ (WLconfig *)shareInstance{
    
    static WLconfig * instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[WLconfig alloc]init];
    });
    return instance;
    
}

- (NSString *)wl_getCurrentWeatherStringWithWeatherIcon:(NSString *)weatherIcon{
    return weatherIconToWeatherStringDict[weatherIcon];
}

- (int)wl_getCtempretureUseFtempreture:(CGFloat)fTemp{
    
    int cTemp = (int)((fTemp - 32)/1.8);
    return cTemp;
    
}

- (NSString *)wl_getWeekDayStringWithNumber:(int)weekNumber{
    return weekDayStringArray[weekNumber - 1];
}

- (UIImage *)wl_getHomeViewIconImageWithKey:(NSString *)key{
    return weatherIconImageDict[key];
}

- (UIImage *)wl_getCellIconImageWithKey:(NSString *)key{
    return weatherCellIconImageDict[key];
}

- (NSString *)wl_getCurrentSunriseTimeWithTimeInterval:(NSInteger)TimeInterval{
    
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:TimeInterval];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"HH:mm";
    return  [dateFormatter stringFromDate:date];
}

- (BOOL)wl_dayOrNightWithTimeInterval:(NSInteger)TimeInterval{
    
    NSDate * currentDate =  [NSDate date];
    NSTimeInterval currentUnix = [currentDate timeIntervalSince1970];
    if (currentUnix < TimeInterval) {
        [[NSUserDefaults standardUserDefaults]setObject:KdayValue forKey:@"dayOrNight"];
        return YES;
    }else{
        [[NSUserDefaults standardUserDefaults]setObject:KnightValue forKey:@"dayOrNight"];
        return NO;
    }
}

- (void)wl_cachedayOrNightWithSunRiseTime:(NSInteger)sunRiseTime sunSetTime:(NSInteger)sunSetTime{
   
    NSDate * currentDate =  [NSDate date];
    NSTimeInterval currentUnix = [currentDate timeIntervalSince1970];
    
    if (sunRiseTime < currentUnix && currentUnix < sunSetTime) {
        
        [[NSUserDefaults standardUserDefaults]setObject:KdayValue forKey:@"dayOrNight"];
    }else{
        
        [[NSUserDefaults standardUserDefaults]setObject:KnightValue forKey:@"dayOrNight"];
    }
    
}


- (NSString *)wl_getDayOrNight{
    return [[NSUserDefaults standardUserDefaults]valueForKey:@"dayOrNight"];
}

- (NSString *)wl_getHomeImageIconImageStringWithKey:(NSString *)key{
    return weathrIconImageStringDict[key];
}

- (NSString *)wl_getCellIconImageStringWithKey:(NSString *)key{
    return weatherCellIconImageStringDict[key];
}

- (void)wl_cacheLocationWithKey:(NSString *)key value:(CGFloat)value{

    //存
    NSUserDefaults *shared = [[NSUserDefaults alloc] initWithSuiteName:@"group.zhn.extensionAdd"];
    [shared setObject:@(value) forKey:key];
    [shared synchronize];
    
}

@end
