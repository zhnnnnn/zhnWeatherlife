//
//  extensionStatusModel.h
//  zhnWeatherlife
//
//  Created by zhn on 16/8/12.
//  Copyright © 2016年 zhn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface extensionStatusModel : NSObject

/**
 *  天气图标
 */
@property (nonatomic,copy) NSString * icon;
/**
 *  降雨概率
 */
@property (nonatomic,assign) CGFloat precipProbability;
/**
 *  温度
 */
@property (nonatomic,assign) CGFloat temperature;


@end
