//
//  extensionNetWork.m
//  zhnWeatherlife
//
//  Created by zhn on 16/8/12.
//  Copyright © 2016年 zhn. All rights reserved.
//

#import "extensionNetWork.h"
#import <AFNetworking/AFNetworking.h>

@implementation extensionNetWork
+ (extensionNetWork *)shareInstance{
    
    static extensionNetWork * baseNetWork;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        baseNetWork = [[extensionNetWork alloc]init];
    });
    return baseNetWork;
    
}

- (void)WLgetStatusWithUrl:(NSString *)url params:(NSDictionary *)params success:(successBlock)success error:(errorBlock)netError{
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"text/html", @"application/json", @"text/json", @"text/javascript", nil];
    manager.securityPolicy.allowInvalidCertificates= YES;
    manager.securityPolicy.validatesDomainName = NO;
    
    [manager GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (netError) {
            netError(error);
        }
        
    }];
}

- (void)WL_requestALLstatusWithLongitude:(CGFloat)longitude dimensionality:(CGFloat)dimensionality success:(successBlock)success error:(errorBlock)netError{
    
    NSString * fullStr = [NSString stringWithFormat:@"https://api.forecast.io/forecast/%@/%.6f,%.6f",@"4d61ddd8aa44d47c3a1ea1ad006f62e1",dimensionality,longitude];
    [self WLgetStatusWithUrl:fullStr params:nil success:success error:netError];
    
}
@end
