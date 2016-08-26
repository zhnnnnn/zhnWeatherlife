//
//  UIImageView+WLextension.m
//  zhnWeatherlife
//
//  Created by zhn on 16/8/10.
//  Copyright © 2016年 zhn. All rights reserved.
//

#import "UIImageView+WLextension.h"
#import "WLconfig.h"

@implementation UIImageView (WLextension)


- (void)wl_setImage:(NSString *)imageName{
    
    if ([[[WLconfig shareInstance]wl_getDayOrNight] isEqualToString:KdayValue]) {
        
        imageName = [imageName stringByReplacingOccurrencesOfString:@"dark" withString:@"light"];
        
    }else{
      
        imageName = [imageName stringByReplacingOccurrencesOfString:@"light" withString:@"dark"];
    }

    UIImage * currentImage = [UIImage imageNamed:imageName];
    self.image = currentImage;
}

@end
