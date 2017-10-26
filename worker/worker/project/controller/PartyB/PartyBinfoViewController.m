//
//  PartyBinfoViewController.m
//  worker
//
//  Created by 郭健 on 2017/9/8.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "PartyBinfoViewController.h"

#import "ImageTableViewCell.h"
#import "PersonInfoTableViewCell.h"
#import "PersonTextviewTableViewCell.h"
#import "UserInfoModel.h"
#import "PersonEvaTableViewCell.h"
#import "PersonWorTableViewCell.h"

@interface BallpersonData : NSObject

@property (nonatomic) NSInteger bigType;   //  0 代表第一个section   1代表第二个

@end


@implementation BallpersonData


@end


@interface BinitPersonData : BallpersonData

@property (nonatomic, strong)NSString *imageStr;

@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSString *data;



@property (nonatomic, strong)NSMutableArray *workerArray;

@property (nonatomic) NSInteger type;

@end



@implementation BinitPersonData


@end



@interface BinitPersonElseData : BallpersonData

@property (nonatomic, strong)NSString *imageStr;
@property (nonatomic, strong)NSString *detail;
@property (nonatomic, strong)NSString *time;


@end

@implementation BinitPersonElseData



@end


@implementation workerArrData



@end


@interface getMyEvaData : NSObject

@property (nonatomic, strong)NSString *tc_id;
@property (nonatomic, strong)NSString *u_id;
@property (nonatomic, strong)NSString *t_id;
@property (nonatomic, strong)NSString *tc_u_id;
@property (nonatomic, strong)NSString *tc_in_time;
@property (nonatomic, strong)NSString *tce_desc;
@property (nonatomic, strong)NSString *u_img;
@property (nonatomic, strong)NSString *tc_start;


@end

@implementation getMyEvaData


@end


@interface PartyBinfoViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *dataArray;
    
    NSMutableArray *worArr;  //工种的数组
    
    
    NSString *PingNum;   //评价数
    
    UserAdreeData *addmodel;
    UserInfoModel *model;      //用户信息模型
    
    
    NSMutableArray *chineseWorker;   //工种中文数组
    NSMutableArray *wDataarray;   //工种数组
    
    
    NSMutableArray *pingjiaArr;  //评价的数组
    
}



@property (nonatomic, strong)UITableView *tableview;

@end

@implementation PartyBinfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    pingjiaArr = [NSMutableArray array];
    chineseWorker = [NSMutableArray array];
    dataArray = [NSMutableArray array];
    wDataarray = [NSMutableArray array];
    
    
    [self getdata];
    [self getinfoData];
    
  //  worArr = [NSMutableArray array];
    
    
    [self slitherBack:self.navigationController];
    
    [self initData];
    
    
    [self tableview];
    
    
    
    
}




