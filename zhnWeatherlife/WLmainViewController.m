//
//  WLmainViewController.m
//  zhnWeatherlife
//
//  Created by zhn on 16/8/5.
//  Copyright © 2016年 zhn. All rights reserved.
//
#import <CoreLocation/CoreLocation.h>
#import <AVFoundation/AVFoundation.h>
#import "WLmainViewController.h"
#import "WLhomeDayWeekView.h"
#import "WLfiveDayCell.h"
#import "WLconfig.h"
#import "WLfroestCurrentWeatherModel.h"
#import "WLfroestWeekDayWeatherModel.h"
#import "WLhomeMaskView.h"
#import "WLnoLocationServerMaskView.h"
#import "WLnetWorkMaskView.h"
#import "UILabel+WLextension.h"
#import "UIImageView+WLextension.h"
#import "UIView+dayNightExtension.h"

@interface WLmainViewController ()<WLhomeDayWeekViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,CLLocationManagerDelegate>

@property (nonatomic,weak) UIView * topView;

@property (nonatomic,weak) UIView * bottomView;
/**
 *  天气图标
 */
@property (nonatomic,weak) UIImageView * showWeatherIconImage;
/**
 *  天气文字
 */
@property (nonatomic,weak) UILabel * showWeatherLabel;
/**
 *  位置文字
 */
@property (nonatomic,weak) UILabel * showLocationLabel;
/**
 *  周日期的collection
 */
@property (nonatomic,weak) UICollectionView * weekDayCollectionView;
/**
 *  当前天气的model
 */
@property (nonatomic,strong) WLfroestCurrentWeatherModel * currentWeatherStatusModel;
/**
 *  星期字符的数组
 */
@property (nonatomic,strong) NSMutableArray * lastWeekDayArray;
/**
 *  周数据
 */
@property (nonatomic,strong) NSArray * weekDayWeatherStatusArray;
/**
 *  异步加载完成的次数 （用这个来同步数据，当所有数据都完成了再刷新）
 */
@property (nonatomic,assign) int asysFinshedNumber;
/**
 *  定位类
 */
@property (nonatomic,strong) CLLocationManager * locationM;
/**
 *  定位的位置
 */
@property (nonatomic,assign) CLLocationCoordinate2D currentLocation;
/**
 *  经纬度反编译的类
 */
@property (nonatomic,strong) CLGeocoder * geoc;
/**
 *  是否正在请求数据
 */
@property (nonatomic,getter = isRequseting) BOOL requesting;
/**
 *  当前位置的中文描述
 */
@property (nonatomic,copy) NSString * locationString;

@end

static const int KcollectionViewMargin = 20;

@implementation WLmainViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // 注册位置
    [self registerLocation];
    // 初始化底部的view
    [self initBottomView];
    // 初始化顶部的view
    [self initTopView];
    // 获取天气数据
    [self getLastWeekDayArray];
    // 初始化kvo 和 广播
    [self initObservers];
    // 显示遮罩
    [WLhomeMaskView showMask];
}

- (void)registerLocation{
    
    self.locationM = [[CLLocationManager alloc] init];
    self.locationM.delegate = self;
    self.locationM.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locationM requestAlwaysAuthorization];
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0)
    {
        self.locationM.allowsBackgroundLocationUpdates = YES;
    }
    [self.locationM startUpdatingLocation];
    self.geoc = [[CLGeocoder alloc] init];
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    if (!self.requesting) {
        self.requesting = YES;
        self.currentLocation = locations.firstObject.coordinate;
        self.asysFinshedNumber += 1;

        [[WLconfig shareInstance]wl_cacheLocationWithKey:@"lon" value:self.currentLocation.longitude];
        [[WLconfig shareInstance]wl_cacheLocationWithKey:@"lat" value:self.currentLocation.latitude];
        
        
        // 根据经纬度信息进行反地理编码
        [self.geoc reverseGeocodeLocation:[[CLLocation alloc] initWithLatitude:self.currentLocation.latitude longitude:self.currentLocation.longitude] completionHandler:^(NSArray<CLPlacemark *> * __nullable placemarks, NSError * __nullable error)
         {
             
             CLPlacemark *placemark = [placemarks firstObject];
             // 城市名称
             NSString * city = placemark.locality;
             // 区域
             NSString * area = placemark.subLocality;
             // 街道名称
             NSString *street = placemark.thoroughfare;
             // 全称
             if(city && street){
                 self.locationString = [NSString stringWithFormat:@"%@ . %@ . %@",city,area,street];
             }else{
                 self.locationString = @"- . -";
             }
             
             self.asysFinshedNumber += 1;
         }];
        
        [self getWeekWeatherStatus];
        
    }
    
    [self.locationM stopUpdatingLocation];
     
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    
    [WLhomeMaskView hideMask];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [WLnoLocationServerMaskView  showMask];
    });
    
}

