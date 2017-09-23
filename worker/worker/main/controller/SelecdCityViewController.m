//
//  SelecdCityViewController.m
//  worker
//
//  Created by 郭健 on 2017/7/28.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "SelecdCityViewController.h"

@interface cityData : NSObject

@property (nonatomic, strong)NSString *r_id;
@property (nonatomic, strong)NSString *r_pid;
@property (nonatomic, strong)NSString *r_shortname;
@property (nonatomic, strong)NSString *r_name;
@property (nonatomic, strong)NSString *r_first;
@property (nonatomic, strong)NSString *r_hot;
@property (nonatomic, strong)NSString *r_status;


@end

@implementation cityData


@end



@interface SelecdCityViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *dataArray;
    
    NSMutableArray *EnglishArray;   //存放字母的数组
}

@property (nonatomic, strong)UITableView *tableview;

@end

@implementation SelecdCityViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.navigationController.navigationBarHidden = YES;
    
    dataArray = [NSMutableArray array];
    EnglishArray = [NSMutableArray array];
    
    [self addhead:@"城市选择"];
    
    [self slitherBack:self.navigationController];
    
    
    [self hotdata];
    
    
    
    [self tableview];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return dataArray.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *arr = [dataArray objectAtIndex:section];
    
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    NSArray *arr = [dataArray objectAtIndex:indexPath.section];
    
    cityData *data = [arr objectAtIndex:indexPath.row];
    
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


- (UITableView *)tableview
{
    if (!_tableview)
    {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStyleGrouped];
        
        
        //索引
        _tableview.allowsSelection = YES;
        
        _tableview.showsHorizontalScrollIndicator = NO;
        _tableview.showsVerticalScrollIndicator = NO;
        _tableview.allowsSelection = YES;
        _tableview.sectionIndexColor = [myselfway stringTOColor:@"0x2E84F8"];
        
        
        
        
        _tableview.delegate = self;
        _tableview.dataSource = self;
        
        [_tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        
        
        [self.view addSubview:_tableview];
        
    }
    
    return _tableview;
    
}

//添加索引列
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView

{
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        return nil;
    }
    
    NSMutableArray *listArray = [NSMutableArray array];
    
    for (int i = 0; i < EnglishArray.count; i++)
    {
        NSString *str = [EnglishArray objectAtIndex:i];
        
        if (i == 0)
        {
            [listArray addObject:@"#"];
        }
        else
        {
            [listArray addObject:str];
        }
    }
    
    return listArray;
}

//索引列点击事件
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index

{
    //点击索引，列表跳转到对应索引的行
    
    [tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
    //弹出首字母提示
    
    //    [gangjTowst showWithText:title];
    
    return index;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 95;
    }
    else
    {
        return 30;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    
    if (section == 0)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        
        button.frame = CGRectMake(0, 15, SCREEN_WIDTH, 50);
        
        button.backgroundColor = [UIColor whiteColor];
        
        [button addTarget:self action:@selector(currentAdree) forControlEvents:UIControlEventTouchUpInside];
        
        [view addSubview:button];
        
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(23, 10, 200, 30);
        label.text = @"当前定位城市:   哈尔滨市";
        label.font = [UIFont systemFontOfSize:15];
        
        [button addSubview:label];
        
    }
    
    UILabel *name = [[UILabel alloc] init];
    name.textColor = [UIColor grayColor];
    name.font = [UIFont systemFontOfSize:15];
    name.text = [EnglishArray objectAtIndex:section];
    
    [view addSubview:name];
    
    [name mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.bottom.mas_equalTo(view).offset(-5);
        make.left.mas_equalTo(view).offset(20);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(20);
    }];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    
    return view;
    
}

- (void)getdata
{
    
    NSString *url = [NSString stringWithFormat:@"%@%@", baseUrl, @"Regions/index?action=letter"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject)
    {
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        if ([[dictionary objectForKey:@"code"] integerValue] == 200)
        {
            NSDictionary *tem = [dictionary objectForKey:@"data"];
            
            NSMutableArray *allkey = (NSMutableArray *)[tem allKeys];
            
            //数组排序
            NSArray *sortResultArr = [allkey sortedArrayUsingSelector:@selector(compare:)];
            
            
            //制作所有head头的数组
            for (int k = 0; k < sortResultArr.count; k++)
            {
                NSString *str = [sortResultArr objectAtIndex:k];
                
                [EnglishArray addObject:str];
            }
            
            NSLog(@"%@", EnglishArray);
            
            
            
            for (int i = 0; i < sortResultArr.count; i++)
            {
                NSArray *arr = [tem objectForKey:[sortResultArr objectAtIndex:i]];
                
                NSMutableArray *cityA = [NSMutableArray array];
                
                for (int j = 0; j < arr.count; j++)
                {
                    NSDictionary *dic = [arr objectAtIndex:j];
                    

                    cityData *data = [[cityData alloc] init];
                    
                    data.r_id = [dic objectForKey:@"r_id"];
                    data.r_hot = [dic objectForKey:@"r_hot"];
                    data.r_pid = [dic objectForKey:@"r_pid"];
                    data.r_name = [dic objectForKey:@"r_name"];
                    data.r_first = [dic objectForKey:@"r_first"];
                    data.r_status = [dic objectForKey:@"r_status"];
                    data.r_shortname = [dic objectForKey:@"r_shortname"];
                    
                    
                    [cityA addObject:data];
                }
                
                [dataArray addObject:cityA];
            }
            
            [self.tableview reloadData];
  
            [SVProgressHUD dismiss];
        }
        
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error)
     {
        
    }];
    
    
}








- (void)hotdata
{
    [SVProgressHUD showWithStatus:@"加载中..."];
    
    NSString *url = [NSString stringWithFormat:@"%@%@", baseUrl, @"Regions/index?action=hot"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject)
     {
         NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         
         if ([[dictionary objectForKey:@"code"] integerValue] == 200)
         {
             NSArray *tem = [dictionary objectForKey:@"data"];
             
             NSMutableArray *cityHot = [NSMutableArray array];
             
             [EnglishArray addObject:@"热门城市"];
             
             for (int i = 0; i < tem.count; i++)
             {
                 NSDictionary *dic = [tem objectAtIndex:i];
                 
                 cityData *data = [[cityData alloc] init];
                 
                 data.r_id = [dic objectForKey:@"r_id"];
                 data.r_hot = [dic objectForKey:@"r_hot"];
                 data.r_pid = [dic objectForKey:@"r_pid"];
                 data.r_name = [dic objectForKey:@"r_name"];
                 data.r_first = [dic objectForKey:@"r_first"];
                 data.r_status = [dic objectForKey:@"r_status"];
                 data.r_shortname = [dic objectForKey:@"r_shortname"];
                 
                 [cityHot addObject:data];
                 
             }
             
             [dataArray addObject:cityHot];
         
             [self getdata];
         }
     } failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         
     }];
    
    
}


//当前位置按钮的点击
- (void)currentAdree
{
    NSLog(@"当前");
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