- (UITableView *)tableview
{
    if (!_tableview)
    {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 65, SCREEN_WIDTH, SCREEN_HEIGHT - 65) style:UITableViewStyleGrouped];
        
        _tableview.delegate = self;
        _tableview.dataSource = self;
        
        [_tableview registerClass:[ImageTableViewCell class] forCellReuseIdentifier:@"imagecell"];
        [_tableview registerClass:[PersonInfoTableViewCell class] forCellReuseIdentifier:@"normalcell"];
        [_tableview registerClass:[PersonTextviewTableViewCell class] forCellReuseIdentifier:@"textcell"];
        
        [_tableview registerClass:[PersonEvaTableViewCell class] forCellReuseIdentifier:@"elsecell"];
        
        [_tableview registerClass:[PersonWorTableViewCell class] forCellReuseIdentifier:@"infocell"];
        
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
    NSMutableArray *arr = [dataArray objectAtIndex:section];
    
    
    return arr.count;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *arr = [dataArray objectAtIndex:indexPath.section];
    
    BallpersonData *data = [arr objectAtIndex:indexPath.row];
    
    if (data.bigType == 0)
    {
        BinitPersonData *info = (BinitPersonData *)data;
        
        if (info.type == 1)
        {
            ImageTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            
            if (!cell)
            {
                cell = [[ImageTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"imagecell"];
                
                NSURL *url = [NSURL URLWithString:model.u_img];
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                [cell.image sd_setImageWithURL:url];
            }
            
            
            return cell;
            
        }
        else if(info.type == 2)
        {
            
            PersonTextviewTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            
            if (!cell)
            {
                cell = [[PersonTextviewTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"textcell"];
                
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                cell.name.text = info.name;
                cell.textview.text = model.u_info;
                
                cell.textview.editable = NO;
            }
           
            
            return cell;
        }
        else if(info.type == 0)
        {
            PersonInfoTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            
            if (!cell)
            {
                cell = [[PersonInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"normalcell"];
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                cell.name.text = info.name;
                
                if (indexPath.row == 2)
                {
                    if ([model.u_sex isEqualToString:@"0"])
                    {
                        cell.data.text = @"女";
                    }
                    else if([model.u_sex isEqualToString:@"1"])
                    {
                        cell.data.text = @"男";
                    }
                    else
                    {
                        cell.data.text = @"";
                    }
                }
                else if (indexPath.row == 3)
                {
                    cell.data.text = addmodel.user_area_name;
                }
                else if (indexPath.row == 4)
                {
                    cell.data.text = addmodel.uei_address;
                }
                else if (indexPath.row == 1)
                {
                    cell.data.text = model.u_true_name;
                }
                else if (indexPath.row == 6)
                {
                    cell.data.text = info.data;
                }
                
                
            }
            
            
            return cell;
        }
        else
        {
            PersonWorTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            
            if (!cell)
            {
                cell = [[PersonWorTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"infocell"];
                
                cell.dataArray = info.workerArray;
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
            }
            
           
            
            
            
            return cell;
        }
        
    }
    else
    {
        
        BinitPersonElseData *info = (BinitPersonElseData *)data;
        
        PersonEvaTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        if (!cell)
        {
            
            cell = [[PersonEvaTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"elsecell"];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            NSURL *url = [NSURL URLWithString:info.imageStr];
            
            [cell.icon sd_setImageWithURL:url];
            
            NSString *time = [myselfway timeWithTimeIntervalString:info.time];
        
            cell.title.text = info.detail;
            cell.time.text = time;
            
        }
        
        
        return cell;
        
        
    }
    
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *arr = [dataArray objectAtIndex:indexPath.section];
    
    BallpersonData *data = [arr objectAtIndex:indexPath.row];
    
    if (data.bigType == 0)
    {
        BinitPersonData *info = (BinitPersonData *)data;
        
        if (info.type == 1)
        {
            return 100;
        }
        else if(info.type == 2)
        {
            return 120;
        }
        else if(info.type == 0)
        {
            return 40;
        }
        else
        {
     
            if (info.workerArray.count == 0)
            {
                return 0;
            }
            else if (info.workerArray.count < 5)
            {
                return 40;
            }
            else if (info.workerArray.count < 9 && info.workerArray.count > 4)
            {
                return 80;
            }
            else
            {
                return 120;
            }
            
        }
        
        
    }
    else
    {
        return 70;
    }
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1)
    {
        return 40;
    }
    else
    {
        return 0.1;
    }
}



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    
    if (section == 1)
    {
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, 200, 30)];
        
        title.text = [NSString stringWithFormat:@"Ta收到的评价(%ld)", pingjiaArr.count];
        
        title.font = [UIFont systemFontOfSize:15];
        
        [view addSubview:title];
    }
    
    return view;
}