#pragma mark - 初始化方法
- (void)initBottomView{

    self.view.backgroundColor = [UIColor whiteColor];
    CGFloat bottomHeight = KscreenHeight/2.3;
    // 底部的view
    UIView * bottomView = [[UIView alloc]init];
    [self.view addSubview:bottomView];
    bottomView.backgroundColor = [UIColor whiteColor];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
        make.height.mas_equalTo(bottomHeight);
    }];
    self.bottomView = bottomView;
    [bottomView layoutIfNeeded];
    
    CGFloat itemHeight = self.bottomView.WL_Height * 0.85;
    CGFloat itemWidth = (self.bottomView.WL_Width - 2 * KcollectionViewMargin)/ 7;
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(itemWidth, itemHeight);
    layout.minimumInteritemSpacing = 0;
    
    UICollectionView * weatherCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(KcollectionViewMargin, 0, KscreenWidth-KcollectionViewMargin*2, itemHeight) collectionViewLayout:layout];
    self.weekDayCollectionView = weatherCollectionView;
    [bottomView addSubview:weatherCollectionView];
    weatherCollectionView.backgroundColor = [UIColor whiteColor];
    [weatherCollectionView registerClass:[WLfiveDayCell class] forCellWithReuseIdentifier:@"cell"];
    weatherCollectionView.delegate = self;
    weatherCollectionView.dataSource = self;
}

- (void)initTopView{

    // 顶部的view
    UIView * topView = [[UIView alloc]init];
    [self.view addSubview:topView];
    topView.backgroundColor = KdayColor;
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view);
        make.bottom.equalTo(self.bottomView.mas_top);
    }];
    self.topView = topView;
    
    UIImageView * weatherIcon = [[UIImageView alloc]init];
    weatherIcon.contentMode = UIViewContentModeCenter;
    [topView addSubview:weatherIcon];
    [weatherIcon wl_setImage:@"light-clear-day-large_60x60_"];
    [weatherIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(topView.mas_centerX);
        make.centerY.equalTo(topView.mas_centerY).with.offset(-50);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
    self.showWeatherIconImage = weatherIcon;
    
    UIImageView * IconlineView = [[UIImageView alloc]init];
    [topView addSubview:IconlineView];
    IconlineView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1];
    [IconlineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(topView.mas_centerX);
        make.top.equalTo(weatherIcon.mas_bottom).with.offset(2);
        make.size.mas_equalTo(CGSizeMake(50, 1));
    }];
    
    UILabel * weatherLabel = [[UILabel alloc]init];
    weatherLabel.textAlignment = NSTextAlignmentCenter;
    weatherLabel.font = [UIFont wl_fontWitnSize:35];
    weatherLabel.text = @"- & -";
    [topView addSubview:weatherLabel];
    [weatherLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(topView.mas_centerX);
        make.top.equalTo(weatherIcon.mas_bottom).with.offset(30);
        make.size.mas_equalTo(CGSizeMake(KscreenWidth, 40));
    }];
    self.showWeatherLabel = weatherLabel;
    
    UILabel * locationLabel = [[UILabel alloc]init];
    locationLabel.text = @"- . -";
    locationLabel.textAlignment = NSTextAlignmentCenter;
    locationLabel.font = [UIFont wl_fontWitnSize:20];
    [topView addSubview:locationLabel];
    [locationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(topView.mas_centerX);
        make.top.equalTo(weatherLabel.mas_bottom).with.offset(15);
        make.size.mas_equalTo(CGSizeMake(KscreenWidth, 30));
    }];
    self.showLocationLabel = locationLabel;
    
    WLhomeDayWeekView * dayWeekView = [[WLhomeDayWeekView alloc]init];
    [self.view addSubview:dayWeekView];
    [dayWeekView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(topView.mas_right).with.offset(-10);
        make.bottom.equalTo(topView.mas_bottom).with.offset(-10);
        make.size.mas_equalTo(CGSizeMake(80, 30));
    }];
    dayWeekView.delegate = self;
    
    UITapGestureRecognizer * reloadGeture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapToReloadData)];
    [topView addGestureRecognizer:reloadGeture];
}

- (void)tapToReloadData{
    
    [self P_playClickSound];
    [self getLastWeekDayArray];
    self.asysFinshedNumber = 1;
    [self.locationM startUpdatingLocation];
    [WLhomeMaskView showMask];
}

- (void)P_playClickSound{
    
        NSURL * soundUrl = [[NSBundle mainBundle]URLForResource:@"click.mp3" withExtension:nil];
        SystemSoundID soundID = 0;
        AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(soundUrl), &soundID);
        AudioServicesPlaySystemSound(soundID);
}

