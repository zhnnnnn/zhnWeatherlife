//
//  WLnoLocationServerMaskView.m
//  zhnWeatherlife
//
//  Created by zhn on 16/8/9.
//  Copyright © 2016年 zhn. All rights reserved.
//

#import "WLnoLocationServerMaskView.h"
#import "UIImageView+zhnBoom.h"

@implementation WLnoLocationServerMaskView

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    [self initSubViews];
}


- (void)initSubViews{
    
    
    self.userInteractionEnabled = YES;
    
    UIBlurEffect * effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView * effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = self.bounds;
    [self addSubview:effectView];
    
    UIImageView * noticeView = [[UIImageView alloc]init];
    [self addSubview:noticeView];
    noticeView.image = [UIImage imageNamed:@"light-windage-universal-small_17x17_"];
    [noticeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY).with.offset(-100);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    UILabel * noticeLabel = [[UILabel alloc]init];
    noticeLabel.numberOfLines = 0;
    noticeLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:noticeLabel];
    noticeLabel.text = @"定位服务被关闭,请前往设置界面将定位服务打开";
    noticeLabel.font = [UIFont wl_fontWitnSize:20];
    [noticeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(noticeView.mas_centerX);
        make.top.equalTo(noticeView.mas_bottom).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(200, 100));
    }];
    
    UITapGestureRecognizer * tapToHideGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideMask)];
    [self addGestureRecognizer:tapToHideGes];
}

- (void)hideMask{
    
    [WLnoLocationServerMaskView hideMask];
}


// 显示遮罩
+ (void)showMask{
    
    UIWindow *keyWindow = [[[UIApplication sharedApplication] delegate] window];
    WLnoLocationServerMaskView * homeMaskView = [[WLnoLocationServerMaskView alloc]init];
    homeMaskView.frame = CGRectMake(0, 0, KscreenWidth, KscreenHeight);
    [keyWindow.rootViewController.view addSubview:homeMaskView];
}

+ (void)hideMask{
    
    UIWindow *keyWindow = [[[UIApplication sharedApplication] delegate] window];
    [UIView animateWithDuration:0.5 animations:^{
        keyWindow.rootViewController.view.subviews.lastObject.alpha = 0;
    } completion:^(BOOL finished) {
        [keyWindow.rootViewController.view.subviews.lastObject removeFromSuperview];
    }];
}


@end