//制作数据
- (void)initData
{
    NSMutableArray *firstArray = [NSMutableArray array];
    
    BinitPersonData *info = [[BinitPersonData alloc] init];   //type 1  为头像的cell ，   0 为正常的cell
    
    info.bigType = 0;
   // info.imageStr = @"http://n.sinaimg.cn/default/1_img/uplaod/3933d981/20170907/gALk-fykuffc4212126.jpg";
    info.type = 1;
    
    [firstArray addObject:info];
    
    
    BinitPersonData * info1 = [[BinitPersonData alloc] init];
    
    info1.bigType = 0;
    info1.type = 0;
    info1.name = @"姓名:";
    info1.data = @"王二妮";
    
    [firstArray addObject:info1];
    
    
    BinitPersonData * info2 = [[BinitPersonData alloc] init];
    
    info2.bigType = 0;
    info2.type = 0;
    info2.name = @"性别:";
    info2.data = @"女";
    
    [firstArray addObject:info2];
    
    
//    BinitPersonData * info3 = [[BinitPersonData alloc] init];
//
//    info3.bigType = 0;
//    info3.type = 0;
//    info3.name = @"年龄:";
//    info3.data = @"24";
//
//    [firstArray addObject:info3];
    
    
    BinitPersonData * info4 = [[BinitPersonData alloc] init];
    
    info4.bigType = 0;
    info4.type = 0;
    info4.name = @"现居地:";
    info4.data = @"哈尔滨道里区";
    
    [firstArray addObject:info4];
    
    
    BinitPersonData * info5 = [[BinitPersonData alloc] init];
    
    info5.bigType = 0;
    info5.type = 0;
    info5.name = @"户口所在地:";
    info5.data = @"辽宁省沈阳市沈河区南京南街";
    
    [firstArray addObject:info5];
    
    
    BinitPersonData * info6 = [[BinitPersonData alloc] init];
    
    info6.bigType = 0;
    info6.type = 2;
    info6.name = @"个人简介:";
    info6.data = @"普通上班族，热爱生活，大神就客户打款； 啥来电话";
    
    [firstArray addObject:info6];
    
    
    
    BinitPersonData * info7 = [[BinitPersonData alloc] init];
    
    info7.bigType = 0;
    info7.type = 0;
    info7.name = @"角色选择:";
    info7.data = @"工人";
    
    [firstArray addObject:info7];
    
    
    BinitPersonData * info8 = [[BinitPersonData alloc] init];
    
    info8.bigType = 0;
    info8.type = 3;
//    info8.workerArray = worArr;
    
    [firstArray addObject:info8];

    
    
    
    [dataArray addObject:firstArray];
    
    

    
    [self.tableview reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



//个人信息网络请求
- (void)getinfoData
{
    NSString *url = [NSString stringWithFormat:@"%@Users/usersInfo?u_id=%@", baseUrl, self.u_id];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject)
     {
         NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         
         if ([[dictionary objectForKey:@"code"] integerValue] == 1)
         {
             NSDictionary *dic = [dictionary objectForKey:@"data"];
             
             NSDictionary *dicData = [dic objectForKey:@"data"];
             
             model = [[UserInfoModel alloc] init];
             
             model.u_id = [dicData objectForKey:@"u_id"];
             model.u_name = [dicData objectForKey:@"u_name"];
             model.u_mobile = [dicData objectForKey:@"u_mobile"];
             model.u_phone = [dicData objectForKey:@"u_phone"];
             model.u_sex = [dicData objectForKey:@"u_sex"];
             model.u_in_time = [dicData objectForKey:@"u_in_time"];
             model.u_online = [dicData objectForKey:@"u_online"];
             model.u_status = [dicData objectForKey:@"u_status"];
             model.u_type = [dicData objectForKey:@"u_type"];
             model.u_task_status = [dicData objectForKey:@"u_task_status"];
             model.u_skills = [dicData objectForKey:@"u_skills"];
             model.u_start = [dicData objectForKey:@"u_start"];
             model.u_credit = [dicData objectForKey:@"u_credit"];
             model.u_top = [dicData objectForKey:@"u_top"];
             model.u_recommend = [dicData objectForKey:@"u_recommend"];
             model.u_jobs_num = [dicData objectForKey:@"u_jobs_num"];
             model.u_worked_num = [dicData objectForKey:@"u_worked_num"];
             model.u_high_opinions = [dicData objectForKey:@"u_high_opinions"];
             model.u_low_opinions = [dicData objectForKey:@"u_low_opinions"];
             model.u_middle_opinions = [dicData objectForKey:@"u_middle_opinions"];
             model.u_dissensions = [dicData objectForKey:@"u_dissensions"];
             model.u_true_name = [dicData objectForKey:@"u_true_name"];
             model.u_idcard = [dicData objectForKey:@"u_idcard"];
             model.u_info = [dicData objectForKey:@"u_info"];
             model.u_img = [dicData objectForKey:@"u_img"];
             model.uei_province = [dicData objectForKey:@"uei_province"];
             model.uei_city = [dicData objectForKey:@"uei_city"];
             model.uei_area = [dicData objectForKey:@"uei_area"];
             model.uei_address = [dicData objectForKey:@"uei_address"];
             
             
             
             model.area = [dicData objectForKey:@"area"];
             
             addmodel = [[UserAdreeData alloc] init];
             
             addmodel.uei_info = [model.area objectForKey:@"uei_info"];
             addmodel.uei_province = [model.area objectForKey:@"uei_province"];
             addmodel.uei_city = [model.area objectForKey:@"uei_city"];
             addmodel.uei_area = [model.area objectForKey:@"uei_area"];
             addmodel.uei_address = [model.area objectForKey:@"uei_address"];
             addmodel.user_area_name = [model.area objectForKey:@"user_area_name"];
             
             
             
             [self addhead:model.u_true_name];
             
             
             
             NSArray *arr = [dataArray objectAtIndex:0];
             
             BinitPersonData *data = [arr objectAtIndex:6];
             
             if ([model.u_skills isEqualToString:@",,"] || [model.u_skills isEqualToString:@""] || [model.u_skills isEqualToString:@"0"])
             {
                 data.data = @"雇主";
             }
             else
             {
                 data.data = @"工人";
             }
             
             
             
             
             NSArray *worArr = [dataArray objectAtIndex:0];
             
             BinitPersonData *info = [worArr objectAtIndex:7];
             
             
             //制作工种数组
             if ([model.u_skills isEqualToString:@",,"] || [model.u_skills isEqualToString:@""] || [model.u_skills isEqualToString:@"0"])
             {
                 //我不是工人
                 
             }
             else
             {
                 //我是工人
                 NSArray *array = [model.u_skills componentsSeparatedByString:@","];
                 
                 [chineseWorker removeAllObjects];
                 
                 for (int i = 0; i < wDataarray.count; i++)
                 {
                     workerArrData *data = [wDataarray objectAtIndex:i];
                     
                     for (int j = 0; j < array.count; j++)
                     {
                         NSString *str = [array objectAtIndex:j];
                         
                         if ([str isEqualToString:data.s_id])
                         {
                             [chineseWorker addObject:data.s_name];
                         }
                     }
                     
                 }
                 
                 info.workerArray = chineseWorker;
                 
             }
             
             
             
             
             
             
             [self getMydata];
             
            // [self.tableview reloadData];
             
         }
         
         
         
     } failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         
     }];
    
}




