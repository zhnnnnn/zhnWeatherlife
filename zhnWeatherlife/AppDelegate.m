//
//  AppDelegate.m
//  zhnWeatherlife
//
//  Created by zhn on 16/8/4.
//  Copyright © 2016年 zhn. All rights reserved.
//

#import "AppDelegate.h"
#import "WLmainViewController.h"
#import "RealReachability.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    

    [GLobalRealReachability startNotifier];
    
    UIWindow * keyWindow = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window = keyWindow;
    WLmainViewController * mainViewController = [[WLmainViewController alloc]init];
    keyWindow.rootViewController = mainViewController;

    [keyWindow makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
    // 从后台进入到前台的通知
    [[NSNotificationCenter defaultCenter]postNotificationName:KapplicationBecomActiveNotification object:nil];
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
