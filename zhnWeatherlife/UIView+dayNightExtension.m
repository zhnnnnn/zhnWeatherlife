//
//  UIView+dayNightExtension.m
//  zhnWeatherlife
//
//  Created by zhn on 16/8/10.
//  Copyright © 2016年 zhn. All rights reserved.
//

#import "UIView+dayNightExtension.h"

#import "WLconfig.h"
#import <objc/runtime.h>


//void swizzingMethod(Class class,SEL orig,SEL new){
//    
//    Method origMethod = class_getInstanceMethod(class, orig);
//    Method newMethod = class_getInstanceMethod(class, new);
//    
//    if (class_addMethod(class, orig, method_getImplementation(newMethod), method_getTypeEncoding(newMethod))) {
//        class_replaceMethod(class, new, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
//    }else{
//        method_exchangeImplementations(origMethod, newMethod);
//    }
//}

@implementation UIView (dayNightExtension)

+ (void)load{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        SEL originalSelector = @selector(setBackgroundColor:);
        SEL swizzledSelector = @selector(wl_setBackGroundColor:);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL success = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        if (success) {
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
 
}


- (void)wl_setBackGroundColor:(UIColor *)color{
    
    if ([[[WLconfig shareInstance]wl_getDayOrNight] isEqualToString:KdayValue]) {
        
        if ([color isEqual:KnightColor]) {
            color = KdayColor;
        }
        
        if([color isEqual:[UIColor blackColor]]){
            color = [UIColor whiteColor];
        }
        
    }else{
        
        if ([color isEqual:KdayColor]) {
            color = KnightColor;
        }
        
        if ([color isEqual:[UIColor whiteColor]]) {
            color = [UIColor blackColor];
        }
    }
    
    [self wl_setBackGroundColor:color];
}

@end
