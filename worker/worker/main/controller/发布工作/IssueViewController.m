//
//  IssueViewController.m
//  worker
//
//  Created by 郭健 on 2017/8/9.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "IssueViewController.h"

@interface IssueViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *dataArray;
}

@property (nonatomic, strong)UITableView *tableview;

@end

@implementation IssueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    dataArray = [NSMutableArray array];
    
    [self addhead:@"发布工作"];
    
    [self slitherBack:self.navigationController];
    
    
    
    
}


#pragma tableview代理



















- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
