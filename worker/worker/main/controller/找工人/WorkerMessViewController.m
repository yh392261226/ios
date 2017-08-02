//
//  WorkerMessViewController.m
//  worker
//
//  Created by 郭健 on 2017/8/2.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "WorkerMessViewController.h"
#import "WorkerMessTableViewCell.h"

@interface WorkerMessViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *dataArray;
}


@property (nonatomic, strong)UITableView *tableview;

@end

@implementation WorkerMessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    dataArray = [NSMutableArray array];
    [dataArray addObject:@"1"];
    [dataArray addObject:@"1"];
    [dataArray addObject:@"1"];
    [dataArray addObject:@"1"];
    [dataArray addObject:@"1"];
    
    [self addhead:@"工人信息"];
    
    [self initScreenBtn];
    
    [self slitherBack:self.navigationController];
    
    [self tableview];
}




#pragma Tableview

- (UITableView *)tableview
{
    if (!_tableview)
    {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
        
        [_tableview registerClass:[WorkerMessTableViewCell class] forCellReuseIdentifier:@"cell"];
        
        _tableview.backgroundColor = [myselfway stringTOColor:@"0xC4CED3"];
        
        _tableview.delegate = self;
        _tableview.dataSource = self;
        
        [self.view addSubview:_tableview];
    }
    
    return _tableview;
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return dataArray.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WorkerMessTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}


#pragma 自己的方法

//添加筛选按钮
- (void)initScreenBtn
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    button.frame = CGRectMake(SCREEN_WIDTH - 35, 33, 20, 20);
    
    [button addTarget:self action:@selector(screenBtn) forControlEvents:UIControlEventTouchUpInside];
    
    [button setBackgroundImage:[UIImage imageNamed:@"main_ screen"] forState:UIControlStateNormal];
    
    [self.view addSubview:button];
    
}


//筛选按钮的点击事件
- (void)screenBtn
{
    NSLog(@"1");
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
