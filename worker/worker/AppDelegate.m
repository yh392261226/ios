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


@interface AppDelegate () <UISplitViewControllerDelegate, UITabBarControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self initTab];
    
    
    
    // 要使用百度地图，请先启动BaiduMapManager  _mapManager = [[BMKMapManager alloc]init]; // 如果要关注网络及授权验证事件，请设定 generalDelegate参数
    
    mapManager = [[BMKMapManager alloc] init];
    
    BOOL ret = [mapManager start:@"fZcAFCOF1IqvyANKiiHIec0paItUDAnQ" generalDelegate:nil];
   
    if (!ret)
    {
        NSLog(@"manager start failed!");
    }
    
    
    
    
    [self.window makeKeyAndVisible];
    
    return YES;
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


- (void)applicationDidEnterBackground:(UIApplication *)application
{
   
}


- (void)applicationWillEnterForeground:(UIApplication *)application
{
    
}


- (void)applicationDidBecomeActive:(UIApplication *)application
{
    
}


- (void)applicationWillTerminate:(UIApplication *)application
{
   
}




@end
