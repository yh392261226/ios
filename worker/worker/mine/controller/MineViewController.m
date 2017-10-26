//
//  MineViewController.m
//  worker
//
//  Created by 郭健 on 2017/8/1.
//  Copyright © 2017年 郭健. All rights reserved.
//  3398937837


#import "MineViewController.h"
#import "MineLoginTableViewCell.h"
#import "MineScrTableViewCell.h"
#import "MineMoneyTableViewCell.h"
#import "MineElesTableViewCell.h"
#import "MineMessViewController.h"
#import <UShareUI/UShareUI.h>
#import "LoginViewController.h"
#import "MineFavoriteViewController.h"
#import "SetViewController.h"
#import "EvaluateViewController.h"
#import "MineMoneyViewController.h"
#import "ServiceViewController.h"
#import "FriendViewController.h"
#import "SetPasswordViewController.h"
#import "packetViewController.h"
#import "discountViewController.h"

@interface MineViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *dataArray;
    
    NSMutableArray *elseIcon;    //图标数组
    NSMutableArray *titleArr;    //名称数组
    
}

@property (nonatomic, strong)UITableView *tableview;

@end

@implementation MineViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    
    dataArray = [NSMutableArray array];
    
    elseIcon = [NSMutableArray arrayWithObjects:@"mine_password",@"mine_list",@"mine_set",@"mine_call", nil];
    
    titleArr = [NSMutableArray arrayWithObjects:@"设置提现密码",@"服务条款",@"设置",@"客服", nil];
    
    
    [self initHeadView];
    
    [self tableview];
    
    //接受通知，   接受设置密码成功后的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changePassword:) name:@"changePassword" object:nil];
    
}

#pragma tableview代理

