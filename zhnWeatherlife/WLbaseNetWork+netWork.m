//
//  WLbaseNetWork+netWork.m
//  zhnWeatherlife
//
//  Created by zhn on 16/8/5.
//  Copyright © 2016年 zhn. All rights reserved.
//

#import "WLbaseNetWork+netWork.h"

@implementation WLbaseNetWork (netWork)

- (void)WL_requestALLstatusWithLongitude:(CGFloat)longitude dimensionality:(CGFloat)dimensionality success:(successBlock)success error:(errorBlock)netError{

    NSString * fullStr = [NSString stringWithFormat:@"https://api.forecast.io/forecast/%@/%.6f,%.6f",KforecastIoToken,dimensionality,longitude];
    [self WLgetStatusWithUrl:fullStr params:nil success:success error:netError];
    
}

@end