#pragma mark - 获取数据方法
- (void)getWeekWeatherStatus{

    CGFloat longitude = self.currentLocation.longitude;
    CGFloat latitude = self.currentLocation.latitude;
    
    [[WLbaseNetWork shareInstance]WL_requestALLstatusWithLongitude:longitude dimensionality:latitude success:^(id result) {
    
        self.weekDayWeatherStatusArray = [NSArray yy_modelArrayWithClass:[WLfroestWeekDayWeatherModel class] json:result[@"daily"][@"data"]];
       
        self.currentWeatherStatusModel = [WLfroestCurrentWeatherModel yy_modelWithJSON:result[@"currently"]];
        
        WLfroestWeekDayWeatherModel * model = self.weekDayWeatherStatusArray.firstObject;
        
        [[WLconfig shareInstance]wl_cachedayOrNightWithSunRiseTime:model.sunriseTime sunSetTime:model.sunsetTime];
        
        self.asysFinshedNumber += 1;
        self.requesting = NO;
        
    } error:^(NSError *error) {
        
        [WLhomeMaskView hideMask];
        
    }];
    
}

#pragma mark - 通知模块
- (void)initObservers{
    
    [self addObserver:self forKeyPath:@"asysFinshedNumber" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(dayOrNightChange) name:KdayOrNightNotication object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(networkChanged:)
                                                 name:kRealReachabilityChangedNotification
                                            object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(becomActiveToRefleshData) name:KapplicationBecomActiveNotification object:nil];
}

- (void)networkChanged:(NSNotification *)notification{
    
    RealReachability *reachability = (RealReachability *)notification.object;
    ReachabilityStatus status = [reachability currentReachabilityStatus];
    if (status == RealStatusNotReachable) {
        [WLnetWorkMaskView showMask];
    }
    
}

- (void)dayOrNightChange{
    
    [self tapToReloadData];
    
}

- (void)becomActiveToRefleshData{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self dayOrNightChange];
        
    });
    
}


#pragma mark - 获得星期数据
- (void)getLastWeekDayArray{
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSDate * date  = [NSDate date];
        NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDateComponents * comps = [calendar components:NSCalendarUnitWeekday fromDate:date];
        for (int index = 0; index < 7; index ++) {
            
            int day = 0;
            if (comps.weekday + index > 7) {
                day = (int)(comps.weekday + index - 7);
            }else{
                day = (int)comps.weekday + index;
            }
            
            [self.lastWeekDayArray addObject:[[WLconfig shareInstance]wl_getWeekDayStringWithNumber:day]];
        }
        self.asysFinshedNumber += 1;
    });
}

#pragma mark - 日 周 选择按钮的代理方法
- (void)WLhomeDayWeekViewChoseType:(NSInteger)type{
    
    NSLog(@"%lu",type);
    
}

#pragma mark - collection的数据源方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(self.weekDayWeatherStatusArray.count - 1 == 7){
        return self.weekDayWeatherStatusArray.count - 1;
    }else{
        return 0;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    WLfiveDayCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    WLfroestWeekDayWeatherModel * model = self.weekDayWeatherStatusArray[indexPath.row];
    model.weekDayString = self.lastWeekDayArray[indexPath.row];
    model.firstRow = (indexPath.row == 0);
    cell.statusModel = model;
    
    return cell;
}


- (NSMutableArray *)lastWeekDayArray{
    
    if (_lastWeekDayArray == nil) {
        _lastWeekDayArray = [NSMutableArray array];
    }
    return _lastWeekDayArray;
    
}

- (void)topViewInitStatus{
    
    self.topView.backgroundColor = KdayColor;
    self.bottomView.backgroundColor = [UIColor whiteColor];
    self.showWeatherLabel.textColor = [UIColor whiteColor];
    self.showLocationLabel.textColor = [UIColor whiteColor];
    
    NSString * weatherString = [[WLconfig shareInstance]wl_getCurrentWeatherStringWithWeatherIcon:self.currentWeatherStatusModel.icon];
    int currentTemp = [[WLconfig shareInstance]wl_getCtempretureUseFtempreture:self.currentWeatherStatusModel.temperature];
    
    self.showWeatherLabel.text = [NSString stringWithFormat:@"%@ & %d°",weatherString,currentTemp];
    
    [self.showWeatherIconImage wl_setImage:[[WLconfig shareInstance] wl_getHomeImageIconImageStringWithKey:self.currentWeatherStatusModel.icon]];
    
    self.showLocationLabel.text = self.locationString;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
    if ([keyPath isEqualToString:@"asysFinshedNumber"]) {
        if (self.asysFinshedNumber == 4) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
               
                [self.weekDayCollectionView reloadData];
                [self topViewInitStatus];
                [self.showWeatherIconImage mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.size.mas_equalTo(CGSizeMake(80, 80));
                }];
                self.showWeatherIconImage.transform = CGAffineTransformMakeScale(0, 0);
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    [WLhomeMaskView hideMask];
                    
                    [self showIconImageAnimation];
                });
                
            });
        }
    }
}

- (void)showIconImageAnimation{
    
    [UIView animateWithDuration:1.5 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.showWeatherIconImage.transform = CGAffineTransformMakeScale(1, 1);
    } completion:^(BOOL finished) {
        
    }];
    
}

- (void)dealloc{
    
    [self removeObserver:self forKeyPath:@"asysFinshedNumber"];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:KdayOrNightNotication object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:kRealReachabilityChangedNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:KapplicationBecomActiveNotification object:nil];
}




@end
