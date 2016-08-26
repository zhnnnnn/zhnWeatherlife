//
//  WLhomeDayWeekView.h
//  zhnWeatherlife
//
//  Created by zhn on 16/8/5.
//  Copyright © 2016年 zhn. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WLhomeDayWeekViewDelegate <NSObject>
@optional
/**
 *  选择了日还是周（2 => 日，1=> 周）
 *
 *  @param type 判断类型
 */
- (void)WLhomeDayWeekViewChoseType:(NSInteger)type;

@end

@interface WLhomeDayWeekView : UIView

@property (nonatomic,weak) id <WLhomeDayWeekViewDelegate> delegate;

@end
