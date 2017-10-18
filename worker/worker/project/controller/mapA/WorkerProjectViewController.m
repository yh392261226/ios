//
//  WorkerProjectViewController.m
//  worker
//
//  Created by 郭健 on 2017/9/12.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "WorkerProjectViewController.h"
#import "WorkerProTableViewCell.h"

@interface WorkerProjectViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *dataArray;
    
    
    
}

@property (nonatomic, strong)UITableView *tableview;

@end

@implementation WorkerProjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    dataArray = [NSMutableArray array];
    [dataArray addObject:@"1"];
    [dataArray addObject:@"1"];
    
    [self addhead:@"选择招工项目"];
    
    
    [self tableview];
}


- (void)temp
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//懒加载
- (UITableView *)tableview
{
    if (!_tableview)
    {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStyleGrouped];
        
        _tableview.delegate = self;
        _tableview.dataSource = self;
        
        _tableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.1)];
        _tableview.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.1)];
        
        _tableview.backgroundColor = [myselfway stringTOColor:@"0xC4CED3"];
        
        [_tableview registerClass:[WorkerProTableViewCell class] forCellReuseIdentifier:@"cell"];
        
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
    
    WorkerProTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (!cell)
    {
        cell = [[WorkerProTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        cell.favoriteBtn.tag = 500 + indexPath.section;
        [cell.favoriteBtn addTarget:self action:@selector(favoriteBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        cell.rightBtn.tag = 900 + indexPath.section;
        [cell.rightBtn addTarget:self action:@selector(yesBtn:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return cell;
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 115;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 10;
    }
    else
    {
        return 0.1;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    
    
    return view;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    
    return view;
}



//收藏按钮
- (void)favoriteBtn: (id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    NSLog(@"%ld", btn.tag);
}




//邀约按钮
- (void)yesBtn: (id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    NSLog(@"%ld", btn.tag);
    
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [self.delegate success];
    
}

















- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
