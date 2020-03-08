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
/**
申请的后台任务标识
app进入后台时, 申请后台任务, 返回后台任务标识
app从后台返回前台时, 如果申请的后台任务还没结束, 需要结束后台任务
*/
static UIBackgroundTaskIdentifier _bgTask;
@implementation AppDelegate

 

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  
    return YES;
}



-(void)testBackGroundTimeLen{
    
//    每隔1 秒写一个信息 测试到本地文件
    NSLog(@"=========");
    
}

 // https://www.jianshu.com/p/f1b3cda7a61f
- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(testBackGroundTimeLen) userInfo:nil repeats:YES];
    
    
    // 申请后台任务(一般为3分钟)
    _bgTask= [[UIApplication sharedApplication]  beginBackgroundTaskWithExpirationHandler:^{
        
        /**
         当你想app申请的后台任务时间快结束了, 就会回调这个block块, 你需要在这个blcok内做一些
         清理收尾方面的工作, 否则可能会导致程序出错.
         这个block 会在主线程调用, 因此你可以在这个block内放心大胆的处理你的收尾工作
         */
        
        NSLog(@"申请的后台任务时间 快结束了, 赶紧在这个block内处理你的收尾工作, %@",[NSThread currentThread]);
        
        [[UIApplication sharedApplication] endBackgroundTask:_bgTask];
        if (_bgTask != UIBackgroundTaskInvalid) {
            _bgTask = UIBackgroundTaskInvalid;
        }
    }];
    
}



-(void)applicationWillEnterForeground:(UIApplication *)application{
    
    //app从后台返回前台时, 如果申请的后台任务还没结束, 需要结束后台任务
    if (_bgTask != UIBackgroundTaskInvalid) {
        [[UIApplication sharedApplication] endBackgroundTask:_bgTask];
        _bgTask  = UIBackgroundTaskInvalid;
    }
    
    
}


@end
