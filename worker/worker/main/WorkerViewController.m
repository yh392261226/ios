//
//  WorkerViewController.m
//  worker
//
//  Created by 郭健 on 2017/8/20.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "WorkerViewController.h"
#import "MainViewController.h"
#import "JobViewController.h"
#import "MessViewController.h"
#import "MineViewController.h"

@interface WorkerViewController ()

@end

@implementation WorkerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self initTab];
}


- (void)initTab
{
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
    
    self.viewControllers = tabArr;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
