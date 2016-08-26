//
//  UIView+WLframe.h
//  zhnWeatherlife
//
//  Created by zhn on 16/8/5.
//  Copyright © 2016年 zhn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (WLframe)

- (CGFloat)WL_X;
- (CGFloat)WL_Y;
- (CGFloat)WL_Width;
- (CGFloat)WL_Height;


- (void)WL_setX:(CGFloat)X;
- (void)WL_setY:(CGFloat)Y;
- (void)WL_setWidth:(CGFloat)width;
- (void)WL_setHeight:(CGFloat)height;

@end
