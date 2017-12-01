//
//  WorkerProjectViewController.m
//  worker
//
//  Created by 郭健 on 2017/9/12.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "WorkerProjectViewController.h"
#import "WorkerProTableViewCell.h"
#import "AmapWorkerViewController.h"

#import "BYesOrNoViewController.h"

@interface jobProjectData : NSObject

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
@property (nonatomic, strong)NSString *t_desc;

@property (nonatomic, strong)NSString *tew_id;
@property (nonatomic, strong)NSString *tew_skills;
@property (nonatomic, strong)NSString *tew_worker_num;
@property (nonatomic, strong)NSString *tew_price;
@property (nonatomic, strong)NSString *tew_start_time;
@property (nonatomic, strong)NSString *tew_end_time;
@property (nonatomic, strong)NSString *r_province;
@property (nonatomic, strong)NSString *r_city;
@property (nonatomic, strong)NSString *r_area;
@property (nonatomic, strong)NSString *tew_address;
@property (nonatomic, strong)NSString *tew_lock;
@property (nonatomic, strong)NSNumber *favorate;
@property (nonatomic, strong)NSString *u_img;


@end



@implementation jobProjectData


@end


@interface WorkerProjectViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    
    
    NSMutableArray *renwuArray;
    
}

@property (nonatomic, strong)UITableView *tableview;

@end

@implementation WorkerProjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    renwuArray = [NSMutableArray array];
   
    
    [self addhead:@"选择招工项目"];
    
    NSLog(@"%@", self.dataArray);
    [self tableview];
}


