//
//  MineMessViewController.m
//  worker
//
//  Created by 郭健 on 2017/8/3.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "MineMessViewController.h"
#import "MessTableViewCell.h"

@interface MineMessViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *dataArray;
    
    NSInteger type;    //判断是工作邀约还是系统消息
}

@property (nonatomic, strong)UITableView *tableview;

@end

@implementation MineMessViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    type = 0;
    
    dataArray = [NSMutableArray array];
    [dataArray addObject:@"1"];
    [dataArray addObject:@"1"];
    
    [self addhead:@"我的消息"];
    
    self.view.backgroundColor = [myselfway stringTOColor:@"0xC4CED3"];
    
    [self tableview];
    
    
}


#pragma tableview

- (UITableView *)tableview
{
    if (!_tableview)
    {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 74, SCREEN_WIDTH, SCREEN_HEIGHT - 74) style:UITableViewStylePlain];
        
        _tableview.delegate = self;
        _tableview.dataSource = self;
        
        _tableview.backgroundColor = [myselfway stringTOColor:@"0xC4CED3"];
        
        [_tableview registerClass:[MessTableViewCell class] forCellReuseIdentifier:@"messcell"];
        
        [self.view addSubview:_tableview];
        
    }
    
    
    return _tableview;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"messcell"];
    
    if (type == 1)
    {
        cell.look.hidden = YES;
    }
    else
    {
        cell.look.hidden = NO;
    }
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 62.5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (type == 0)
    {
        NSLog(@"工作邀约");
    }
    else
    {
        NSLog(@"系统消息");
    }
    
    
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    
    view.backgroundColor = [UIColor whiteColor];
    
    UIButton *left = [UIButton buttonWithType:UIButtonTypeCustom];
    
    left.frame = CGRectMake(0, 0, SCREEN_WIDTH / 2, 40);
    
    [left addTarget:self action:@selector(workerBtn) forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:left];
    
    UIButton *right = [UIButton buttonWithType:UIButtonTypeCustom];
    
    right.frame = CGRectMake(SCREEN_WIDTH / 2, 0, SCREEN_WIDTH / 2, 40);
    
    [right addTarget:self action:@selector(messBtn) forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:right];
    
    UILabel *leftlab = [[UILabel alloc] init];
    
    leftlab.text = @"工作邀约";
    
    leftlab.tag = 200;
    
    leftlab.textColor = [UIColor grayColor];
    
    leftlab.font = [UIFont systemFontOfSize:15];
    
    leftlab.textAlignment = NSTextAlignmentCenter;
    
    [view addSubview:leftlab];
    
    
    UILabel *rightlab = [[UILabel alloc] init];
    
    rightlab.text = @"系统消息";
    
    rightlab.textColor = [UIColor grayColor];
    
    rightlab.tag = 300;
    
    rightlab.font = [UIFont systemFontOfSize:15];
    
    rightlab.textAlignment = NSTextAlignmentCenter;
    
    [view addSubview:rightlab];
    
    
    if (type == 0)
    {
        leftlab.textColor = [UIColor redColor];
    }
    else
    {
        rightlab.textColor = [UIColor redColor];
    }
    
    
    [leftlab mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.centerX.mas_equalTo(left);
        make.top.mas_equalTo(left).offset(5);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
        
    }];
    
    
    
    [rightlab mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.centerX.mas_equalTo(right);
         make.top.mas_equalTo(right).offset(5);
         make.width.mas_equalTo(100);
         make.height.mas_equalTo(30);
         
     }];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(15, 39, SCREEN_WIDTH - 15, 1)];
    
    line.backgroundColor = [myselfway stringTOColor:@"0xE4E3E5"];
    
    [view addSubview:line];
    
    
    return view;
}




//工作邀约按钮
- (void)workerBtn
{
    type = 0;
  
    
    [self.tableview reloadData];
}






//系统消息按钮
- (void)messBtn
{
    type = 1;
    
    
    [self.tableview reloadData];
}








- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
