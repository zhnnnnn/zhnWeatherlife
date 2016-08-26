//
//  extensionNetWork.h
//  zhnWeatherlife
//
//  Created by zhn on 16/8/12.
//  Copyright © 2016年 zhn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^successBlock)(id result);
typedef void(^errorBlock)(NSError * error);
@interface extensionNetWork : NSObject

+ (instancetype)shareInstance;

- (void)WLgetStatusWithUrl:(NSString *)url params:(NSDictionary *)params success:(successBlock)success error:(errorBlock)netError;


/**
 *  获取天气数据
 *
 *  @param longitude      经度
 *  @param dimensionality 纬度
 *  @param success        成功的回调
 *  @param netError       失败的回调
 */

- (void)WL_requestALLstatusWithLongitude:(CGFloat)longitude dimensionality:(CGFloat)dimensionality success:(successBlock)success error:(errorBlock)netError;
@end
