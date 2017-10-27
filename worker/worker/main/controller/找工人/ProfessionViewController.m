//
//  ProfessionViewController.m
//  worker
//
//  Created by 郭健 on 2017/7/31.
//  Copyright © 2017年 郭健. All rights reserved.


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

@property (nonatomic, strong)FMDatabaseQueue *queue;
@property (nonatomic, strong)NSString *path;    //本地数据库路径
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
    return 15;
}



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    
    return view;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    workerListData *data = [dataArray objectAtIndex:indexPath.section];
    
    self.hidesBottomBarWhenPushed = YES;
    
    WorkerMessViewController *temp = [[WorkerMessViewController alloc] init];
    
    temp.longitude = self.longitudeWor;
    temp.latitude = self.latitudeWor;
    temp.city_id = self.cityID;
    temp.worker_ID = data.s_id;
    temp.workerName = data.s_name;
    
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
             [self path];
             [self queue];
             [self createTableWithSQL];
         }
         
         
         
     } failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         //没有网络时候，获取缓存信息
//         NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//
//         NSString *workerPath = [NSString stringWithFormat:@"%@/workerPath", docPath];
//
//         NSString *userInfo = [workerPath stringByAppendingPathComponent:@"listWorker.plist"];
//         //读取文件
//         newArray = (NSMutableArray *)[NSArray arrayWithContentsOfFile:userInfo];
//
//
//         for (int i = 0; i < newArray.count; i++)
//         {
//             NSDictionary *dic = [newArray objectAtIndex:i];
//
//             workerListData *data = [[workerListData alloc] init];
//
//             data.s_id = [dic objectForKey:@"s_id"];
//             data.s_desc = [dic objectForKey:@"s_desc"];
//             data.s_info = [dic objectForKey:@"s_info"];
//             data.s_name = [dic objectForKey:@"s_name"];
//             data.s_status = [dic objectForKey:@"s_status"];
//
//             [dataArray addObject:data];
//
//         }
//
//         [self.tableview reloadData];
//
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

  //  [self creatPlistFileWithArr:newArray];

}
//
//- (void)creatPlistFileWithArr:(NSMutableArray *)array
//{
//    //将字典保存到document文件->获取appdocument路径
//    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//
//    NSFileManager *fileManager = [[NSFileManager alloc] init];
//
//    //创建工种列表的路径
//    NSString *workerPath = [NSString stringWithFormat:@"%@/workerPath", docPath];
//
//    // 判断文件夹是否存在，如果不存在，则创建
//    if (![[NSFileManager defaultManager] fileExistsAtPath:workerPath])
//    {
//        [fileManager createDirectoryAtPath:workerPath withIntermediateDirectories:YES attributes:nil error:nil];
//    }
//    else
//    {
//        // 删除旧的缓存数据
//       // [[NSFileManager defaultManager] removeItemAtPath:workerPath error:nil];
//
//
//
//
//    }
//
//
//    NSString *userInfo = [workerPath stringByAppendingPathComponent:@"listWorker.plist"];
//
//    [array writeToFile:userInfo atomically:YES];
//
//}




#pragma 本地缓存数据库

// 懒加载数据库队列
- (FMDatabaseQueue *)queue
{
    if (!_queue)
    {
        _queue = [FMDatabaseQueue databaseQueueWithPath:[Singleton instance].dataPath];
    }
    return _queue;
}


////创建表
- (BOOL)createTableWithSQL
{
    __block BOOL createSResult = NO;
    [self.queue inTransaction:^(FMDatabase * _Nonnull db, BOOL * _Nonnull rollback)
     {
         
         NSString *studentSql = @"CREATE TABLE 'worker' ('id' INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL ,'s_id' VARCHAR(255),'s_name' VARCHAR(255),'s_info' VARCHAR(255),'s_desc'VARCHAR(255),'s_status'VARCHAR(255), 's_image'VARCHAR(255)) ";

        BOOL result = [db executeUpdate:studentSql];
        if (result)
        {
            NSLog(@"创建表格成功");
            createSResult = result;

//            for (int i = 0; i < dataArray.count; i++)
//            {
//                workerListData *data = [dataArray objectAtIndex:i];
//
//                [self addStudent:data];
//            }
            
            NSLog(@"%@", [Singleton instance].dataPath);
        }
        else
        {
            NSLog(@"创建表格失败");
            createSResult = result;
        }
         
    }];
    return createSResult;
}



#pragma mark - 增删改查
//表里面增加数据
- (BOOL)addStudent:(workerListData *)info
{
    __block BOOL addResult = NO;
    [self.queue inTransaction:^(FMDatabase * _Nonnull db, BOOL * _Nonnull rollback) {

        BOOL result = [db executeUpdate:@"INSERT INTO worker(s_id,s_name,s_info,s_desc,s_status,s_image)VALUES(?,?,?,?,?,?)",info.s_id,info.s_name,info.s_info,info.s_desc,info.s_status, info.s_image];

        if (result)
        {
            NSLog(@"插入数据成功");
        }
        else
        {
            NSLog(@"插入数据失败");
        }

    }];
    return addResult;
}










- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
