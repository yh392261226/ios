//
//  ProfessionViewController.m
//  worker
//
//  Created by 郭健 on 2017/7/31.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "ProfessionViewController.h"
#import "ProfessionTableViewCell.h"
#import "WorkerMessViewController.h"
#import "workerModel.h"


@interface workerListData : NSObject

@property (nonatomic, strong)NSString *s_id;
@property (nonatomic, strong)NSString *s_name;
@property (nonatomic, strong)NSString *s_info;
@property (nonatomic, strong)NSString *s_desc;
@property (nonatomic, strong)NSString *s_status;


@property (nonatomic, strong)NSString *s_image;


@end

@implementation workerListData


@end


@interface ProfessionViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *dataArray;    //页面使用的数据数组
    
    NSMutableArray *newArray;   //存入本地的数组
}


@property (nonatomic, strong)UITableView *tableview;

@end

@implementation ProfessionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    dataArray = [NSMutableArray array];
    
    newArray = [NSMutableArray array];
    
    [self getdata];
    
    [self addhead:@"选择工种"];
    
    [self tableview];
    
}



#pragma Tableview

- (UITableView *)tableview
{
    if (!_tableview)
    {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
        
        [_tableview registerClass:[ProfessionTableViewCell class] forCellReuseIdentifier:@"cell"];
        
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
    workerListData *info = [dataArray objectAtIndex:indexPath.section];
    
    
    ProfessionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.worker.text = info.s_name;
    
    NSURL *url = [NSURL URLWithString:info.s_image];
    
    [cell.logoImage sd_setImageWithURL:url];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    self.hidesBottomBarWhenPushed = YES;
    
    WorkerMessViewController *temp = [[WorkerMessViewController alloc] init];
    
    [self.navigationController pushViewController:temp animated:YES];
    
    
}







- (void)getdata
{
    
    NSString *url = [NSString stringWithFormat:@"%@%@", baseUrl, @"Skills/index"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject)
     {
         NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         
         if ([[dictionary objectForKey:@"code"] integerValue] == 200)
         {
             NSArray *arr = [dictionary objectForKey:@"data"];
             
             for (int i = 0; i < arr.count; i++)
             {
                 NSDictionary *dic = [arr objectAtIndex:i];
                 
                 workerListData *data = [[workerListData alloc] init];
                 
                 data.s_id = [dic objectForKey:@"s_id"];
                 data.s_desc = [dic objectForKey:@"s_desc"];
                 data.s_info = [dic objectForKey:@"s_info"];
                 data.s_name = [dic objectForKey:@"s_name"];
                 data.s_status = [dic objectForKey:@"s_status"];
                 
                 [dataArray addObject:data];
                 
                 
             }
             
             
             
             [self addImage:dataArray];
             
             
             [self.tableview reloadData];
         }
         
         
         
     } failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         //没有网络时候，获取缓存信息
         NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
         
         NSString *workerPath = [NSString stringWithFormat:@"%@/workerPath", docPath];
         
         NSString *userInfo = [workerPath stringByAppendingPathComponent:@"listWorker.plist"];
         //读取文件
         newArray = (NSMutableArray *)[NSArray arrayWithContentsOfFile:userInfo];

         
         for (int i = 0; i < newArray.count; i++)
         {
             NSDictionary *dic = [newArray objectAtIndex:i];
             
             workerListData *data = [[workerListData alloc] init];
             
             data.s_id = [dic objectForKey:@"s_id"];
             data.s_desc = [dic objectForKey:@"s_desc"];
             data.s_info = [dic objectForKey:@"s_info"];
             data.s_name = [dic objectForKey:@"s_name"];
             data.s_status = [dic objectForKey:@"s_status"];
             
             [dataArray addObject:data];
             
         }
         
         [self.tableview reloadData];
         
     }];
    
    
}




//获取工种图片
- (void)addImage: (NSMutableArray *)IDimage;
{
    for (int i = 0; i < IDimage.count; i++)
    {
        workerListData *data = [IDimage objectAtIndex:i];
        
        NSString *IDwor = data.s_id;
        
        data.s_image = [NSString stringWithFormat:@"http://static.gangjianwang.com/images/skills/%@.png", IDwor];
    }
 
    [newArray removeAllObjects];
    
    for (int i = 0; i < dataArray.count; i++)
    {
        workerListData *data = [dataArray objectAtIndex:i];
        
        NSDictionary *dic = [myselfway entityToDictionary:data];
        
        [newArray addObject:dic];
    }
    
    [self creatPlistFileWithArr:newArray];
    
}

- (void)creatPlistFileWithArr:(NSArray *)array
{
    //将字典保存到document文件->获取appdocument路径
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    
    //创建工种列表的路径
    NSString *workerPath = [NSString stringWithFormat:@"%@/workerPath", docPath];
    
    // 判断文件夹是否存在，如果不存在，则创建
    if (![[NSFileManager defaultManager] fileExistsAtPath:workerPath])
    {
        [fileManager createDirectoryAtPath:workerPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    else
    {
        
    }

    NSString *userInfo = [workerPath stringByAppendingPathComponent:@"listWorker.plist"];
    
    [array writeToFile:userInfo atomically:YES];
    

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
