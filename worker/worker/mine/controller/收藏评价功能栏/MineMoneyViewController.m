//
//  MineMoneyViewController.m
//  worker
//
//  Created by 郭健 on 2017/8/15.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "MineMoneyViewController.h"
#import "ElseTableViewCell.h"
#import "MoneyDetailsViewController.h"
#import "RechargeViewController.h"
#import "DepositViewController.h"

@interface moneyData : NSObject

@property (nonatomic, strong)NSString *u_id;
@property (nonatomic, strong)NSString *uef_overage;   //钱包余额
@property (nonatomic, strong)NSString *uef_ticket;    //代金券余额
@property (nonatomic, strong)NSString *uef_envelope;  //红包余额


@end

@implementation moneyData


@end


@interface MineMoneyViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *dataArray;
 
    moneyData *info;    //网络请求数据类
}

@property (nonatomic, strong)UITableView *tableview;

@end

@implementation MineMoneyViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    dataArray = [NSMutableArray arrayWithObjects:@"立即充值", @"我要提现",  nil];
    
    [self getdata];
    
    [self addhead:@"我的钱包"];
    
    [self initDraft];
    
    [self slitherBack:self.navigationController];
    
    [self tableview];
    
}


#pragma tableview 代理方法

- (UITableView *)tableview
{
    if (!_tableview)
    {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStyleGrouped];
        
        [_tableview registerClass:[ElseTableViewCell class] forCellReuseIdentifier:@"elseCell"];
        
        [_tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        
        _tableview.backgroundColor = [myselfway stringTOColor:@"0xC4CED3"];
        
        _tableview.delegate = self;
        _tableview.dataSource = self;
        
        [self.view addSubview:_tableview];
    }
    
    return _tableview;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(20, 30, 200, 30)];
        title.text = @"当前余额(元)";
        title.textColor = [UIColor redColor];
        title.font = [UIFont systemFontOfSize:16];
        [cell addSubview:title];
        
        
        UILabel *qian = [[UILabel alloc] init];
        qian.textColor = [UIColor redColor];
        qian.text = @"￥";
        qian.font = [UIFont systemFontOfSize:30];
        [cell addSubview:qian];
        [qian mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.top.mas_equalTo(title).offset(60);
             make.left.mas_equalTo(cell).offset(10);
             make.width.mas_equalTo(30);
             make.height.mas_equalTo(40);
         }];
        
        
        UILabel *money = [[UILabel alloc] init];
        money.text = info.uef_overage;
        money.font = [UIFont systemFontOfSize:30];
        money.textColor = [UIColor redColor];
        [cell addSubview:money];
        
        [money mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.top.mas_equalTo(title).offset(60);
            make.left.mas_equalTo(cell).offset(40);
            make.width.mas_equalTo(200);
            make.height.mas_equalTo(40);
        }];
        
        return cell;
    }
    else
    {
        ElseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"elseCell"];
        
        cell.title.text = [dataArray objectAtIndex:indexPath.section - 1];
        
        
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return 170;
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
        return 10;
    }
    else
    {
        return 15;
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
    
    if (indexPath.section == 1)
    {
        RechargeViewController *temp = [[RechargeViewController alloc] init];
        
        temp.delegate = self;
        
        [self.navigationController pushViewController:temp animated:YES];
    }
    else if (indexPath.section == 2)
    {
        DepositViewController *temp = [[DepositViewController alloc] init];
        
        [self.navigationController pushViewController:temp animated:YES];
    }
}


//代理回调， 刷新余额
- (void)tempVaalllllll
{
    [self getdata];
}



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    
    return view;
}

#pragma 自己定义的方法

//加载明细按钮
- (void)initDraft
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    
    [button setTitle:@"明细" forState:0];
    
    [button addTarget:self action:@selector(Draft) forControlEvents:UIControlEventTouchUpInside];
    
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    
    [button setTitleColor:[myselfway stringTOColor:@"0x2E84F8"] forState:UIControlStateNormal];
    
    [self.view addSubview:button];
    
    
    [button mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.mas_equalTo(self.view).offset(27.5);
         make.right.mas_equalTo(self.view).offset(-13);
         make.height.mas_equalTo(30);
         make.width.mas_equalTo(50);
     }];
    
}


//明细按钮的点击事件

- (void)Draft
{
    self.hidesBottomBarWhenPushed = YES;
    
    MoneyDetailsViewController *temp = [[MoneyDetailsViewController alloc] init];
    
    [self.navigationController pushViewController:temp animated:YES];
}





- (void)getdata
{
    
    NSString *url = [NSString stringWithFormat:@"%@Users/usersFunds?u_id=%@", baseUrl, user_ID];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject)
     {
         NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         
         if ([[dictionary objectForKey:@"code"] integerValue] == 1)
         {
             NSDictionary *tem = [dictionary objectForKey:@"data"];
             
             NSDictionary *dic = [tem objectForKey:@"data"];
             
             info = [[moneyData alloc] init];
             
             info.uef_overage = [dic objectForKey:@"uef_overage"];
             info.uef_ticket = [dic objectForKey:@"uef_ticket"];
             info.uef_envelope = [dic objectForKey:@"uef_envelope"];
             
             [self.tableview reloadData];
             
         }
         
         
         
     } failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         
     }];
    
    
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
