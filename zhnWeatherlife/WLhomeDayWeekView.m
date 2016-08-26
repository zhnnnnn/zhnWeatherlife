//
//  WLhomeDayWeekView.m
//  zhnWeatherlife
//
//  Created by zhn on 16/8/5.
//  Copyright © 2016年 zhn. All rights reserved.
//

#import "WLhomeDayWeekView.h"

@interface WLhomeDayWeekView()

@property (nonatomic,weak) UIButton * dayButton;

@property (nonatomic,weak) UIButton * weekButton;

@property (nonatomic,weak) UIView * linview;
@end


@implementation WLhomeDayWeekView

- (instancetype)init{
    
    if (self = [super init]) {
     
        UIButton * dayButton = [[UIButton alloc]init];
        [self addSubview:dayButton];
        [dayButton setTitle:@"周" forState:UIControlStateNormal];
        [dayButton setTitleColor:KdayHightLightColor forState:UIControlStateDisabled];
        [dayButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        self.dayButton = dayButton;
        dayButton.enabled = NO;
        dayButton.tag = 1;
        [dayButton addTarget:self action:@selector(p_choseDayOrWeek:) forControlEvents:UIControlEventTouchUpInside];
        
        UIView * linView = [[UIView alloc]init];
        linView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.15];
        [self addSubview:linView];
        self.linview = linView;
        
        UIButton * weekButton = [[UIButton alloc]init];
        [self addSubview:weekButton];
        [weekButton setTitle:@"日" forState:UIControlStateNormal];
        [weekButton setTitleColor:KdayHightLightColor forState:UIControlStateDisabled];
        [weekButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        self.weekButton = weekButton;
        weekButton.tag = 2;
        [weekButton addTarget:self action:@selector(p_choseDayOrWeek:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}


- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    [self.dayButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.top.equalTo(self.mas_top);
        make.width.equalTo(self.mas_width).multipliedBy(0.45);
    }];
    
    [self.linview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).with.offset(10);
        make.bottom.equalTo(self.mas_bottom).with.offset(-10);
        make.centerX.equalTo(self.mas_centerX);
        make.width.mas_equalTo(1);
    }];
    
    [self.weekButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top);
        make.width.equalTo(self.mas_width).multipliedBy(0.45);
    }];
    
}

- (void)p_choseDayOrWeek:(UIButton *)clickedButton{
    
    switch (clickedButton.tag) {
        case 1:
            self.dayButton.enabled = NO;
            self.weekButton.enabled = YES;
            if ([self.delegate respondsToSelector:@selector(WLhomeDayWeekViewChoseType:)]) {
                [self.delegate WLhomeDayWeekViewChoseType:1];
            }
            break;
        case 2:
            self.dayButton.enabled = YES;
            self.weekButton.enabled = NO;
            if ([self.delegate respondsToSelector:@selector(WLhomeDayWeekViewChoseType:)]) {
                [self.delegate WLhomeDayWeekViewChoseType:2];
            }
            break;
    }
    
    
}


@end
