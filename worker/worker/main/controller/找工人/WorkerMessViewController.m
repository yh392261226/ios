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
#import "LoginViewController.h"


@interface ListWorData : NSObject

@property (nonatomic, strong)NSString *u_id;
@property (nonatomic, strong)NSString *u_name;
@property (nonatomic, strong)NSString *u_skills;
@property (nonatomic, strong)NSString *uei_info;
@property (nonatomic, strong)NSString *u_task_status;
@property (nonatomic, strong)NSString *u_true_name;
@property (nonatomic, strong)NSString *ucp_posit_x;
@property (nonatomic, strong)NSString *ucp_posit_y;
@property (nonatomic, strong)NSString *u_img;
@property (nonatomic, strong)NSString *is_fav;

@property (nonatomic, strong)NSString *range;    //根据经纬度计算的亮点之间距离

@end

@implementation ListWorData


@end





@interface WorkerMessViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *dataArray;
    
    NSString *name1;     //代理传回来的名称数据
    NSString *adree1;    //代理传回来的筛选范围数据
    NSString *type1;     //代理传回来的工人状态数据
    
}


@property (nonatomic, strong)UITableView *tableview;

@end

@implementation WorkerMessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    name1 = @"";
    adree1 = @"";
    type1 = @"-1";

    
    dataArray = [NSMutableArray array];
    
    
    [self getdata];
    
    [self addhead:@"工人信息"];
    
 //   [self initScreenBtn];          //筛选功能， 暂时隐藏， 已做完
    

    
    [self tableview];
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    
    //获取缓存图片的大小(字节)
    NSUInteger bytesCache = [[SDImageCache sharedImageCache] getSize];
    
    //换算成 MB (注意iOS中的字节之间的换算是1000不是1024)
    float MBCache = bytesCache/1000/1000;
    
    //异步清除图片缓存 （磁盘中的）
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        [[SDImageCache sharedImageCache] clearDisk];
    });
    
    
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
    cell.introduce.text = data.uei_info;
    cell.distance.text = data.range;
    
    
    cell.details.hidden = YES;
    
    
    if ([data.u_task_status isEqualToString:@"0"])
    {
        cell.state.image = [UIImage imageNamed:@"main_state1"];
    }
    else
    {
        cell.state.image = [UIImage imageNamed:@"main_state5"];
    }
    
    
    NSURL *url = [NSURL URLWithString:data.u_img];
    
    [cell.IconBtn sd_setImageWithURL:url];
    
    
    
    
    
    int fav = [data.is_fav intValue];
    
    if (fav == 0)
    {
        [cell.favoriteBtn setImage:[UIImage imageNamed:@"main_favoriteNO"] forState:UIControlStateNormal];
    }
    else
    {
        [cell.favoriteBtn setImage:[UIImage imageNamed:@"main_favoriteYes"] forState:UIControlStateNormal];
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
    
    ListWorData *data = [dataArray objectAtIndex:indexPath.section];
    
    AmapWorkerViewController *temp = [[AmapWorkerViewController alloc] init];
    
    temp.worker_id = data.u_id;
    temp.workerNN = self.workerName;
    temp.skills_id = self.worker_ID;
    
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
    
    temp.delegate = self;
    
    [self presentViewController:temp animated:YES completion:nil];
    
}


//cell上收藏按钮的点击
- (void)favoriteBtn: (UIButton *)btn
{
    NSInteger num = btn.tag - 500;
    
    ListWorData *data = [dataArray objectAtIndex:num];
    
    if ([user_ID isEqualToString:@"0"] || user_ID == nil)
    {
        
        self.hidesBottomBarWhenPushed = YES;
        
        LoginViewController *temp = [[LoginViewController alloc] init];
        
        [self presentViewController:temp animated:YES completion:nil];
        
        self.hidesBottomBarWhenPushed = NO;
        
    }
    else
    {
        //收藏接口
        if ([user_ID isEqualToString:data.u_id])
        {
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
            [SVProgressHUD showErrorWithStatus:@"您不能收藏自己"];
        }
        else
        {
            [self Favoritedata:data.u_id];
        }
    
        
        
    }
}


