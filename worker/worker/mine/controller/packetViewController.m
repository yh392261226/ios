//
//  packetViewController.m
//  worker
//
//  Created by sd on 2017/9/30.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "packetViewController.h"
#import "packetTableViewCell.h"

@interface AllRedPrice : NSObject

@property (nonatomic, strong)NSString *b_id;
@property (nonatomic, strong)NSString *bt_id;
@property (nonatomic, strong)NSString *bd_id;
@property (nonatomic, strong)NSString *b_start_time;
@property (nonatomic, strong)NSString *b_end_time;
@property (nonatomic, strong)NSString *b_total;
@property (nonatomic, strong)NSString *b_offset;
@property (nonatomic, strong)NSString *b_status;
@property (nonatomic, strong)NSString *b_type;
@property (nonatomic, strong)NSString *b_author;
@property (nonatomic, strong)NSString *b_last_editor;
@property (nonatomic, strong)NSString *b_in_time;
@property (nonatomic, strong)NSString *b_last_edit_time;
@property (nonatomic, strong)NSString *b_amount;
@property (nonatomic, strong)NSString *b_info;
@property (nonatomic, strong)NSString *bd_serial;
@property (nonatomic, strong)NSString *bd_author;
@property (nonatomic, strong)NSString *bd_use_time;
@property (nonatomic, strong)NSString *bt_name;
@property (nonatomic, strong)NSString *bt_info;
@property (nonatomic, strong)NSString *bt_withdraw;



@end


@implementation AllRedPrice


@end


@interface packetViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *dataArray;
}

@property (nonatomic, strong)UITableView *tableview;

@end

@implementation packetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addhead:@"我的红包"];
    
    dataArray = [NSMutableArray array];
    
    [self tableview];
    
    [self getData];
    
}


- (UITableView *)tableview
{
    if (!_tableview)
    {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 65, SCREEN_WIDTH, SCREEN_HEIGHT - 65) style:UITableViewStyleGrouped];
        
        _tableview.delegate = self;
        _tableview.dataSource = self;
        
        [_tableview registerClass:[packetTableViewCell class] forCellReuseIdentifier:@"cell"];
        
        _tableview.backgroundColor = [myselfway stringTOColor:@"0xC4CED3"];
        
        [self.view addSubview:_tableview];
        
    }
    
    return _tableview;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return  1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AllRedPrice *data = [dataArray objectAtIndex:indexPath.section];
    
    packetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.backgroundColor = [myselfway stringTOColor:@"0xC4CED3"];
    
    
    cell.drawMoney.tag = indexPath.section + 900;
    [cell.drawMoney addTarget:self action:@selector(drawBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    [cell.drawMoney setTitle:@"点击领取" forState:0];
    
    if ([data.b_status isEqualToString:@"0"])
    {
        [cell.drawMoney setTitle:@"已领取" forState:0];
    }
    
    
    
    cell.money.text = data.b_info;
    cell.text.text = data.bt_info;
    cell.time.text = [NSString stringWithFormat:@"最终使用日期截止 %@", data.b_end_time];
    
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    
    return view;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}


//领取红包的按钮
- (void)drawBtn: (id)sender
{
    UIButton *button = (UIButton *)sender;
    
    NSInteger i = button.tag - 900;
    
    AllRedPrice *info = [dataArray objectAtIndex:i];
    
    [self UserData:info.bd_id];
   
}


//使用红包
- (void)UserData: (NSString *)bd_id
{
    NSString *url = [NSString stringWithFormat:@"%@Bouns/index?bd_id=%@&uid=%@", baseUrl, bd_id, user_ID];
    
    NSLog(@"%@", url);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject)
     {
         NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         
         if ([[dictionary objectForKey:@"code"] integerValue] == 200)
         {
             
             
             
             [self.tableview reloadData];
             
             
         }
         
     } failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         
     }];
    
    
}











//获取红包列表
- (void)getData
{
    NSString *url = [NSString stringWithFormat:@"%@Bouns/index?bt_withdraw=1", baseUrl];
    
    NSLog(@"%@", url);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject)
     {
         NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         
         if ([[dictionary objectForKey:@"code"] integerValue] == 200)
         {
             NSArray *arrData = [dictionary objectForKey:@"data"];
             
             for (int i = 0; i < arrData.count; i++)
             {
                 NSDictionary *dicData = [arrData objectAtIndex:i];
                 
                 AllRedPrice *data = [[AllRedPrice alloc] init];
                 
                 data.b_id = [dicData objectForKey:@"b_id"];
                 data.bd_id = [dicData objectForKey:@"bd_id"];
                 data.bt_id = [dicData objectForKey:@"bd_id"];
                 data.b_start_time = [dicData objectForKey:@"b_start_time"];
                 data.b_end_time = [dicData objectForKey:@"b_end_time"];
                 data.b_total = [dicData objectForKey:@"b_total"];
                 data.b_offset = [dicData objectForKey:@"b_offset"];
                 data.b_status = [dicData objectForKey:@"b_status"];
                 data.b_type = [dicData objectForKey:@"b_type"];
                 data.b_author = [dicData objectForKey:@"b_author"];
                 data.b_in_time = [dicData objectForKey:@"b_in_time"];
                 data.b_last_editor = [dicData objectForKey:@"b_last_editor"];
                 data.b_last_edit_time = [dicData objectForKey:@"b_last_edit_time"];
                 data.b_info = [dicData objectForKey:@"b_info"];
                 data.b_amount = [dicData objectForKey:@"b_amount"];
                 data.bd_serial = [dicData objectForKey:@"bd_serial"];
                 data.bd_author = [dicData objectForKey:@"bd_author"];
                 data.bd_use_time = [dicData objectForKey:@"bd_use_time"];
                 data.bt_name = [dicData objectForKey:@"bt_name"];
                 data.bt_info = [dicData objectForKey:@"bt_info"];
                 data.bt_withdraw = [dicData objectForKey:@"bt_withdraw"];
                 
                 
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