- (UITableView *)tableview
{
    if (!_tableview)
    {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 65, SCREEN_WIDTH, SCREEN_HEIGHT - 65) style:UITableViewStylePlain];
    
        [_tableview registerClass:[MineLoginTableViewCell class] forCellReuseIdentifier:@"logincell"];
        [_tableview registerClass:[MineScrTableViewCell class] forCellReuseIdentifier:@"scrcell"];
        [_tableview registerClass:[MineMoneyTableViewCell class] forCellReuseIdentifier:@"moneycell"];
        [_tableview registerClass:[MineElesTableViewCell class] forCellReuseIdentifier:@"elsecell"];
        
        _tableview.backgroundColor = [myselfway stringTOColor:@"0xC4CED3"];
        
        _tableview.delegate = self;
        _tableview.dataSource = self;
        
        [self.view addSubview:_tableview];
        
        [_tableview mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.top.mas_equalTo(self.view).offset(44 + StatusBarHeigh);
             make.left.mas_equalTo(self.view).offset(0);
             make.right.mas_equalTo(self.view).offset(0);
             make.bottom.mas_equalTo(self.view).offset(SCREEN_HEIGHT - 44 - StatusBarHeigh);
         }];
    }
    
    return _tableview;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 7;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section == 0)
    {
        
        MineLoginTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"logincell"];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        cell.loginBtn.hidden = YES;
        cell.introduce.hidden = YES;
        cell.userName.hidden = YES;
        cell.userImage.hidden = YES;
        cell.isstate.hidden = YES;
        cell.typeButton.hidden = YES;
        cell.textL.hidden = YES;
        
        //未登录状态
        if ([user_ID isEqualToString:@"0"])
        {
            [cell.loginBtn addTarget:self action:@selector(loginBtn) forControlEvents:UIControlEventTouchUpInside];
            
            cell.IconImage.image = [UIImage imageNamed:@"job_icon"];
            
            
            cell.loginBtn.hidden = NO;
            cell.introduce.hidden = NO;

            
            
        }
        else
        {
            
            cell.userName.hidden = NO;
            cell.userImage.hidden = NO;
            cell.isstate.hidden = NO;
            cell.typeButton.hidden = NO;
            cell.textL.hidden = NO;
            
            
            [cell.typeButton addTarget:self action:@selector(swiBtn:) forControlEvents:UIControlEventValueChanged];
            
            cell.userName.text = user_name;
            
            if ([user_online isEqualToString:@"1"])
            {
                cell.typeButton.on = YES;
            }
            else
            {
                cell.typeButton.on = NO;
            }
            
    
            NSURL *url = [NSURL URLWithString:user_ima];
            
            [cell.IconImage sd_setImageWithURL:url];
            
            
            if ([user_sex isEqualToString:@"1"])
            {
                cell.userImage.image = [UIImage imageNamed:@"job_man"];
            }
            else
            {
                cell.userImage.image = [UIImage imageNamed:@"job_woman"];
            }
            
        }
        
        
        
        
        
        return cell;
        
    }
    else if(indexPath.section == 1)
    {
        MineScrTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"scrcell"];
        
        cell.delegate = self;
        
        return cell;
    }
    else if (indexPath.section == 2)
    {
        MineMoneyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"moneycell"];
        
        cell.delegate = self;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    else
    {
        MineElesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"elsecell"];
        
        cell.image.image = [UIImage imageNamed:[elseIcon objectAtIndex:indexPath.section - 3]];
        
        cell.name.text = [titleArr objectAtIndex:indexPath.section - 3];
        
        //判断是否登录
        if ([user_ID isEqualToString:@"0"])
        {
            if (indexPath.section == 3)
            {
                cell.name.text = @"设置支付密码";
            }
        }
        else
        {
            //判断是否设置了密码
            NSString *pass = user_pass;
            
            if (pass.length > 0)
            {
                if (indexPath.section == 3)
                {
                    cell.name.text = @"修改支付密码";
                }
            }
            else
            {
                if (indexPath.section == 3)
                {
                    cell.name.text = @"设置支付密码";
                }
            }
        }
        
        
        
        
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return 80;
    }
    else if(indexPath.section == 1)
    {
        return 70;
    }
    else if (indexPath.section == 2)
    {
        return 60;
    }
    else
    {
        return 45;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 1;
    }
    else if(section == 2)
    {
        return 50;
    }
    else
    {
        return 10;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    self.hidesBottomBarWhenPushed = YES;
    
    if (![user_ID isEqualToString:@"0"])
    {
        if (indexPath.section == 4)
        {
            ServiceViewController *temp = [[ServiceViewController alloc] init];
            
            [self.navigationController pushViewController:temp animated:YES];
        }
        
//        else if (indexPath.section == 4)
//        {
//            FriendViewController *temp = [[FriendViewController alloc] init];
//
//            [self.navigationController pushViewController:temp animated:YES];
//        }
        else if(indexPath.section == 5)
        {
            SetViewController *temp = [[SetViewController alloc] init];
            
            temp.delegate = self;
            
            [self.navigationController pushViewController:temp animated:YES];
        }
        else if(indexPath.section == 6)
        {
            
            NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"telprompt://%@",@"15045281940"];
            
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
            
        }
        else if(indexPath.section == 3)
        {
           
            
            NSString *id_card = user_u_idcard;
            
            
            //判断是否填写了身份证号
            if (id_card.length > 0)
            {
                SetPasswordViewController *temp = [[SetPasswordViewController alloc] init];
                
                NSString *word = user_pass;
                
                if (word.length > 0)
                {
                    temp.type = 0;
                }
                else
                {
                    temp.type = 1;
                }
                
                 [self.navigationController pushViewController:temp animated:YES];
            }
            else
            {
                [SVProgressHUD showErrorWithStatus:@"请到个人信息处填写身份证号方可设置密码"];
            }
            
            
           
        }
    }
    else
    {
        LoginViewController *temp = [[LoginViewController alloc] init];
        
        temp.delegate = self;
        
        [self presentViewController:temp animated:YES completion:nil];
    }
    
    
    
    
    
    
    self.hidesBottomBarWhenPushed = NO;
    
}




- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *view = [[UIView alloc] init];
    
    if (section == 2)
    {
        UIView *backview = [[UIView alloc] init];
        
        backview.backgroundColor = [UIColor whiteColor];
        
        backview.frame = CGRectMake(0, 10, SCREEN_WIDTH, 40);
        
        [view addSubview:backview];
        
        UILabel *name = [[UILabel alloc] init];
        
        name.text = @"我的资产";
        
        name.font = [UIFont systemFontOfSize:16];
        
        name.textColor = [myselfway stringTOColor:@"0x2E84F8"];
        
        [backview addSubview:name];
        
        [name mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.top.mas_equalTo(backview).offset(10);
             make.left.mas_equalTo(backview).offset(15);
             make.height.mas_equalTo(20);
             make.width.mas_equalTo(200);
         }];

    }
    else if (section == 0)
    {
        view.backgroundColor = [myselfway stringTOColor:@"0xC4CED3"];
    }
    
    
    return view;
}

