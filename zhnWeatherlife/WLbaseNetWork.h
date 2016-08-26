//
//  WLbaseNetWork.h
//  zhnWeatherlife
//
//  Created by zhn on 16/8/5.
//  Copyright © 2016年 zhn. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^successBlock)(id result);
typedef void(^errorBlock)(NSError * error);

@interface WLbaseNetWork : NSObject


+ (instancetype)shareInstance;

- (void)WLgetStatusWithUrl:(NSString *)url params:(NSDictionary *)params success:(successBlock)success error:(errorBlock)netError;


@end
