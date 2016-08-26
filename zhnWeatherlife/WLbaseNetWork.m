//
//  WLbaseNetWork.m
//  zhnWeatherlife
//
//  Created by zhn on 16/8/5.
//  Copyright © 2016年 zhn. All rights reserved.
//

#import "WLbaseNetWork.h"
#import "AFNetworking.h"

@implementation WLbaseNetWork

+ (WLbaseNetWork *)shareInstance{
    
    static WLbaseNetWork * baseNetWork;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        baseNetWork = [[WLbaseNetWork alloc]init];
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
@end