//获取工种数组
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
                 
                 workerArrData *data = [[workerArrData alloc] init];
                 
                 data.s_id = [dic objectForKey:@"s_id"];
                 data.s_desc = [dic objectForKey:@"s_desc"];
                 data.s_info = [dic objectForKey:@"s_info"];
                 data.s_name = [dic objectForKey:@"s_name"];
                 data.s_status = [dic objectForKey:@"s_status"];
                 
                 [wDataarray addObject:data];
                 
             }

           
         }
         
         
         
     } failure:^(NSURLSessionDataTask *task, NSError *error)
     {
        
     }];
    
    
}




//别人给我的评价
- (void)getMydata
{
    NSString *url = [NSString stringWithFormat:@"%@Users/otherCommentUser?tc_u_id=%@", baseUrl, @"2"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject)
     {
         NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         
         if ([[dictionary objectForKey:@"code"] integerValue] == 1)
         {
             
             NSDictionary *dic = [dictionary objectForKey:@"data"];
             
             NSArray *arr = [dic objectForKey:@"data"];
             
             for (int i = 0; i < arr.count; i++)
             {
                 NSDictionary *dic = [arr objectAtIndex:i];
                 
                 getMyEvaData *data = [[getMyEvaData alloc] init];
                 
                 data.tc_id = [dic objectForKey:@"tc_id"];
                 data.u_id = [dic objectForKey:@"u_id"];
                 data.t_id = [dic objectForKey:@"t_id"];
                 data.tc_u_id = [dic objectForKey:@"tc_u_id"];
                 data.tc_in_time = [dic objectForKey:@"tc_in_time"];
                 data.tce_desc = [dic objectForKey:@"tce_desc"];
                 data.u_img = [dic objectForKey:@"u_img"];
                 data.tc_start = [dic objectForKey:@"tc_start"];
                 
                 [pingjiaArr addObject:data];
                 
             }
             
             NSMutableArray *newArr = [NSMutableArray array];
             
             for (int k = 0; k < pingjiaArr.count; k++)
             {
                 BinitPersonElseData *data = [[BinitPersonElseData alloc] init];
                 
                 getMyEvaData *info = [pingjiaArr objectAtIndex:k];
                 
                 data.bigType = 1;
                 data.imageStr = info.u_img;
                 data.time = info.tc_in_time;
                 data.detail = info.tce_desc;
                 
                 [newArr addObject:data];
                 
             }
             

             [dataArray addObject:newArr];
             

             [self.tableview reloadData];
             
             
             
         }
         
         
         
     } failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         
     }];
    
    
}



@end
