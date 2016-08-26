//
//  UILabel+WLextension.m
//  zhnWeatherlife
//
//  Created by zhn on 16/8/10.
//  Copyright © 2016年 zhn. All rights reserved.
//

#import "UILabel+WLextension.h"
#import "WLconfig.h"
#import <objc/runtime.h>


void swizzingMethod(Class class,SEL orig,SEL new){
    
    Method origMethod = class_getInstanceMethod(class, orig);
    Method newMethod = class_getInstanceMethod(class, new);
    
    if (class_addMethod(class, orig, method_getImplementation(newMethod), method_getTypeEncoding(newMethod))) {
        class_replaceMethod(class, new, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    }else{
        method_exchangeImplementations(origMethod, newMethod);
    }
}

@implementation UILabel (WLextension)

+ (void)load{
    
    swizzingMethod([UILabel class], @selector(setTextColor:), @selector(wl_setTextColor:));
    
}

- (void)wl_setTextColor:(UIColor *)testColor{
    
    if ([[[WLconfig shareInstance]wl_getDayOrNight] isEqualToString:KdayValue]) {
       
        if ([testColor isEqual:[UIColor whiteColor]]) {
            testColor = [UIColor blackColor];
        }
        
    }else{
        
        if ([testColor isEqual:[UIColor blackColor]]) {
            testColor = [UIColor whiteColor];
        }
    }
    
    [self wl_setTextColor:testColor];
}

@end
