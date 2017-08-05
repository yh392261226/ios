//
//  AppDelegate.m
//  worker
//
//  Created by 郭健 on 2017/7/26.
//  Copyright © 2017年 郭健. All rights reserved.


#import "AppDelegate.h"
#import "MainViewController.h"
#import "JobViewController.h"
#import "MessViewController.h"
#import "MineViewController.h"
#import "JPUSHService.h"
#import <UserNotifications/UserNotifications.h>


@interface AppDelegate () <UISplitViewControllerDelegate, UITabBarControllerDelegate, JPUSHRegisterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self initTab];
    
    [self BaiduMap];
    
    [self Jpush];
    

    
    
    [self.window makeKeyAndVisible];
    
    return YES;
}


//极光推送
- (void)Jpush
{
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0)
    {
        JPUSHRegisterEntity *entity = [[JPUSHRegisterEntity alloc] init];
        
        entity.types = UNAuthorizationOptionAlert|UNAuthorizationOptionBadge|UNAuthorizationOptionSound;
        
        [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    }
    else if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0)
    {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert) categories:nil];
        
    }
    else
    {
        //categories 必须为nil
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert) categories:nil];

    }
    NSDictionary *launchOptions = [NSDictionary dictionary];
    
    [JPUSHService setupWithOption:launchOptions appKey:@"246e2fe4b6e564597c8652f7"
                          channel:@"apple store"
                 apsForProduction:NO
            advertisingIdentifier:nil];
    
    // 这里是没有advertisingIdentifier的情况，有的话，大家在自行添加
    //注册远端消息通知获取device token
    
   
    
    
    
}


// ios 10 support 处于前台时接收到通知
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler { NSDictionary * userInfo = notification.request.content.userInfo; if ([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]])
    {
        [JPUSHService handleRemoteNotification:userInfo]; // 添加各种需求。。。。。
    }
    
    completionHandler(UNNotificationPresentationOptionAlert);
    // 处于前台时，添加需求，一般是弹出alert跟用户进行交互，这时候completionHandler(UNNotificationPresentationOptionAlert)这句话就可以注释掉了，这句话是系统的alert，显示在app的顶部，
}


// iOS 10 Support  点击处理事件
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler
{
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]])
    {
        [JPUSHService handleRemoteNotification:userInfo];
        //推送打开
        if (userInfo)
        {
            // 取得 APNs 标准信息内容 //
            NSDictionary *aps = [userInfo valueForKey:@"aps"];
            //
            NSString *content = [aps valueForKey:@"alert"]; //推送显示的内容 //
            NSInteger badge = [[aps valueForKey:@"badge"] integerValue];
            //badge数量 //
            NSString *sound = [aps valueForKey:@"sound"];
            //播放的声音
            
            // 添加各种需求。。。。。
            [JPUSHService handleRemoteNotification:userInfo]; completionHandler(UIBackgroundFetchResultNewData);
          }
    completionHandler();
    // 系统要求执行这个方法
    
    }
    
}



- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    
    completionHandler(UIBackgroundFetchResultNewData);
    
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive)
    {
        // 处于前台时 ，添加各种需求代码。。。。
    
    }
    else if ([UIApplication sharedApplication].applicationState == UIApplicationStateBackground)
    {
        // app 处于后台 ，添加各种需求
        
    }
        
        
}

//设置角标为0

//当程序被推送到后台的时候调用。所以要设置后台继续运行，则在这个函数里面设置即可
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [[UIApplication alloc] setApplicationIconBadgeNumber:0];
}



//点击之后badge清零

//当程序从后台将要重新回到前台时候调用

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [application setApplicationIconBadgeNumber:0];
    
    [[UNUserNotificationCenter alloc] removeAllPendingNotificationRequests];
}





    




//- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
//{
//    
//    /// Required - 注册 DeviceToken
//    [JPUSHService registerDeviceToken:deviceToken];
//    
//}
//
//
//- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
//{
//    //处理收到的 APNs 消息
//    [JPUSHService handleRemoteNotification:userInfo];
//    
//    
//}
//
//
//- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
//    
//    // IOS 7 Support Required
//    [JPUSHService handleRemoteNotification:userInfo];
//    completionHandler(UIBackgroundFetchResultNewData);
//}
//
//
//- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
//{
//    //Optional
//    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
//}

//集成百度地图
- (void)BaiduMap
{
    // 要使用百度地图，请先启动BaiduMapManager  _mapManager = [[BMKMapManager alloc]init]; // 如果要关注网络及授权验证事件，请设定 generalDelegate参数
    
    mapManager = [[BMKMapManager alloc] init];
    
    BOOL ret = [mapManager start:@"fZcAFCOF1IqvyANKiiHIec0paItUDAnQ" generalDelegate:nil];
    
    if (!ret)
    {
        NSLog(@"manager start failed!");
    }
    
    
}




//加载tabbar
- (void)initTab
{
    UITabBarController *tab = [[UITabBarController alloc] init];
    
    self.window.rootViewController = tab;
    
    MainViewController *main = [[MainViewController alloc] init];
    main.title = @"首页";
    
    //修改tabbar默认颜色
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[myselfway stringTOColor:@"0x3589F8"], NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    
    
    NSDictionary *dictMain = [NSDictionary dictionaryWithObject:[UIColor redColor] forKey:NSForegroundColorAttributeName];
    
    
    [main.tabBarItem setTitleTextAttributes:dictMain forState:UIControlStateSelected];
    main.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_main"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    main.tabBarItem.image = [[UIImage imageNamed:@"tabbar_mainback"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    
    UINavigationController *naviMain = [[UINavigationController alloc] initWithRootViewController:main];
    
    
    JobViewController *job = [[JobViewController alloc] init];
    job.title = @"工作管理";
    NSDictionary *dictJob = [NSDictionary dictionaryWithObject:[UIColor redColor] forKey:NSForegroundColorAttributeName];
    [job.tabBarItem setTitleTextAttributes:dictJob forState:UIControlStateSelected];
    job.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_job"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    job.tabBarItem.image = [[UIImage imageNamed:@"tabbar_jobback"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    
    UINavigationController *naviJob = [[UINavigationController alloc] initWithRootViewController:job];
    
    
    
    
    
    MessViewController *Mess = [[MessViewController alloc] init];
    Mess.title = @"优惠信息";
    NSDictionary *dictMess = [NSDictionary dictionaryWithObject:[UIColor redColor] forKey:NSForegroundColorAttributeName];
    [Mess.tabBarItem setTitleTextAttributes:dictMess forState:UIControlStateSelected];
    Mess.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_mess"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    Mess.tabBarItem.image = [[UIImage imageNamed:@"tabbar_messback"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UINavigationController *naviMess = [[UINavigationController alloc] initWithRootViewController:Mess];
    
    
    
    
    
    
    MineViewController *mine = [[MineViewController alloc] init];
    mine.title = @"我的";
    NSDictionary *dictMine = [NSDictionary dictionaryWithObject:[UIColor redColor] forKey:NSForegroundColorAttributeName];
    [mine.tabBarItem setTitleTextAttributes:dictMine forState:UIControlStateSelected];
    mine.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_mine"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    mine.tabBarItem.image = [[UIImage imageNamed:@"tabbar_mineback"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    

    UINavigationController *naviMine = [[UINavigationController alloc] initWithRootViewController:mine];
    
    
    
    
    
    
    NSArray *tabArr = @[naviMain, naviJob, naviMess, naviMine];
    
    tab.viewControllers = tabArr;
    
}












- (void)applicationWillResignActive:(UIApplication *)application
{
  
}





- (void)applicationDidBecomeActive:(UIApplication *)application
{
    
}


- (void)applicationWillTerminate:(UIApplication *)application
{
   
}




@end
