//
//  WLhomeMaskView.m
//  zhnWeatherlife
//
//  Created by zhn on 16/8/8.
//  Copyright © 2016年 zhn. All rights reserved.
//

#import "WLhomeMaskView.h"
#import "WLfiveDayCell.h"
#import "WLconfig.h"

static const int KcollectionViewMargin = 20;
@interface WLhomeMaskView()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,weak) UIView * topView;

@property (nonatomic,weak) UIView * bottomView;

@end

@implementation WLhomeMaskView


+ (WLhomeMaskView *)shareInstance{
    
    static WLhomeMaskView * maskView;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        maskView = [[WLhomeMaskView alloc]init];
    });
    return maskView;
}


- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    [self initBottomView];
    
    [self initTopView];
}


#pragma mark - 初始化方法
- (void)initBottomView{
    
    self.backgroundColor = [UIColor whiteColor];
    CGFloat bottomHeight = KscreenHeight/2.3;
    // 底部的view
    UIView * bottomView = [[UIView alloc]init];
    [self addSubview:bottomView];
    bottomView.backgroundColor = [UIColor whiteColor];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom);
        make.height.mas_equalTo(bottomHeight);
    }];
    [bottomView layoutIfNeeded];
    self.bottomView = bottomView;
    
    CGFloat itemHeight = bottomView.WL_Height * 0.85;
    CGFloat itemWidth = (bottomView.WL_Width - 2 * KcollectionViewMargin)/ 7;
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(itemWidth, itemHeight);
    layout.minimumInteritemSpacing = 0;
    
    UICollectionView * weatherCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(KcollectionViewMargin, 0, KscreenWidth-KcollectionViewMargin*2, itemHeight) collectionViewLayout:layout];
    [bottomView addSubview:weatherCollectionView];
    weatherCollectionView.backgroundColor = [UIColor whiteColor];
    [weatherCollectionView registerClass:[WLfiveDayCell class] forCellWithReuseIdentifier:@"cell"];
    weatherCollectionView.delegate = self;
    weatherCollectionView.dataSource = self;
}

- (void)initTopView{
    
    // 顶部的view
    UIView * topView = [[UIView alloc]init];
    [self addSubview:topView];
    topView.backgroundColor = KdayColor;
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.top.equalTo(self);
        make.bottom.equalTo(self.bottomView.mas_top);
    }];
    self.topView = topView;
    
    UIImageView * weatherIcon = [[UIImageView alloc]init];
    weatherIcon.contentMode = UIViewContentModeCenter;
    [topView addSubview:weatherIcon];
    weatherIcon.animationDuration = 1;
    weatherIcon.animationImages = [self P_getAnimateImagesArray];
    weatherIcon.animationRepeatCount = MAXFLOAT;
    
    [weatherIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(topView.mas_centerX);
        make.centerY.equalTo(topView.mas_centerY).with.offset(-50);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
    [weatherIcon startAnimating];
    
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
        make.size.mas_equalTo(CGSizeMake(300, 40));
    }];
    
    UILabel * locationLabel = [[UILabel alloc]init];
    locationLabel.text = @"- . -";
    locationLabel.textAlignment = NSTextAlignmentCenter;
    locationLabel.font = [UIFont wl_fontWitnSize:20];
    [topView addSubview:locationLabel];
    [locationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(topView.mas_centerX);
        make.top.equalTo(weatherLabel.mas_bottom).with.offset(15);
        make.size.mas_equalTo(CGSizeMake(300, 30));
    }];
    
}

- (NSArray *)P_getAnimateImagesArray{
    
    NSMutableArray * imagesArray = [NSMutableArray array];
    for (int index = 1; index < 9; index++) {
        NSString * imageString = [NSString stringWithFormat:@"%d-light_78x78_",index];
        if ([[[WLconfig shareInstance]wl_getDayOrNight]isEqualToString:KnightValue]) {
          imageString = [imageString stringByReplacingOccurrencesOfString:@"light" withString:@"dark"];
        }
       [imagesArray addObject:[UIImage imageNamed:imageString]];
    }
    return imagesArray;
}

#pragma mark - collection的数据源方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 7;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    WLfiveDayCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.homeMaskView = YES;
    
    return cell;
}

+ (void)showMask{
    
    UIWindow *keyWindow = [[[UIApplication sharedApplication] delegate] window];
    WLhomeMaskView * homeMaskView = [[WLhomeMaskView alloc]init];
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
