//
//  WLfiveDayCell.h
//  zhnWeatherlife
//
//  Created by zhn on 16/8/5.
//  Copyright © 2016年 zhn. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WLfroestWeekDayWeatherModel;
@interface WLfiveDayCell : UICollectionViewCell

@property (nonatomic,strong) WLfroestWeekDayWeatherModel * statusModel;
/**
 *  是否只是一个mask的效果
 */
@property (nonatomic,getter = isHomeMaskView) BOOL homeMaskView;

@end