#pragma 自定义的方法

//加载头部view
- (void)initHeadView
{
    UIView *view = [[UIView alloc] init];
    
    view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:view];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.mas_equalTo(self.view).offset(0);
         make.left.mas_equalTo(self.view).offset(0);
         make.right.mas_equalTo(self.view).offset(0);
         make.height.mas_equalTo(44 + StatusBarHeigh);
     }];
    
    UILabel *headlabel = [[UILabel alloc] init];
    
    headlabel.text = @"我的";
    
    [headlabel setTextColor:[myselfway stringTOColor:@"0x2E84F8"]];
    
    headlabel.textAlignment = NSTextAlignmentCenter;
    
    headlabel.font = [UIFont boldSystemFontOfSize:17];
    
    [view addSubview:headlabel];
    
    [headlabel mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.centerX.equalTo(view);
         make.bottom.mas_equalTo(view).offset(-6);
         make.height.mas_equalTo(30);
         make.width.mas_equalTo(200);
     }];
    
}

//我的页面，收藏，评价那一栏的点击事件
- (void)tempVal: (NSInteger)val
{
    self.hidesBottomBarWhenPushed = YES;
    
    if (![user_ID isEqualToString:@"0"])
    {
        if (val == 900)
        {
            
            MineFavoriteViewController *temp = [[MineFavoriteViewController alloc] init];
            
            [self.navigationController pushViewController:temp animated:YES];
            
        }
        else if (val == 901)
        {
            EvaluateViewController *temp = [[EvaluateViewController alloc] init];
            
            [self.navigationController pushViewController:temp animated:YES];
        }
        else if (val == 902)
        {
            MineMoneyViewController *temp = [[MineMoneyViewController alloc] init];
            
            [self.navigationController pushViewController:temp animated:YES];
        }
        else
        {
            
            MineMessViewController *temp = [[MineMessViewController alloc] init];
            
            [self.navigationController pushViewController:temp animated:YES];
            
        }
    }
    else
    {
        
        LoginViewController *temp = [[LoginViewController alloc] init];
        
        temp.delegate = self;
        
        [self presentViewController:temp animated:YES completion:nil];
        
    }
    
    
    
    self.hidesBottomBarWhenPushed = NO;
}


//我的资产的点击事件代理
- (void)temMoney: (NSInteger)index
{
    self.hidesBottomBarWhenPushed = YES;
    
    
    if (![user_ID isEqualToString:@"0"])
    {
        
        if (index == 800)
        {
            packetViewController *temp = [[packetViewController alloc] init];
            
            [self.navigationController pushViewController:temp animated:YES];
            
        }
        else if (index == 801)
        {
            discountViewController *temp = [[discountViewController alloc] init];
            
            [self.navigationController pushViewController:temp animated:YES];
            
        }
        else
        {
            NSLog(@"3");
        }
        
    }
    else
    {
        LoginViewController *temp = [[LoginViewController alloc] init];
        
        temp.delegate = self;
        
        [self presentViewController:temp animated:YES completion:nil];
    }
    
    
    self.hidesBottomBarWhenPushed = NO;
}


//登录按钮
- (void)loginBtn
{
    self.hidesBottomBarWhenPushed = YES;
    
    LoginViewController *temp = [[LoginViewController alloc] init];
    
    temp.delegate = self;
    
    [self presentViewController:temp animated:YES completion:nil];
    
    self.hidesBottomBarWhenPushed = NO;
}


//切换状态
- (void)swiBtn: (UISwitch *)swi
{
    if (swi.on == YES)
    {
        NSLog(@"开");
    }
    else
    {
        NSLog(@"关");
    }
}



//登录成功的代理方法
- (void)Sussecc
{
    [self.tableview reloadData];
}



//接收通知
- (void)changePassword:(NSNotification *)notification
{
    //收到成功设置密码后， 刷新页面显示
    [self.tableview reloadData];
}



@end
