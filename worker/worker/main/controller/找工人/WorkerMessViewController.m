//
//  WorkerMessViewController.m
//  worker
//
//  Created by 郭健 on 2017/8/2.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "WorkerMessViewController.h"
#import "WorkerMessTableViewCell.h"
#import "DressingViewController.h"
#import "AmapWorkerViewController.h"


@interface ListWorData : NSObject

@property (nonatomic, strong)NSString *u_id;
@property (nonatomic, strong)NSString *u_skills;
@property (nonatomic, strong)NSString *uei_info;
@property (nonatomic, strong)NSString *u_task_status;
@property (nonatomic, strong)NSString *u_true_name;
@property (nonatomic, strong)NSString *u_img;
@property (nonatomic, strong)NSString *distance;

@end

@implementation ListWorData


@end





@interface WorkerMessViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *dataArray;
}


@property (nonatomic, strong)UITableView *tableview;

@end

@implementation WorkerMessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    dataArray = [NSMutableArray array];
    
    
    [self getdata];
    
    [self addhead:@"工人信息"];
    
    [self initScreenBtn];
    
 //   [self slitherBack:self.navigationController];
    
    
    
    [self tableview];
    
}




#pragma Tableview

- (UITableView *)tableview
{
    if (!_tableview)
    {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
        
        [_tableview registerClass:[WorkerMessTableViewCell class] forCellReuseIdentifier:@"cell"];
        
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
    ListWorData *data = [dataArray objectAtIndex:indexPath.section];
    
    WorkerMessTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.favoriteBtn.tag = 500 + indexPath.section;
    
    cell.title.text = data.u_true_name;
    cell.details.text = data.uei_info;
    
    
    if ([data.u_task_status isEqualToString:@"0"])
    {
        cell.state.image = [UIImage imageNamed:@"main_state1"];
    }
    else if ([data.u_task_status isEqualToString:@"1"])
    {
        cell.state.image = [UIImage imageNamed:@"main_state3"];
    }
    else
    {
        cell.state.image = [UIImage imageNamed:@"main_state5"];
    }
    
    
    
    [cell.favoriteBtn addTarget:self action:@selector(favoriteBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}





- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    
    return view;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    self.hidesBottomBarWhenPushed = YES;
    
    AmapWorkerViewController *temp = [[AmapWorkerViewController alloc] init];
    
    [self.navigationController pushViewController:temp animated:YES];
    
    
}


#pragma 自己的方法

//添加筛选按钮
- (void)initScreenBtn
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    button.frame = CGRectMake(SCREEN_WIDTH - 35, 33, 20, 20);
    
    [button addTarget:self action:@selector(screenBtn) forControlEvents:UIControlEventTouchUpInside];
    
    [button setBackgroundImage:[UIImage imageNamed:@"main_screen"] forState:UIControlStateNormal];
    
    [self.view addSubview:button];
    
}


//筛选按钮的点击事件
- (void)screenBtn
{
    self.hidesBottomBarWhenPushed = YES;
    
    DressingViewController *temp = [[DressingViewController alloc] init];
    
    [self presentViewController:temp animated:YES completion:nil];
    
}


//cell上收藏按钮的点击
- (void)favoriteBtn: (UIButton *)btn
{
    NSLog(@"%ld", btn.tag);
}


- (void)getdata
{
    //[SVProgressHUD showWithStatus:@"加载中..."];
    
    NSString *url = [NSString stringWithFormat:@"%@Users/getUsersBySkills?s_id=%@&users_posit_x=%f&users_posit_y=%f", baseUrl, self.worker_ID, self.longitude, self.latitude];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject)
     {
         NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         
         if ([[dictionary objectForKey:@"code"] integerValue] == 1)
         {
             NSDictionary *dic = [dictionary objectForKey:@"data"];
             
             NSArray *arr = [dic objectForKey:@"data"];
             
             for (int i = 0; i < arr.count; i++)
             {
                 NSDictionary *dicInfo = [arr objectAtIndex:i];
                 ListWorData *data = [[ListWorData alloc] init];
                 
                 data.u_id = [dicInfo objectForKey:@"u_id"];
                 data.u_skills = [dicInfo objectForKey:@"u_skills"];
                 data.uei_info = [dicInfo objectForKey:@"uei_info"];
                 data.u_task_status = [dicInfo objectForKey:@"u_task_status"];
                 data.u_true_name = [dicInfo objectForKey:@"u_true_name"];
                 data.u_img = [dicInfo objectForKey:@"u_img"];
                 data.distance = [dicInfo objectForKey:@"distance"];
                 
                 [dataArray addObject:data];
             }
             
             [self.tableview reloadData];
             
         }
     } failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         
     }];
    
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
