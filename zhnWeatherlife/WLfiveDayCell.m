//
//  WLfiveDayCell.m
//  zhnWeatherlife
//
//  Created by zhn on 16/8/5.
//  Copyright © 2016年 zhn. All rights reserved.
//

#import "WLfiveDayCell.h"
#import "WLfroestWeekDayWeatherModel.h"
#import "WLconfig.h"
#import "UIImageView+WLextension.h"
#import "UIView+dayNightExtension.h"
#import "UILabel+WLextension.h"

@interface WLfiveDayCell()
/**
 *  天气图标
 */
@property (nonatomic,weak) UIImageView * iconView;
/**
 *  周的第一天提示的view
 */
@property (nonatomic,weak) UIImageView * firstNoticeView;
/**
 *  星期几
 */
@property (nonatomic,weak) UILabel * weekDayLabel;
/**
 *  最高温度
 */
@property (nonatomic,weak) UILabel * maxTempLabel;
/**
 *  最低温度
 */
@property (nonatomic,weak) UILabel * minTempLabel;
/**
 *  降雨概率
 */
@property (nonatomic,weak) UILabel * rainPercentLabel;

@end


static const CGFloat KnotHightLightAlpha = 0.4;

@implementation WLfiveDayCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews{
    
    UIImageView * firstNoticeView = [[UIImageView alloc]init];
    [self addSubview:firstNoticeView];
    self.firstNoticeView = firstNoticeView;
    firstNoticeView.backgroundColor = KdayHightLightColor;
    
    UILabel * weekDayLabel = [[UILabel alloc]init];
    [self addSubview:weekDayLabel];
    weekDayLabel.font = [UIFont wl_fontWitnSize:18];
    weekDayLabel.textAlignment = NSTextAlignmentCenter;
    self.weekDayLabel = weekDayLabel;
    
    UIImageView * iconView = [[UIImageView alloc]init];
    [self addSubview:iconView];
    iconView.contentMode = UIViewContentModeCenter;
    iconView.image = [UIImage imageNamed:@"light-clear-day-small_24x24_"];
    self.iconView = iconView;
    
    UILabel * maxTempLabel = [[UILabel alloc]init];
    [self addSubview:maxTempLabel];
    maxTempLabel.font = [UIFont wl_fontWitnSize:18];
    maxTempLabel.textAlignment = NSTextAlignmentCenter;
    maxTempLabel.text = @"30°";
    self.maxTempLabel = maxTempLabel;
    
    UILabel * minTempLabel = [[UILabel alloc]init];
    [self addSubview:minTempLabel];
    minTempLabel.font = [UIFont wl_fontWitnSize:18];
    minTempLabel.textAlignment = NSTextAlignmentCenter;
    minTempLabel.text = @"25°";
    self.minTempLabel = minTempLabel;
    
    UILabel *rainPercentLabel = [[UILabel alloc]init];
    [self addSubview:rainPercentLabel];
    rainPercentLabel.font = [UIFont wl_fontWitnSize:18];
    rainPercentLabel.textAlignment = NSTextAlignmentCenter;
    rainPercentLabel.text = @"20%";
    self.rainPercentLabel = rainPercentLabel;
    
}

- (void)layoutSubviews{    
    [super layoutSubviews];
    
    [self.firstNoticeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top);
        make.size.mas_equalTo(CGSizeMake(30, 1.5));
    }];
    
    [self.weekDayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top).with.offset(20);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.weekDayLabel.mas_bottom).with.offset(20);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    [self.maxTempLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.iconView.mas_bottom).with.offset(5);
        make.size.mas_equalTo(CGSizeMake(80, 30));
    }];
    
    [self.minTempLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.maxTempLabel.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(80, 30));
    }];
    
    [self.rainPercentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.minTempLabel.mas_bottom).with.offset(20);
        make.size.mas_equalTo(CGSizeMake(80, 40));
    }];
    
}

- (void)setStatusModel:(WLfroestWeekDayWeatherModel *)statusModel{
    
    self.weekDayLabel.textColor = [UIColor whiteColor];
    self.maxTempLabel.textColor = [UIColor whiteColor];
    self.minTempLabel.textColor = [UIColor whiteColor];
    self.rainPercentLabel.textColor = [UIColor  whiteColor];
    self.backgroundColor = [UIColor whiteColor];
    _statusModel = statusModel;
    
    if (!statusModel.isFirstRow) {
        
        self.firstNoticeView.hidden = YES;
        
        self.iconView.alpha = KnotHightLightAlpha;
        self.weekDayLabel.alpha = KnotHightLightAlpha;
        self.maxTempLabel.alpha = KnotHightLightAlpha;
        self.minTempLabel.alpha = KnotHightLightAlpha;
        self.rainPercentLabel.alpha = KnotHightLightAlpha;
        
    }else{
        
        self.firstNoticeView.hidden = NO;
        
        self.iconView.alpha = 1;
        self.weekDayLabel.alpha = 1;
        self.maxTempLabel.alpha = 1;
        self.minTempLabel.alpha = 1;
        self.rainPercentLabel.alpha = 1;
    }
    
    int maxTemp = [[WLconfig shareInstance]wl_getCtempretureUseFtempreture:statusModel.temperatureMax];
    int minTemp = [[WLconfig shareInstance]wl_getCtempretureUseFtempreture:statusModel.temperatureMin];
    
    
    
    if ([[[WLconfig shareInstance]wl_getDayOrNight] isEqualToString:KdayValue]) {// 白天的话
        statusModel.icon = [statusModel.icon stringByReplacingOccurrencesOfString:@"night" withString:@"day"];
    }else{// 黑夜的话
        statusModel.icon = [statusModel.icon stringByReplacingOccurrencesOfString:@"day" withString:@"night"];
    }

    [self.iconView wl_setImage:[[WLconfig shareInstance] wl_getCellIconImageStringWithKey:statusModel.icon]];
    
//    self.iconView.image = [[WLconfig shareInstance]wl_getCellIconImageWithKey:statusModel.icon];

    self.weekDayLabel.text = statusModel.weekDayString;
    self.maxTempLabel.text = [NSString stringWithFormat:@"%d°",maxTemp];
    self.minTempLabel.text = [NSString stringWithFormat:@"%d°",minTemp];
    
    
    int rainPercent = (int)(self.statusModel.precipProbability * 100);
    NSString * rainPercentString;
    if(rainPercent == 0){
        rainPercentString = @"- -";
    }else{
        rainPercentString = [NSString stringWithFormat:@"%d%@",(int)(self.statusModel.precipProbability * 100),@"%"];
    }
    self.rainPercentLabel.text = rainPercentString;
}


- (void)setHomeMaskView:(BOOL)homeMaskView{
    
    if (homeMaskView) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.maxTempLabel.text = @"- -";
        self.minTempLabel.text = @"- -";
        self.rainPercentLabel.text = @"- -";
        self.firstNoticeView.hidden = YES;
        [self.iconView wl_setImage:[[WLconfig shareInstance] wl_getCellIconImageStringWithKey:@"clear-day"]];

        self.iconView.alpha = KnotHightLightAlpha;
        self.weekDayLabel.alpha = KnotHightLightAlpha;
        self.maxTempLabel.alpha = KnotHightLightAlpha;
        self.minTempLabel.alpha = KnotHightLightAlpha;
        self.rainPercentLabel.alpha = KnotHightLightAlpha;
    }
    
}

@end
