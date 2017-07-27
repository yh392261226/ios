//
//  AppDelegate.m
//  worker
//
//  Created by 郭健 on 2017/7/26.
//  Copyright © 2017年 郭健. All rights reserved.


#import "AppDelegate.h"
#import "MainViewController.h"
//#import "JobViewController.h"
//#import "MessageViewController.h"
//#import "MineViewController.h"


@interface AppDelegate () <UISplitViewControllerDelegate, UITabBarControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    MainViewController *main = [[MainViewController alloc] init];
    
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:main];
    
    self.window.rootViewController = navi;
    
    //[self initTab];
    
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
    
    
    NSDictionary *dictMain = [NSDictionary dictionaryWithObject:[UIColor orangeColor] forKey:NSForegroundColorAttributeName];
    [main.tabBarItem setTitleTextAttributes:dictMain forState:UIControlStateSelected];
    main.tabBarItem.selectedImage = [[UIImage imageNamed:@""] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    main.tabBarItem.image = [[UIImage imageNamed:@""] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    
    UINavigationController *naviMain = [[UINavigationController alloc] initWithRootViewController:main];
    
    
    
    
    
//    JobViewController *job = [[JobViewController alloc] init];
//    job.title = @"工作管理";
//    NSDictionary *dictJob = [NSDictionary dictionaryWithObject:[UIColor orangeColor] forKey:NSForegroundColorAttributeName];
//    [job.tabBarItem setTitleTextAttributes:dictJob forState:UIControlStateSelected];
//    job.tabBarItem.selectedImage = [[UIImage imageNamed:@""] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    job.tabBarItem.image = [[UIImage imageNamed:@""] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//
//    
//    UINavigationController *naviJob = [[UINavigationController alloc] initWithRootViewController:job];
//    
//    
//    
//    
//    
//    MessageViewController *Mess = [[MessageViewController alloc] init];
//    Mess.title = @"优惠信息";
//    NSDictionary *dictMess = [NSDictionary dictionaryWithObject:[UIColor orangeColor] forKey:NSForegroundColorAttributeName];
//    [Mess.tabBarItem setTitleTextAttributes:dictMess forState:UIControlStateSelected];
//    Mess.tabBarItem.selectedImage = [[UIImage imageNamed:@""] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    Mess.tabBarItem.image = [[UIImage imageNamed:@""] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    
//    UINavigationController *naviMess = [[UINavigationController alloc] initWithRootViewController:Mess];
//    
//    
//    
//    
//    
//    
//    MineViewController *mine = [[MineViewController alloc] init];
//    mine.title = @"我的";
//    NSDictionary *dictMine = [NSDictionary dictionaryWithObject:[UIColor orangeColor] forKey:NSForegroundColorAttributeName];
//    [Mess.tabBarItem setTitleTextAttributes:dictMine forState:UIControlStateSelected];
//    Mess.tabBarItem.selectedImage = [[UIImage imageNamed:@""] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    Mess.tabBarItem.image = [[UIImage imageNamed:@""] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    
//
//    UINavigationController *naviMine = [[UINavigationController alloc] initWithRootViewController:mine];
//    
//    
    
    
    
    
  //  NSArray *tabArr = @[naviMain, naviJob, naviMess, naviMine];
    
  //  tab.viewControllers = tabArr;
    
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