- (void)getdata
{
  //正确的，带城市id的
    
  //  NSString *url = [NSString stringWithFormat:@"%@Users/getUsers?u_skills=%@&u_name=%@&u_task_status=%@&uei_city=%@", baseUrl, self.worker_ID, name, type, self.city_id];
    
    if(name1 == NULL)
    {
        name1 = @"";
    }
    
    NSString *url;
    
    if ([user_ID isEqualToString:@"0"])
    {
        url = [NSString stringWithFormat:@"%@Users/getUsers?u_skills=%@&u_true_name=%@&u_task_status=%@", baseUrl, self.worker_ID, name1, type1];
    }
    else
    {
        url = [NSString stringWithFormat:@"%@Users/getUsers?u_skills=%@&u_true_name=%@&u_task_status=%@&fu_id=%@", baseUrl, self.worker_ID, name1, type1, user_ID];
    }
    
    
    
    NSLog(@"%@", url);
    
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
                 
                 NSDictionary *dicInfo = [arr objectAtIndex:i];
                 
                 ListWorData *data = [[ListWorData alloc] init];
                 
                 data.u_id = [dicInfo objectForKey:@"u_id"];
                 data.u_name = [dicInfo objectForKey:@"u_name"];
                 data.u_skills = [dicInfo objectForKey:@"u_skills"];
                 data.uei_info = [dicInfo objectForKey:@"uei_info"];
                 data.u_task_status = [dicInfo objectForKey:@"u_task_status"];
                 data.u_true_name = [dicInfo objectForKey:@"u_true_name"];
                 data.ucp_posit_x = [dicInfo objectForKey:@"ucp_posit_x"];
                 data.ucp_posit_y = [dicInfo objectForKey:@"ucp_posit_y"];
                 data.u_img = [dicInfo objectForKey:@"u_img"];
                 data.is_fav = [dicInfo objectForKey:@"is_fav"];
                 
                 
                 if ([user_ID isEqualToString:@"0"] || user_ID == nil)
                 {
                     data.range = @"无法获取距离";
                 }
                 else
                 {
                     
                     if ([data.ucp_posit_y isEqualToString:@"0.00000000"] || [data.ucp_posit_x isEqualToString:@"0.00000000"] || self.longitude == 0 || self.latitude == 0)
                     {
                         data.range = @"无法获取距离";
                     }
                     else
                     {
                         
                         BMKMapPoint point1 = BMKMapPointForCoordinate(CLLocationCoordinate2DMake(self.latitude ,self.longitude));
                         
                         BMKMapPoint point2 = BMKMapPointForCoordinate(CLLocationCoordinate2DMake([data.ucp_posit_y doubleValue], [data.ucp_posit_x doubleValue]));
                         
                         CLLocationDistance distance = BMKMetersBetweenMapPoints(point1,point2);
                         
                         if (distance < 1)
                         {
                             data.range = @"距离1米";
                         }
                         else if (distance < 1000)
                         {

                             data.range = [NSString stringWithFormat:@"距离%.f米", distance];
                         }
                         else
                         {
                             double Distance = distance / 1000;
                             
                             data.range = [NSString stringWithFormat:@"距离%.2f公里", Distance];
                         }
                         
                 }
                 
                 
                 
                     
                     
                     

                 }

                 
                 
                 [dataArray addObject:data];
                 
             }
             
             [self.tableview reloadData];
             
         }
     } failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         
     }];
    
    
}



//筛选条件的代理方法
- (void)dreessVal: (NSString *)name nameTy:(NSString *)type adree:(NSString *)adree
{
    name1 = name;
    type1 = type;
    adree1 = adree;
    
    [self getdata];
}






//收藏
- (void)Favoritedata: (NSString *)u_id;
{
    
    NSString *url = [NSString stringWithFormat:@"%@Users/favorateAdd?u_id=%@&f_type_id=%@&f_type=1", baseUrl, user_ID, u_id];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject)
     {
         NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         
         if ([[dictionary objectForKey:@"code"] integerValue] == 1)
         {
             NSDictionary *dic = [dictionary objectForKey:@"data"];
             
             NSString *f_id = [dic objectForKey:@"f_id"];
             
             [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
             [SVProgressHUD showSuccessWithStatus:@"收藏成功"];
             
            
             [self getdata];
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
