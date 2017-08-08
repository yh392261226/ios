//
//  ProfessionViewController.m
//  worker
//
//  Created by 郭健 on 2017/7/31.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "ProfessionViewController.h"
#import "ProfessionTableViewCell.h"
#import "WorkerMessViewController.h"
#import "workerModel.h"

@interface ProfessionViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *dataArray;
}


@property (nonatomic, strong)UITableView *tableview;

@end

@implementation ProfessionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    dataArray = [NSMutableArray array];
    [dataArray addObject:@"12"];
    [dataArray addObject:@"12"];
    [dataArray addObject:@"12"];
    [dataArray addObject:@"12"];
    
    
    [self addhead:@"选择工种"];
    
    [self slitherBack:self.navigationController];
    
    [self tableview];
}



#pragma Tableview

- (UITableView *)tableview
{
    if (!_tableview)
    {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
        
        [_tableview registerClass:[ProfessionTableViewCell class] forCellReuseIdentifier:@"cell"];
        
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
    ProfessionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    self.hidesBottomBarWhenPushed = YES;
    
    WorkerMessViewController *temp = [[WorkerMessViewController alloc] init];
    
    [self.navigationController pushViewController:temp animated:YES];
    
    
}


//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView *view = [[UIView alloc] init];
//    
//    UILabel *title = [[UILabel alloc] init];
//    
//    title.textAlignment = NSTextAlignmentCenter;
//    
//    title.font = [UIFont systemFontOfSize:15];
//    
//    title.text = @"- 选择工种 -";
//    
//    [view addSubview:title];
//    
//    [title mas_makeConstraints:^(MASConstraintMaker *make)
//    {
//        make.centerX.mas_equalTo(view);
//        make.bottom.mas_equalTo(view).offset(-7);
//        make.width.mas_equalTo(100);
//        make.height.mas_equalTo(20);
//        
//    }];
//    
//    
//    UIView *line = [[UIView alloc] init];
//    
//    line.backgroundColor = [myselfway stringTOColor:@"0xE4E3E5"];
//    
//    [view addSubview:line];
//    
//    [line mas_makeConstraints:^(MASConstraintMaker *make)
//     {
//         make.left.mas_equalTo(view).offset(10);
//         make.top.mas_equalTo(view).offset(39);
//         make.width.mas_equalTo(SCREEN_WIDTH - 5);
//         make.height.mas_equalTo(1);
//         
//     }];
//    
//    
//    return view;
//}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
