//
//  TodayViewController.m
//  WeatherLife
//
//  Created by zhn on 16/8/10.
//  Copyright © 2016年 zhn. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>
#import <CoreLocation/CoreLocation.h>
#import <Masonry/Masonry.h>
#import "extensionStatusModel.h"
#import "YYModel.h"
#import "extensionNetWork.h"
#import "extensionConfig.h"

@interface TodayViewController () <NCWidgetProviding,CLLocationManagerDelegate>

@property (nonatomic,strong) CLLocationManager * locationM;

@property (nonatomic,weak) UIImageView * weatherIconImageView;
@property (nonatomic,weak) UILabel * weatherLabel;

@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
     self.preferredContentSize = CGSizeMake(0, 150);

    UIImageView * weatherIconImageView = [[UIImageView alloc]init];
    weatherIconImageView.image = [UIImage imageNamed:@"dark-clear-day-large_60x60_@2x"];
    weatherIconImageView.contentMode = UIViewContentModeCenter;
    weatherIconImageView.userInteractionEnabled = YES;
    [self.view addSubview:weatherIconImageView];
    [weatherIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(self.view.mas_centerY).with.offset(-20);
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    self.weatherIconImageView = weatherIconImageView;
    
    UILabel * weatherLabel = [[UILabel alloc]init];
    weatherLabel.textColor = [UIColor whiteColor];
    weatherLabel.text = @"- & -";
    weatherLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:weatherLabel];
    [weatherLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-20);
        make.size.mas_equalTo(CGSizeMake(200, 20));
    }];
    self.weatherLabel = weatherLabel;
 
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(jumpToSunApp)];
    [weatherIconImageView addGestureRecognizer:tap];
    
    [self getStatus];
}

- (void)jumpToSunApp{
    
    [self.extensionContext openURL:[NSURL URLWithString:@"zhnweather://"] completionHandler:^(BOOL success) {
        
    }];
}

- (void)getStatus{
    
    //取
    NSUserDefaults *shared = [[NSUserDefaults alloc] initWithSuiteName:@"group.zhn.extensionAdd"];
    CGFloat lon = [[shared objectForKey:@"lon"]floatValue];
    CGFloat lat = [[shared objectForKey:@"lat"]floatValue];
    [self getWeekWeatherStatusWithLongitude:lon latitude:lat];
}

#pragma mark - 获取数据方法
- (void)getWeekWeatherStatusWithLongitude:(CGFloat)longitude latitude:(CGFloat)latitude{
    
    [[extensionNetWork shareInstance]WL_requestALLstatusWithLongitude:longitude dimensionality:latitude success:^(id result) {
        
        extensionStatusModel * currentWeatherStatus = [extensionStatusModel yy_modelWithJSON:result[@"currently"]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString * imageString = [[extensionConfig shareInstance]wl_getHomeViewIconImageWithKey:currentWeatherStatus.icon];
            NSString * weatherString = [[extensionConfig shareInstance]wl_getCurrentWeatherStringWithWeatherIcon:currentWeatherStatus.icon];
            self.weatherIconImageView.image = [UIImage imageNamed:imageString];
            
            int temp = [[extensionConfig shareInstance]wl_getCtempretureUseFtempreture:currentWeatherStatus.temperature];
            self.weatherLabel.text = [NSString stringWithFormat:@"%@ & %d°",weatherString,temp];
        });
        
    } error:^(NSError *error) {
        
    }];
    

}


- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.weatherIconImageView.image = [UIImage imageNamed:@"dark-clear-day-large_60x60_@2x"];
    self.weatherLabel.text = @"- & -";
    
    [self getStatus];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {

    completionHandler(NCUpdateResultNewData);
}


- (UIEdgeInsets)widgetMarginInsetsForProposedMarginInsets:(UIEdgeInsets)defaultMarginInsets
{
    return UIEdgeInsetsZero;
}

@end
