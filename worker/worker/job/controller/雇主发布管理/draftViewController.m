//
//  draftViewController.m
//  worker
//
//  Created by 郭健 on 2017/8/30.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "draftViewController.h"
#import "OneTableViewCell.h"


@interface DraftDataModel : NSObject

@property (nonatomic, strong)NSString *t_id;
@property (nonatomic, strong)NSString *t_title;
@property (nonatomic, strong)NSString *t_info;
@property (nonatomic, strong)NSString *t_amount;
@property (nonatomic, strong)NSString *t_duration;
@property (nonatomic, strong)NSString *t_edit_amount;
@property (nonatomic, strong)NSString *t_amount_edit_times;
@property (nonatomic, strong)NSString *t_posit_x;
@property (nonatomic, strong)NSString *t_posit_y;
@property (nonatomic, strong)NSString *t_author;
@property (nonatomic, strong)NSString *t_in_time;
@property (nonatomic, strong)NSString *t_last_edit_time;
@property (nonatomic, strong)NSString *t_last_editor;
@property (nonatomic, strong)NSString *t_status;
@property (nonatomic, strong)NSString *t_phone;
@property (nonatomic, strong)NSString *t_phone_status;
@property (nonatomic, strong)NSString *t_type;
@property (nonatomic, strong)NSString *t_storage;
@property (nonatomic, strong)NSString *bd_id;


@end


@implementation DraftDataModel


@end

@interface draftViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *dataArray;
}

@property (nonatomic, strong)UITableView *tableview;

@end

@implementation draftViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    dataArray = [NSMutableArray array];
    
    [self getdata];
    
    [self addhead:@"草稿箱"];
    
    [self slitherBack:self.navigationController];
    
    [self tableview];
}



#pragma tableview 代理方法

- (UITableView *)tableview
{
    if (!_tableview)
    {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStyleGrouped];
        
        [_tableview registerClass:[OneTableViewCell class] forCellReuseIdentifier:@"cell"];
        
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
    DraftDataModel *model = [dataArray objectAtIndex:indexPath.section];
    
    OneTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (!cell)
    {
        cell = [[OneTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.favoriteBtn.hidden = YES;
        cell.state.hidden = YES;
        cell.leftBtn.hidden = YES;
        cell.distance.hidden = YES;
        cell.details.hidden = YES;
        
        cell.title.text = model.t_title;
        cell.introduce.text = model.t_info;
        
        
        [cell.centerBtn setTitle:@"删除信息" forState:UIControlStateNormal];
        [cell.rightBtn setTitle:@"编辑" forState:UIControlStateNormal];
        
        [cell.centerBtn addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
        [cell.rightBtn addTarget:self action:@selector(write:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *state = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 80, 7.5, 50, 20)];
        
        state.text = @"未支付";
        state.textColor = [UIColor whiteColor];
        state.backgroundColor = [UIColor grayColor];
        state.textAlignment = NSTextAlignmentCenter;
        state.font = [UIFont systemFontOfSize:13];
        state.layer.cornerRadius = 5;
        state.layer.masksToBounds = YES;
        
        [cell addSubview:state];
        
    }
    
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 115;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
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



//编辑草稿箱信息
- (void)close: (UIButton *)btn
{
    NSLog(@"1");
}

//修改草稿箱信息
- (void)write: (UIButton *)btn
{
    NSLog(@"2");
}






//草稿箱数据网络请求
- (void)getdata
{
    NSString *url = [NSString stringWithFormat:@"%@Tasks/index?t_storage=1&t_author=%@", baseUrl, @"1"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject)
     {
         NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         
         if ([[dictionary objectForKey:@"code"] integerValue] == 200)
         {
             NSArray *tem = [dictionary objectForKey:@"data"];
             
             [dataArray removeAllObjects];
             
             for (int i = 0; i < tem.count; i++)
             {
                 NSDictionary *dic = [tem objectAtIndex:i];
                 
                 DraftDataModel *model = [[DraftDataModel alloc] init];
                 
                 model.t_id = [dic objectForKey:@"t_id"];
                 model.t_title = [dic objectForKey:@"t_title"];
                 model.t_info = [dic objectForKey:@"t_info"];
                 model.t_amount = [dic objectForKey:@"t_amount"];
                 model.t_duration = [dic objectForKey:@"t_duration"];
                 model.t_edit_amount = [dic objectForKey:@"t_edit_amount"];
                 model.t_amount_edit_times = [dic objectForKey:@"t_amount_edit_times"];
                 model.t_posit_x = [dic objectForKey:@"t_posit_x"];
                 model.t_posit_y = [dic objectForKey:@"t_posit_y"];
                 model.t_author = [dic objectForKey:@"t_author"];
                 model.t_in_time = [dic objectForKey:@"t_in_time"];
                 model.t_last_edit_time = [dic objectForKey:@"t_last_edit_time"];
                 model.t_last_editor = [dic objectForKey:@"t_last_editor"];
                 model.t_status = [dic objectForKey:@"t_status"];
                 model.t_phone = [dic objectForKey:@"t_phone"];
                 model.t_phone_status = [dic objectForKey:@"t_phone_status"];
                 model.t_type = [dic objectForKey:@"t_type"];
                 model.bd_id = [dic objectForKey:@"bd_id"];
                 
                 [dataArray addObject:model];
                 
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
