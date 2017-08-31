//
//  SetPasswordViewController.m
//  worker
//
//  Created by 郭健 on 2017/8/30.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "SetPasswordViewController.h"
#import "PasswordViewController.h"

@interface SetPasswordViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *dataArray;
}

@property (nonatomic, strong)UITableView *tableview;

@end

@implementation SetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (self.type == 0)
    {
        dataArray = [NSMutableArray arrayWithObjects:@"修改支付密码", nil];
    }
    else
    {
        dataArray = [NSMutableArray arrayWithObjects:@"设置支付密码", nil];
    }
    
    
    [self addhead:@"密码设置"];
    
    [self slitherBack:self.navigationController];
    
    [self tableview];
    
}



#pragma tableview 代理方法

- (UITableView *)tableview
{
    if (!_tableview)
    {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStyleGrouped];
        
        [_tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        
        _tableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.1)];
        _tableview.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.1)];
        
        
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
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(15, 7.5, 200, 30)];
        
        name.textColor = [UIColor grayColor];
        
        name.font = [UIFont systemFontOfSize:16];
        
        name.text = [dataArray objectAtIndex:indexPath.section];
        
        [cell addSubview:name];
        
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    self.hidesBottomBarWhenPushed = YES;
    
    if (self.type == 0)
    {
        //修改支付密码走的路
        
        
    }
    else
    {
        PasswordViewController *temp = [[PasswordViewController alloc] init];
        
        [self.navigationController pushViewController:temp animated:YES];
    }
    
    
}










- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
