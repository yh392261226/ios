//
//  JobViewController.m
//  worker
//
//  Created by 郭健 on 2017/8/1.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "JobViewController.h"
#import "FirstTableViewCell.h"
#import "ElseTableViewCell.h"
#import "RechargeViewController.h"
#import "WorkerManagementViewController.h"
#import "EmployerManagementViewController.h"
#import "PersonageManagementViewController.h"
#import "IssueViewController.h"
#import "MineMoneyViewController.h"
#import "LoginViewController.h"

@interface JobViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *titleArr;
}




@property (nonatomic, strong)UITableView *tableview;

@end

@implementation JobViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    titleArr = [NSMutableArray arrayWithObjects:@"工人工作管理", @"雇主发布管理", @"个人信息管理", nil];
    
    
    
    self.navigationController.navigationBarHidden = YES;
    
    [self initHeadView];
    
    [self tableview];
    
    
}


#pragma tableview 代理方法

- (UITableView *)tableview
{
    if (!_tableview)
    {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 113) style:UITableViewStyleGrouped];
        
        [_tableview registerClass:[ElseTableViewCell class] forCellReuseIdentifier:@"elseCell"];
        
        [_tableview registerClass:[FirstTableViewCell class] forCellReuseIdentifier:@"firstcell"];
        
        _tableview.backgroundColor = [myselfway stringTOColor:@"0xC4CED3"];
        
        _tableview.delegate = self;
        _tableview.dataSource = self;
        
        [self.view addSubview:_tableview];
    }
    
    return _tableview;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        FirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"firstcell"];
        
        
        [cell.leftBtn addTarget:self action:@selector(rechargeBtn) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.rightBtn addTarget:self action:@selector(workerBtn) forControlEvents:UIControlEventTouchUpInside];
        
        
        return cell;
    }
    else
    {
        ElseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"elseCell"];
        
        cell.title.text = [titleArr objectAtIndex:indexPath.section - 1];
        
        
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return 80;
    }
    else
    {
        return 60;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 0.1;
    }
    else
    {
        return 15;
    }
    
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

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    self.hidesBottomBarWhenPushed = YES;
    
    if ([user_ID isEqualToString:@"0"] || user_ID == nil)
    {
        LoginViewController *temp = [[LoginViewController alloc] init];
        
        [self presentViewController:temp animated:YES completion:nil];
    }
    else
    {
        if (indexPath.section == 1)
        {
            
            WorkerManagementViewController *temp = [[WorkerManagementViewController alloc] init];
            [self.navigationController pushViewController:temp animated:YES];
            
            
            
        }
        else if (indexPath.section == 2)
        {
            EmployerManagementViewController *temp = [[EmployerManagementViewController alloc] init];
            [self.navigationController pushViewController:temp animated:YES];
            self.hidesBottomBarWhenPushed = NO;
        }
        else if(indexPath.section == 3)
        {
            
            PersonageManagementViewController *temp = [[PersonageManagementViewController alloc] init];
            [self.navigationController pushViewController:temp animated:YES];
            
        }
        else
        {
            
        }
    }
    
    
    
    self.hidesBottomBarWhenPushed = NO;
}

#pragma 自定义的方法


//加载头部view
- (void)initHeadView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    
    view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:view];
    
    UILabel *headlabel = [[UILabel alloc] init];
    
    headlabel.text = @"工作管理";
    
    [headlabel setTextColor:[myselfway stringTOColor:@"0x2E84F8"]];
    
    headlabel.textAlignment = NSTextAlignmentCenter;
    
//  headlabel.font = [UIFont systemFontOfSize:17];
    
    headlabel.font = [UIFont boldSystemFontOfSize:17];
    
    [self.view addSubview:headlabel];
    
    [headlabel mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.center.equalTo(self.view);
         make.bottom.mas_equalTo(view).offset(-7);
         make.height.mas_equalTo(30);
         make.width.mas_equalTo(200);
     }];
    
}

//充值按钮
- (void)rechargeBtn
{
    self.hidesBottomBarWhenPushed = YES;
    
    if ([user_ID isEqualToString:@"0"] || user_ID == nil)
    {
        LoginViewController *temp = [[LoginViewController alloc] init];
        
        [self presentViewController:temp animated:YES completion:nil];
    }
    else
    {
        MineMoneyViewController *temp = [[MineMoneyViewController alloc] init];
        
        [self.navigationController pushViewController:temp animated:YES];
    }
    
    self.hidesBottomBarWhenPushed = NO;
}

//发布工作按钮
- (void)workerBtn
{
    self.hidesBottomBarWhenPushed = YES;
    
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    
    if ([user_ID isEqualToString:@"0"] || user_ID == nil)
    {
        LoginViewController *temp = [[LoginViewController alloc] init];
        
        [self presentViewController:temp animated:YES completion:nil];
    }
    else if ([user_u_idcard isEqualToString:@"0"] || user_u_idcard == nil || user_u_idcard == NULL || [user_u_idcard isEqualToString:@""])
    {
        [SVProgressHUD showErrorWithStatus:@"请完善个人信息"];
    }
    else if (user_pass == nil || [user_pass isEqualToString:@"0"] || user_pass == NULL || [user_pass isEqualToString:@""])
    {
        [SVProgressHUD showErrorWithStatus:@"请设置提现密码"];
    }
    else
    {
        IssueViewController *temp = [[IssueViewController alloc] init];
      
        [self.navigationController pushViewController:temp animated:YES];
    }
    
    
    
    self.hidesBottomBarWhenPushed = NO;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
