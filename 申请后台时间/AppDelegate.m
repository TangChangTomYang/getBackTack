//
//  AppDelegate.m
//  申请后台时间
//
//  Created by yangrui on 2019/2/25.
//  Copyright © 2019年 yangrui. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}

-(void)testBackGroundTimeLen{
    
//    每隔1 秒写一个信息 测试到本地文件
    
}

// 了解一下 http://www.mamicode.com/info-detail-2249729.html
- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
   [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(testBackGroundTimeLen) userInfo:nil repeats:YES];
    
    
    
    // 开始申请额外时间, 拿借据
    __block UIBackgroundTaskIdentifier bgTask;
    bgTask = [[UIApplication sharedApplication]  beginBackgroundTaskWithExpirationHandler:^{
        
        
        // 时间到了,还没完, 强行还借据
        ////在ios7以前，后台可以用下面的的方式，去在后台存活5-10分钟，在ios8中，只能存活3分钟。
        // 如果在系统规定时间内任务还没有完成，在时间到之前会调用到这个方法，一般是10分钟
        dispatch_async(dispatch_get_main_queue(), ^{
            [[UIApplication sharedApplication] endBackgroundTask:bgTask];
            if (bgTask != UIBackgroundTaskInvalid) {
                bgTask = UIBackgroundTaskInvalid;
            }
        });
    }];
    
    
    // 开始做自己的后台完善工作
    // ....
    
    // 后台工作完善后 还借据
    [[UIApplication sharedApplication] endBackgroundTask:bgTask];
    bgTask = UIBackgroundTaskInvalid;
    
    

}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
