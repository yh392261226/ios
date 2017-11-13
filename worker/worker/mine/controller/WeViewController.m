//
//  WeViewController.m
//  worker
//
//  Created by sd on 2017/10/10.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "WeViewController.h"

@interface WeViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *dataArray;
    
    
    
}




@property (nonatomic, strong)UITableView *tableview;

@end

@implementation WeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    dataArray = [NSMutableArray array];
    
    [self addhead:@"关于我们"];
    
    [self tableview];
}




#pragma tableview的代理

- (UITableView *)tableview
{
    if (!_tableview)
    {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 65, SCREEN_WIDTH, SCREEN_HEIGHT - 65) style:UITableViewStyleGrouped];
        
        _tableview.delegate = self;
        _tableview.dataSource = self;
        
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _tableview.backgroundColor = [myselfway stringTOColor:@"0xC4CED3"];
        
        [_tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        
        _tableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.1)];
        _tableview.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.1)];
        
        [self.view addSubview:_tableview];
        
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:14];
        label.numberOfLines = 2;
        label.textColor = [UIColor grayColor];
        label.text = @"版权所有©2015-2017\n哈尔滨钢建电子商务有限公司";
        label.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:label];
   
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.view);
            make.bottom.mas_equalTo(self.view).offset(-30);
            make.height.mas_equalTo(40);
            make.width.mas_equalTo(250);
        }];
    }
    
    return _tableview;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 1;
    }
    else
    {
        return 2;
    }
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.section == 0)
    {
        UIImageView *ima = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 60, 60)];
        
        ima.image = [UIImage imageNamed:@"yong"];
        
        [cell addSubview:ima];
        
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = [myselfway stringTOColor:@"0x2E84F8"];
        label.text = @"新用工 V1.0.0";
        label.font = [UIFont systemFontOfSize:17];
        
        [cell addSubview:label];
        
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(ima).offset(70);
            make.centerY.mas_equalTo(cell);
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(150);
        }];
        
        
    }
    else
    {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 300, 30)];
        label.textColor = [myselfway stringTOColor:@"0x2E84F8"];
        label.font = [UIFont systemFontOfSize:16];
        if (indexPath.row == 0)
        {
            label.text = @"官方网站：www.gangjianwang.com";
        }
        else
        {
            label.text = @"客服电话：0451-58567363";
        }
        [cell addSubview:label];
        
    }
    
    
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return 100;
    }
    else
    {
        return 40;
    }
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    
    return view;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    
    return view;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
