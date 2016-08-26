//
//  UIView+WLframe.m
//  zhnWeatherlife
//
//  Created by zhn on 16/8/5.
//  Copyright © 2016年 zhn. All rights reserved.
//

#import "UIView+WLframe.h"

@implementation UIView (WLframe)
- (CGFloat)WL_X{
    return self.frame.origin.x;
}
- (CGFloat)WL_Y{
    return self.frame.origin.y;
}
- (CGFloat)WL_Width{
    return self.frame.size.width;
}
- (CGFloat)WL_Height{
    return self.frame.size.height;
}


- (void)WL_setX:(CGFloat)X{
    
    CGFloat y = self.frame.origin.y;
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    
    self.frame = CGRectMake(X, y, width, height);
}
- (void)WL_setY:(CGFloat)Y{
    
    CGFloat x = self.frame.origin.x;
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    
    self.frame = CGRectMake(x, Y, width, height);
}
- (void)WL_setWidth:(CGFloat)width{
    
    CGFloat x = self.frame.origin.x;
    CGFloat y = self.frame.origin.y;
    CGFloat height = self.frame.size.height;
    
    self.frame = CGRectMake(x, y, width, height);
}
- (void)WL_setHeight:(CGFloat)height{
    
    CGFloat x = self.frame.origin.x;
    CGFloat y = self.frame.origin.y;
    CGFloat width = self.frame.size.width;
    
    self.frame = CGRectMake(x, y, width, height);
}

@end
