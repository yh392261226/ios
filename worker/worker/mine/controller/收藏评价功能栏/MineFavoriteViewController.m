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
@property (nonatomic, strong)NSString *uei_info;
@property (nonatomic, strong)NSString *u_name;
@property (nonatomic, strong)NSString *u_img;
@property (nonatomic, strong)NSString *u_task_status;
@property (nonatomic, strong)NSString *ucp_posit_x;
@property (nonatomic, strong)NSString *ucp_posit_y;
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
@property (nonatomic, strong)NSString *u_img;
@property (nonatomic, strong)NSString *f_id;

@end

@implementation workerFavoData


@end

@interface MineFavoriteViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *dataArray;    //收藏的人
    NSMutableArray *workerArray;  //收藏的工作
    
    TypeView *typeView;  //上面选择类型的view
    
    NSMutableArray *nameArr;   //类型上的view名字数组,传给自定义view
    
    NSInteger typeOr;   //判断是收藏工人， 还是收藏工作
}


@property (nonatomic, strong)UITableView *tableview;

@end

@implementation MineFavoriteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    dataArray = [NSMutableArray array];
    workerArray = [NSMutableArray array];
    
    typeOr = 1;
    
    [self getWorkerdata];
    
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
    if (typeOr == 0)
    {
        return dataArray.count;
    }
    else
    {
        return workerArray.count;
    }
    
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (typeOr == 1)
    {
        workerFavoData *data = [workerArray objectAtIndex:indexPath.section];
        
        WorkerMessTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        if (!cell)
        {
            cell = [[WorkerMessTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
            
            cell.state.hidden = YES;
            
            cell.distance.hidden = YES;
            
            cell.introduce.hidden = YES;
            
            [cell.favoriteBtn addTarget:self action:@selector(favoriteBtn:) forControlEvents:UIControlEventTouchUpInside];
            
            [cell.favoriteBtn setImage:[UIImage imageNamed:@"main_favoriteYes"] forState:UIControlStateNormal];
            
            cell.favoriteBtn.tag = 300 + indexPath.section;
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            
            NSURL *url = [NSURL URLWithString:data.u_img];
            
            [cell.IconBtn sd_setImageWithURL:url];
            
            cell.title.text = data.t_title;
            cell.details.text = [NSString stringWithFormat:@"%@ 元/天", data.t_amount];
            
            cell.introduce.text = data.t_duration;
            
        }
        
        
        return cell;
    }
    else
    {
        
        favoriteData *data = [dataArray objectAtIndex:indexPath.section];
        
        WorkerMessTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        if (!cell)
        {
            cell = [[WorkerMessTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
            
            cell.state.hidden = YES;
            
            cell.distance.hidden = YES;
            
            cell.introduce.hidden = YES;
            
            [cell.favoriteBtn setImage:[UIImage imageNamed:@"main_favoriteYes"] forState:UIControlStateNormal];
            
            [cell.favoriteBtn addTarget:self action:@selector(favoriteBtn:) forControlEvents:UIControlEventTouchUpInside];
            
            cell.favoriteBtn.tag = 300 + indexPath.section;
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            
            NSURL *url = [NSURL URLWithString:data.u_img];
            
            [cell.IconBtn sd_setImageWithURL:url];
            
            cell.title.text = data.u_name;
            cell.details.text = data.uei_info;
            
        }
        
        return cell;
    }
    
    
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
        typeOr = 1;   //状态
        
        [self getWorkerdata];
        
        
    }
    else
    {
        
        typeOr = 0;
        
        [self getdata];
        
        
    }
}


#pragma 自己的方法



//收藏按钮点击
- (void)favoriteBtn: (UIButton *)btn
{
    NSInteger num = btn.tag - 300;
    
    
    
    if (typeOr == 1)
    {
        //收藏的工作
        workerFavoData *data = [workerArray objectAtIndex:num];
        
        [self NoFavoriteData:data.f_id];
        
    }
    else
    {
        //收藏的工人
        favoriteData *info = [dataArray objectAtIndex:num];
        
        [self NoFavoriteData:info.f_id];
    }
    
    
}



//收藏的工人
- (void)getdata
{
    
    NSString *url = [NSString stringWithFormat:@"%@Users/favorateUsers?u_id=%@", baseUrl, user_ID];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject)
     {
         NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         
         if ([[dictionary objectForKey:@"code"] integerValue] == 1)
         {
             [dataArray removeAllObjects];
             
             NSDictionary *dic = [dictionary objectForKey:@"data"];
             
             NSArray *otherArr = [dic objectForKey:@"data"];
             
             for (int i = 0; i < otherArr.count; i++)
             {
                 NSDictionary *dic = [otherArr objectAtIndex:i];
                 
                 favoriteData *data = [[favoriteData alloc] init];
                 
                 data.u_id = [dic objectForKey:@"u_id"];
                 data.u_sex = [dic objectForKey:@"u_sex"];
                 data.uei_info = [dic objectForKey:@"uei_info"];
                 data.u_name = [dic objectForKey:@"u_name"];
                 data.u_img = [dic objectForKey:@"u_img"];
                 data.u_task_status = [dic objectForKey:@"u_task_status"];
                 data.ucp_posit_x = [dic objectForKey:@"ucp_posit_x"];
                 data.ucp_posit_y = [dic objectForKey:@"ucp_posit_y"];
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
                 data.u_img = [dic objectForKey:@"u_img"];
                 data.f_id = [dic objectForKey:@"f_id"];
                 
                 [workerArray addObject:data];
             }
             
             
             
             [self.tableview reloadData];
             
             
             
         }
         
         
         
     } failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         
     }];
    
    
}



//取消收藏
- (void)NoFavoriteData: (NSString *)f_id
{
    
    NSString *url = [NSString stringWithFormat:@"%@Users/favorateDel?f_id=%@", baseUrl, f_id];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject)
     {
         NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         
         if ([[dictionary objectForKey:@"code"] integerValue] == 1)
         {
             NSDictionary *dic = [dictionary objectForKey:@"data"];
             [SVProgressHUD setForegroundColor:[UIColor blackColor]];
             [SVProgressHUD showSuccessWithStatus:[dic objectForKey:@"msg"]];
             
             
             if (typeOr == 1)
             {
                 [self getWorkerdata];
             }
             else
             {
                 [self getdata];
             }
             
             
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
