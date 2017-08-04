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
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 113) style:UITableViewStyleGrouped];
        
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
        return 70;
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
    if (val == 900)
    {
        
    }
    else if (val == 901)
    {
     
    }
    else if (val == 902)
    {
    
    }
    else
    {
        self.hidesBottomBarWhenPushed = YES;
        
        MineMessViewController *temp = [[MineMessViewController alloc] init];
        
        [self.navigationController pushViewController:temp animated:YES];
        
        self.hidesBottomBarWhenPushed = NO;
    }
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









@end
