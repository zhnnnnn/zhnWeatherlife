//
//  WLbaseNetWork+netWork.h
//  zhnWeatherlife
//
//  Created by zhn on 16/8/5.
//  Copyright © 2016年 zhn. All rights reserved.
//

#import "WLbaseNetWork.h"

@interface WLbaseNetWork (netWork)


/**
 *  获取天气数据
 *
 *  @param longitude      经度
 *  @param dimensionality 纬度
 *  @param success        成功的回调
 *  @param netError       失败的回调
 */

- (void)WL_requestALLstatusWithLongitude:(CGFloat)longitude dimensionality:(CGFloat)dimensionality success:(successBlock)success error:(errorBlock)netError;

@end


