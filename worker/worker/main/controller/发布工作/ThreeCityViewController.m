//
//  ThreeCityViewController.m
//  worker
//
//  Created by 郭健 on 2017/9/25.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "ThreeCityViewController.h"


@interface threeCityData : NSObject

@property (nonatomic, strong)NSString *r_id;
@property (nonatomic, strong)NSString *r_pid;
@property (nonatomic, strong)NSString *r_shortname;
@property (nonatomic, strong)NSString *r_name;
@property (nonatomic, strong)NSString *r_first;
@property (nonatomic, strong)NSString *r_hot;
@property (nonatomic, strong)NSString *r_status;


@end

@implementation threeCityData


@end



@interface ThreeCityViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *dataArray;
    
    NSString *city_id;     //城市ID
    
    NSInteger level;   //记录点击是哪一级
    
    
    NSString *levelName1;
    NSString *levelID1;
    
    NSString *levelName2;
    NSString *levelID2;
}

@property (nonatomic, strong)UITableView *tableview;

@end

@implementation ThreeCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    city_id = @"1";
    
    level = 1;
    
    dataArray = [NSMutableArray array];
    
    [self addhead:@"城市选择"];
    
    [self getCityData:city_id];
    
}


- (UITableView *)tableview
{
    if (!_tableview)
    {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStyleGrouped];
       
        _tableview.delegate = self;
        _tableview.dataSource = self;
        
        _tableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.1)];
        _tableview.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.1)];
        
        [_tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        
        
        [self.view addSubview:_tableview];
        
    }
    
    return _tableview;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    threeCityData *data = [dataArray objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        
        UILabel *name = [[UILabel alloc] init];
        
        name.frame = CGRectMake(25, 10, 300, 30);
        name.font = [UIFont systemFontOfSize:15];
        name.text = data.r_name;
        
        [cell addSubview:name];
    }
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    threeCityData *data = [dataArray objectAtIndex:indexPath.row];
    
    
    
    
    
    if (level == 1)
    {
        [self getCityData:data.r_id];
        
        levelName1 = data.r_name;
        levelID1 = data.r_id;
        
        level++;
    }
    else if (level == 2)
    {
        [self getCityData:data.r_id];
        
        levelName2 = data.r_name;
        levelID2 = data.r_id;
        
        level++;
    }
    else if(level == 3)
    {
        //表示区列表点击
        
      
        
        [self.delegate post3Level:levelID1 city_name1:levelName1 city_id2:levelID2 city_name2:levelName2 city_id2:data.r_id city_name3:data.r_name];
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
        
    }
    
    
    
    
    
    
}


- (void)getCityData: (NSString *)city_ID
{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD showWithStatus:@"加载中..."];
    
    NSString *url = [NSString stringWithFormat:@"%@Regions/index/?action=list&r_pid=%@", baseUrl, city_ID];
    
    NSLog(@"%@", url);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject)
     {
         NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         
         if ([[dictionary objectForKey:@"code"] integerValue] == 200)
         {
             [dataArray removeAllObjects];
             
             NSArray *arr = [dictionary objectForKey:@"data"];
             
             if (arr.count == 0)
             {
                 
             }
             else
             {
                 
                 for (int i = 0 ; i < arr.count; i++)
                 {
                     NSDictionary *city = [arr objectAtIndex:i];
                     
                     threeCityData *data = [[threeCityData alloc] init];
                     
                     data.r_id = [city objectForKey:@"r_id"];
                     data.r_hot = [city objectForKey:@"r_hot"];
                     data.r_pid = [city objectForKey:@"r_pid"];
                     data.r_name = [city objectForKey:@"r_name"];
                     data.r_first = [city objectForKey:@"r_first"];
                     data.r_status = [city objectForKey:@"r_status"];
                     data.r_shortname = [city objectForKey:@"r_shortname"];
                     
                     [dataArray addObject:data];
                 }
             }
             
             [self.tableview reloadData];
             
             [SVProgressHUD dismiss];
             
             
         }
     } failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         [SVProgressHUD dismiss];
     }];
    
    
}































- (void)temp
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
