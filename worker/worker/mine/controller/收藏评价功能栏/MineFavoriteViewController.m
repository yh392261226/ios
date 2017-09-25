//
//  MineFavoriteViewController.m
//  worker
//
//  Created by 郭健 on 2017/8/14.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "MineFavoriteViewController.h"
#import "TypeView.h"
#import "WorkerMessTableViewCell.h"


@interface favoriteData : NSObject

@property (nonatomic, strong)NSString *u_id;
@property (nonatomic, strong)NSString *u_sex;
@property (nonatomic, strong)NSString *u_online;
@property (nonatomic, strong)NSString *u_start;
@property (nonatomic, strong)NSString *u_worked_num;
@property (nonatomic, strong)NSString *f_id;


@end

@implementation favoriteData


@end

@interface workerFavoData : NSObject

@property (nonatomic, strong)NSString *t_title;
@property (nonatomic, strong)NSString *t_amount;
@property (nonatomic, strong)NSString *t_duration;
@property (nonatomic, strong)NSString *t_author;
@property (nonatomic, strong)NSString *t_status;


@end

@implementation workerFavoData


@end

@interface MineFavoriteViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *dataArray;    //收藏的人
    NSMutableArray *workerArray;  //收藏的工作
    
    TypeView *typeView;  //上面选择类型的view
    
    NSMutableArray *nameArr;   //类型上的view名字数组,传给自定义view
    
    NSInteger type;   //判断是收藏工人， 还是收藏工作
}


@property (nonatomic, strong)UITableView *tableview;

@end

@implementation MineFavoriteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    dataArray = [NSMutableArray array];
    workerArray = [NSMutableArray array];
    type = 0;
    
    [self getdata];
    
    nameArr = [NSMutableArray arrayWithObjects:@"收藏的工作", @"收藏的工人", nil];
    
    
    [self addhead:@"我的收藏"];
    
    [self slitherBack:self.navigationController];
    
    [self tableview];
    
    [self initTypeView];
    
}


#pragma tableview 代理方法

- (UITableView *)tableview
{
    if (!_tableview)
    {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 104, SCREEN_WIDTH, SCREEN_HEIGHT - 104) style:UITableViewStyleGrouped];
        
        [_tableview registerClass:[WorkerMessTableViewCell class] forCellReuseIdentifier:@"cell"];
        
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
    
    WorkerMessTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    [cell.favoriteBtn addTarget:self action:@selector(favoriteBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.favoriteBtn.tag = 300 + indexPath.section;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
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

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    
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

#pragma type的view
- (void)initTypeView
{
    self.view.backgroundColor = [myselfway stringTOColor:@"0xC4CED3"];
    
    typeView = [[TypeView alloc] initWithFrame:CGRectMake(0, 69, SCREEN_WIDTH, 40)];
    
    typeView.delegate = self;
    
    typeView.backgroundColor = [UIColor whiteColor];
    
    typeView.nameArray = nameArr;
    
    [self.view addSubview:typeView];
    
}


//上面选择栏点击事件的代理方法
- (void)tempVal: (NSInteger)type
{
    NSInteger i = type - 500;
    
    if (i == 0)
    {
        type = 0;   //状态
        
        [self getdata];
    }
    else
    {
        type = 1;
        
        [self getWorkerdata];
    }
}


#pragma 自己的方法



//收藏按钮点击
- (void)favoriteBtn: (UIButton *)btn
{
    NSLog(@"%ld", btn.tag);
}



//收藏的工人
- (void)getdata
{
    NSString *url = [NSString stringWithFormat:@"%@Users_favorate/tasks?u_id=%@", baseUrl, user_ID];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject)
     {
         NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         
         if ([[dictionary objectForKey:@"code"] integerValue] == 1)
         {
             [dataArray removeAllObjects];
             
             NSDictionary *dic = [dictionary objectForKey:@"data"];
             
             NSArray *arr = [dic objectForKey:@"data"];
             
             for (int i = 0; i < arr.count; i++)
             {
                 NSDictionary *dic = [arr objectAtIndex:i];
                 
                 favoriteData *data = [[favoriteData alloc] init];
                 
                 data.u_id = [dic objectForKey:@"u_id"];
                 data.u_sex = [dic objectForKey:@"u_sex"];
                 data.u_start = [dic objectForKey:@"u_start"];
                 data.u_online = [dic objectForKey:@"u_online"];
                 data.u_worked_num = [dic objectForKey:@"u_worked_num"];
                 data.f_id = [dic objectForKey:@"f_id"];
                 
                 [dataArray addObject:data];
             }
             
             [self.tableview reloadData];
             
             
             
         }
         
         
         
     } failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         
     }];
    
    
}



//收藏的工作
- (void)getWorkerdata
{
    
    NSString *url = [NSString stringWithFormat:@"%@Users/favorateTasks?u_id=%@", baseUrl, user_ID];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject)
     {
         NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         
         if ([[dictionary objectForKey:@"code"] integerValue] == 1)
         {
             [workerArray removeAllObjects];
             
             NSDictionary *dic = [dictionary objectForKey:@"data"];
             
             NSArray *arr = [dic objectForKey:@"data"];
             
             for (int i = 0; i < arr.count; i++)
             {
                 NSDictionary *dic = [arr objectAtIndex:i];
                 
                 workerFavoData *data = [[workerFavoData alloc] init];
                 
                 data.t_title = [dic objectForKey:@"t_title"];
                 data.t_amount = [dic objectForKey:@"t_amount"];
                 data.t_author = [dic objectForKey:@"t_author"];
                 data.t_status = [dic objectForKey:@"t_status"];
                 data.t_duration = [dic objectForKey:@"t_duration"];
                 
                 [workerArray addObject:data];
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
