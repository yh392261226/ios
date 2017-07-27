//
//  MainViewController.m
//  worker
//
//  Created by 郭健 on 2017/7/27.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "MainViewController.h"
#import "TabbarView.h"

@interface MainViewController ()
{
    TabbarView *tabbar;
}

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationController.navigationBarHidden = YES;
    
    [myselfway initHeadView:self.view title:@"首页"];
    
    [self initTabbar];
    
    
}
































//加载tabbar
- (void)initTabbar
{
    tabbar = [[TabbarView alloc] init];
    tabbar.frame = CGRectMake(0, SCREEN_HEIGHT - 49, SCREEN_WIDTH, 49);
    [tabbar.MainIcon addTarget:self action:@selector(MainBtn) forControlEvents:UIControlEventTouchUpInside];
    [tabbar.JobIcon addTarget:self action:@selector(JobBtn) forControlEvents:UIControlEventTouchUpInside];
    [tabbar.MessIcon addTarget:self action:@selector(MessBtn) forControlEvents:UIControlEventTouchUpInside];
    [tabbar.MineIcon addTarget:self action:@selector(MineBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:tabbar];
}

//tabbar首页点击事件
- (void)MainBtn
{
   
}

//tabbar工作管理点击事件
- (void)JobBtn
{
    
}

//tabbar优惠信息点击事件
- (void)MessBtn
{
    
}

//tabbar我的点击事件
- (void)MineBtn
{
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
