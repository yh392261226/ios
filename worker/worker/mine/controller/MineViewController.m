//
//  MineViewController.m
//  worker
//
//  Created by 郭健 on 2017/8/1.
//  Copyright © 2017年 郭健. All rights reserved.


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
    
    elseIcon = [NSMutableArray arrayWithObjects:@"mine_wet",@"mine_list",@"mine_set",@"mine_call", nil];
    
    titleArr = [NSMutableArray arrayWithObjects:@"邀请好友",@"服务条款",@"设置",@"客服", nil];
    
    
    [self initHeadView];
    
    [self tableview];
    
    
}

#pragma tableview代理

- (UITableView *)tableview
{
    if (!_tableview)
    {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStyleGrouped];
        
        _tableview.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.1)];
        _tableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.1)];
        
        [_tableview registerClass:[MineLoginTableViewCell class] forCellReuseIdentifier:@"logincell"];
        [_tableview registerClass:[MineScrTableViewCell class] forCellReuseIdentifier:@"scrcell"];
        [_tableview registerClass:[MineMoneyTableViewCell class] forCellReuseIdentifier:@"moneycell"];
        [_tableview registerClass:[MineElesTableViewCell class] forCellReuseIdentifier:@"elsecell"];
        
        _tableview.backgroundColor = [myselfway stringTOColor:@"0xC4CED3"];
        
        _tableview.delegate = self;
        _tableview.dataSource = self;
        
        [self.view addSubview:_tableview];
        
        
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
        
        [cell.loginBtn addTarget:self action:@selector(loginBtn) forControlEvents:UIControlEventTouchUpInside];
        
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
        return 50;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 0.1;
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
    if (indexPath.section == 4)
    {
        ServiceViewController *temp = [[ServiceViewController alloc] init];
        
        [self.navigationController pushViewController:temp animated:YES];
    }
    
    else if (indexPath.section == 3)
    {
        //显示分享面板
//        [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo)
//        {
//            // 根据获取的platformType确定所选平台进行下一步操作
//        }];
        
        //如平台应用未安装，或平台应用不支持等会进行隐藏。 由于以上原因，在模拟器上部分平台会隐藏   ,,,  以下方法可设置平台顺序
        
        [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_Sina),@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_WechatSession)]];
        [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
            // 根据获取的platformType确定所选平台进行下一步操作
            
            NSLog(@"分享");
        }];
    }
    else if(indexPath.section == 5)
    {
        SetViewController *temp = [[SetViewController alloc] init];
        
        [self.navigationController pushViewController:temp animated:YES];
    }
    else
    {
        
        NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"telprompt://%@",@"15045281940"];
        
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
       
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
    
    
    return view;
}

#pragma 自定义的方法

//加载头部view
- (void)initHeadView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    
    view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:view];
    
    UILabel *headlabel = [[UILabel alloc] init];
    
    headlabel.text = @"我的";
    
    [headlabel setTextColor:[myselfway stringTOColor:@"0x2E84F8"]];
    
    headlabel.textAlignment = NSTextAlignmentCenter;
    
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

//我的页面，收藏，评价那一栏的点击事件
- (void)tempVal: (NSInteger)val
{
    self.hidesBottomBarWhenPushed = YES;
    
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
    
    self.hidesBottomBarWhenPushed = NO;
}


//我的资产的点击事件代理
- (void)temMoney: (NSInteger)index
{
    if (index == 800)
    {
        NSLog(@"1");
    }
    else if (index == 801)
    {
        NSLog(@"2");
    }
    else
    {
        NSLog(@"3");
    }
}


//登录按钮
- (void)loginBtn
{
    self.hidesBottomBarWhenPushed = YES;
    
    LoginViewController *temp = [[LoginViewController alloc] init];
    
    [self presentViewController:temp animated:YES completion:nil];
    
    self.hidesBottomBarWhenPushed = NO;
}






@end