- (void)temp
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//懒加载
- (UITableView *)tableview
{
    if (!_tableview)
    {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStyleGrouped];
        
        _tableview.delegate = self;
        _tableview.dataSource = self;
        
        _tableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.1)];
        _tableview.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.1)];
        
        _tableview.backgroundColor = [myselfway stringTOColor:@"0xC4CED3"];
        
        [_tableview registerClass:[WorkerProTableViewCell class] forCellReuseIdentifier:@"cell"];
        
        [self.view addSubview:_tableview];
    }
    
    return _tableview;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArray.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    missionData *info = [self.dataArray objectAtIndex:indexPath.section];
    
    WorkerProTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (!cell)
    {
        cell = [[WorkerProTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.details.hidden = YES;
        cell.favoriteBtn.hidden = YES;
        cell.IconBtn.layer.masksToBounds = YES;
        
        NSURL *url = [NSURL URLWithString:info.u_img];
        [cell.IconBtn sd_setImageWithURL:url];
        
        cell.title.text = info.t_title;
        cell.introduce.text = info.t_info;
        
        
        cell.favoriteBtn.tag = 500 + indexPath.section;
        [cell.favoriteBtn addTarget:self action:@selector(favoriteBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        cell.rightBtn.tag = 900 + indexPath.section;
        [cell.rightBtn addTarget:self action:@selector(yesBtn:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return cell;
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 115;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 10;
    }
    else
    {
        return 0.1;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    
    
    return view;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    
    return view;
}



//收藏按钮
- (void)favoriteBtn: (id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    NSLog(@"%ld", btn.tag);
}




//邀约按钮
- (void)yesBtn: (id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    NSLog(@"%ld", btn.tag);
    
    NSInteger num = btn.tag - 900;
    
    missionData *data = [self.dataArray objectAtIndex:num];
    
    
    [self getdataRenwu:data.t_id tew:self.gongzhongID];
    
  
}





//邀约请求
- (void)getdata: (NSString *)tew_id t_id:(NSString *)t_id
{
    
    NSString *url = [NSString stringWithFormat:@"%@Orders/index?action=create&tew_id=%@&t_id=%@&o_worker=%@&o_sponsor=%@", baseUrl, tew_id , t_id , self.worker_id, user_ID];

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    [manager GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject)
     {
         
         NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];

         if ([[dictionary objectForKey:@"code"] integerValue] == 200)
         {
             NSString *info = [dictionary objectForKey:@"data"];
             
            
                 [self dismissViewControllerAnimated:YES completion:nil];
                 
                 [self.delegate success];
            
                 //[SVProgressHUD showErrorWithStatus:@"您以邀约过此工人,或曾与此工人有过任务关系"];
             
             
         }
         
         
     } failure:^(NSURLSessionDataTask *task, NSError *error)
     {

     }];

}







//获取当前任务下，当前工种下的详情
- (void)getdataRenwu: (NSString *)t_id tew:(NSString *)skills
{
    //t_id   传过来的   self.t_id
    NSString *url = [NSString stringWithFormat:@"%@Tasks/index?action=info&t_id=%@&skills=%@", baseUrl, t_id, skills];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject)
     {
         NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         
         if ([[dictionary objectForKey:@"code"] integerValue] == 200)
         {
             NSDictionary *dic = [dictionary objectForKey:@"data"];
             
             ABigDataModel *data = [[ABigDataModel alloc] init];
             
             data.t_id = [dic objectForKey:@"t_id"];
             data.t_title = [dic objectForKey:@"t_title"];
             data.t_info = [dic objectForKey:@"t_info"];
             data.t_amount = [dic objectForKey:@"t_amount"];
             data.t_duration = [dic objectForKey:@"t_duration"];
             data.t_edit_amount = [dic objectForKey:@"t_edit_amount"];
             data.t_amount_edit_times = [dic objectForKey:@"t_amount_edit_times"];
             data.t_posit_x = [dic objectForKey:@"t_posit_x"];
             data.t_posit_y = [dic objectForKey:@"t_posit_y"];
             data.t_author = [dic objectForKey:@"t_author"];
             data.t_in_time = [dic objectForKey:@"t_in_time"];
             data.t_last_edit_time = [dic objectForKey:@"t_last_edit_time"];
             data.t_last_editor = [dic objectForKey:@"t_last_editor"];
             data.t_status = [dic objectForKey:@"t_status"];
             data.t_phone = [dic objectForKey:@"t_phone"];
             data.t_phone_status = [dic objectForKey:@"t_phone_status"];
             data.t_type = [dic objectForKey:@"t_type"];
             data.t_storage = [dic objectForKey:@"t_storage"];
             data.bd_id = [dic objectForKey:@"bd_id"];
             data.t_desc = [dic objectForKey:@"t_desc"];
             data.t_workers = [dic objectForKey:@"t_workers"];
             data.t_adree = [dic objectForKey:@"tew_address"];
             data.u_mobile = [dic objectForKey:@"u_mobile"];
             data.u_img = [dic objectForKey:@"u_img"];
             data.u_sex = [dic objectForKey:@"u_sex"];
             data.u_true_name = [dic objectForKey:@"u_true_name"];
             data.relation = [dic objectForKey:@"relation"];
             data.relation_type = [dic objectForKey:@"relation_type"];
             
             for (int i = 0; i < data.t_workers.count; i++)
             {
                 
                 AWorKeDataModel *info = [[AWorKeDataModel alloc] init];
                 
                 NSDictionary *dic1 = [data.t_workers objectAtIndex:i];
                 
                 info.tew_id = [dic1 objectForKey:@"tew_id"];
                 info.t_id = [dic1 objectForKey:@"t_id"];
                 info.tew_skills = [dic1 objectForKey:@"tew_skills"];
                 info.tew_worker_num = [dic1 objectForKey:@"tew_worker_num"];
                 info.tew_price = [dic1 objectForKey:@"tew_price"];
                 info.tew_start_time = [dic1 objectForKey:@"tew_start_time"];
                 info.tew_end_time = [dic1 objectForKey:@"tew_end_time"];
                 info.r_province = [dic1 objectForKey:@"r_province"];
                 info.r_city = [dic1 objectForKey:@"r_city"];
                 info.r_area = [dic1 objectForKey:@"r_area"];
                 info.tew_address = [dic1 objectForKey:@"tew_address"];
                 info.tew_lock = [dic1 objectForKey:@"tew_lock"];
                 info.remaining = [dic1 objectForKey:@"remaining"];
                 info.orders = [dic1 objectForKey:@"orders"];

                 
                 [renwuArray addObject:info];
                 
             }
             
             
             
             
             for (int q = 0; q < renwuArray.count; q++)
             {
                 AWorKeDataModel *info = [renwuArray objectAtIndex:q];
                 
                 if ([info.remaining intValue] > 0)
                 {
                     [self getdata:info.tew_id t_id:info.t_id];
                     
                     break;
                 }
 
             }
             
             
             
             
         }
         
     }
         failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         
     }];
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
