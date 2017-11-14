//
//  ProDetailListViewController.m
//  worker
//
//  Created by ios_g on 2017/10/28.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "ProDetailListViewController.h"
#import "worInfoTableViewCell.h"
#import "AYesOrNoViewController.h"
#import "AYesWorkerViewController.h"
#import "PartyCommentViewController.h"

@interface prooListData : NSObject

@property (nonatomic, strong)NSString *s_id;
@property (nonatomic, strong)NSString *s_name;
@property (nonatomic, strong)NSString *s_info;
@property (nonatomic, strong)NSString *s_desc;
@property (nonatomic, strong)NSString *s_status;


@property (nonatomic, strong)NSString *s_image;


@end

@implementation prooListData


@end




@interface ProDetailListViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *dataArray;
    
    
    NSMutableArray *worArray;   //工种数组
    
    NSString *worName;  //工种名字： 中文
    
    NSString *s_sta;   //状态
    
    
    
    NSInteger payType;
    
}


@property (nonatomic, strong)UITableView *tableview;

@end




@implementation BigDataModel

@end

@implementation WorKeDataModel

@end

@implementation ListDataModel

@end

@implementation ProDetailListViewController

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    payType = 0;
    // Do any additional setup after loading the view.
    
    dataArray = [NSMutableArray array];
    worArray = [NSMutableArray array];
    

    [self addhead:@"任务信息"];
    
    [self tableview];
    
    [self getdataW];
    [self getdata];

}





- (UITableView *)tableview
{
    
    if (!_tableview)
    {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 65, SCREEN_WIDTH, SCREEN_HEIGHT - 65) style:UITableViewStyleGrouped];
        
        _tableview.delegate = self;
        _tableview.dataSource = self;
        
        [_tableview registerClass:[worInfoTableViewCell class] forCellReuseIdentifier:@"cell"];
        
        [_tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        
        _tableview.backgroundColor = [myselfway stringTOColor:@"0xC4CED3"];
        
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
    WorKeDataModel *model = [dataArray objectAtIndex:section];
    
    return model.ordersArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WorKeDataModel *model = [dataArray objectAtIndex:indexPath.section];

    ListDataModel *info = [model.ordersArray objectAtIndex:indexPath.row];
    
    for (int i = 0; i < worArray.count; i++)
    {
        prooListData *info1 = [worArray objectAtIndex:i];
        
        if ([info1.s_id isEqualToString:model.tew_skills])
        {
            worName = info1.s_name;
        }
    }
    
    worInfoTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (!cell)
    {
        cell = [[worInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        
        NSURL *url = [NSURL URLWithString:info.u_img];
        
        [cell.icon sd_setImageWithURL:url];

        cell.name.text = info.u_true_name;
        
        NSString *tag = [NSString stringWithFormat:@"%ld%ld", indexPath.section, indexPath.row];
        
        cell.call.tag = [tag integerValue];
        [cell.call addTarget:self action:@selector(callPhone:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        
        cell.state.hidden = YES;
        cell.call.hidden = YES;
        
        
        
        
        if ([info.o_pay isEqualToString:@"0"])
        {
            cell.state.hidden = NO;
            cell.call.hidden = NO;
            
            //未结束的
            if ([info.u_task_status isEqualToString:@"0"])
            {
                //洽谈
                
                cell.workerType.text = worName;
                
                [cell.call setImage:[UIImage imageNamed:@"mine_call"] forState:UIControlStateNormal];
                
                cell.state.backgroundColor = [UIColor orangeColor];
                
                cell.state.text = @"洽谈中";
             
                [cell.call setImage:[UIImage imageNamed:@"mine_call"] forState:UIControlStateNormal];
                
            }
            else
            {
                //工作中
                
                cell.workerType.text = worName;
                
                cell.state.text = @"工作中";
                
                [cell.call setImage:[UIImage imageNamed:@"mine_call"] forState:UIControlStateNormal];
                
                cell.state.backgroundColor = [UIColor redColor];
 
            
            }
 
            
        }
        else
        {
            //结束的

            cell.workerType.text = worName;
            cell.call.hidden = YES;
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            UIButton *evaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            
            [evaBtn setTitle:@"评价" forState:UIControlStateNormal];
            evaBtn.titleLabel.font = [UIFont systemFontOfSize:14];
            evaBtn.backgroundColor = [UIColor greenColor];
            
            evaBtn.layer.masksToBounds = YES;
            evaBtn.layer.cornerRadius = 7;
            [evaBtn addTarget:self action:@selector(evaBtn:) forControlEvents:UIControlEventTouchUpInside];
            
            NSString *tagEva = [NSString stringWithFormat:@"%ld%ld", indexPath.section, indexPath.row];
            
            evaBtn.tag = [tagEva integerValue];
            
            [cell addSubview:evaBtn];
            
            [evaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(cell);
                make.right.mas_equalTo(cell).offset(-15);
                make.height.mas_equalTo(30);
                make.width.mas_equalTo(80);
            }];
            
        }

        
        
        //逻辑判断，  可能会有问题
        if ([info.o_status isEqualToString:@"-1"])
        {
            //工人辞职
            
            cell.workerType.text = worName;
            
            cell.state.text = @"已辞职";
            
         //   [cell.call setImage:[UIImage imageNamed:@"mine_call"] forState:UIControlStateNormal];
            cell.call.hidden = YES;
            cell.state.hidden = NO;
            
            cell.state.backgroundColor = [UIColor grayColor];
            
        }
        else if([info.o_status isEqualToString:@"-2"])
        {
            //雇主解雇
            
            cell.workerType.text = worName;
            
            cell.state.text = @"已解雇";
            
            cell.state.hidden = NO;
            
            cell.call.hidden = YES;
            
        //    [cell.call setImage:[UIImage imageNamed:@"mine_call"] forState:UIControlStateNormal];
            
            cell.state.backgroundColor = [UIColor grayColor];
            
        }
        
        
        
        
        
        
            if ([info.u_sex isEqualToString:@"1"])
            {
                cell.sex.image = [UIImage imageNamed:@"job_man"];
            }
            else if([info.u_sex isEqualToString:@"0"])
            {
                cell.sex.image = [UIImage imageNamed:@"job_woman"];
            }
        

    }

    
    return cell;
}


//拨打电话
- (void)callPhone: (UIButton *)btn
{
    NSString *tag = [NSString stringWithFormat:@"%ld", btn.tag];
    
    NSString *first = [tag substringToIndex:1];//section
    
    NSString *last = [tag substringFromIndex:tag.length - 1];   //row
    
    WorKeDataModel *model = [dataArray objectAtIndex:[first integerValue]];
    
    ListDataModel *info = [model.ordersArray objectAtIndex:[last integerValue]];
    
    NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"telprompt://%@", info.u_mobile];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    
}





- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    WorKeDataModel *model = [dataArray objectAtIndex:indexPath.section];
    
    ListDataModel *info = [model.ordersArray objectAtIndex:indexPath.row];
    
    self.hidesBottomBarWhenPushed = YES;
    
    if ([info.o_pay isEqualToString:@"0"])
    {
        //洽谈和工作
        
        if ([info.o_status isEqualToString:@"-1"] || [info.o_status isEqualToString:@"-2"])
        {
            
        }
        else
        {
            if ([info.u_task_status isEqualToString:@"0"])    //洽谈
            {
                AYesOrNoViewController *temp = [[AYesOrNoViewController alloc] init];
                
                temp.worName = worName;
                
                temp.worU_id = info.o_worker;
                
                temp.o_id = info.o_id;
                temp.t_id = info.t_id;
                temp.tew_id = info.tew_id;
                temp.o_worker = info.o_worker;
                temp.o_confirm = info.o_confirm;
                temp.o_status = info.o_status;
                temp.s_id = info.s_id;
                
                temp.worNameMM = worName;
                temp.person = model.tew_worker_num;
                temp.money = info.o_amount;
                temp.startTime = model.tew_start_time;
                temp.endTime = model.tew_end_time;
                temp.skill = model.tew_skills;
                
                [self.navigationController pushViewController:temp animated:YES];
                
            }
            else if ([info.u_task_status isEqualToString:@"1"])
            {
                
                AYesWorkerViewController *temp = [[AYesWorkerViewController alloc] init];
                
                temp.worName = worName;
                
                temp.worU_id = info.o_worker;
                
                temp.o_id = info.o_id;
                temp.t_id = info.t_id;
                temp.tew_id = info.tew_id;
                temp.o_worker = info.o_worker;
                temp.o_confirm = info.o_confirm;
                temp.o_status = info.o_status;
                temp.s_id = info.s_id;
                
                [self.navigationController pushViewController:temp animated:YES];
                
            }
        }
        
        
        
    }
    else
    {
        //结束
        
      
    }
    
    
    
    
    
    

    

    
}



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    WorKeDataModel *model = [dataArray objectAtIndex:section];
    
    for (int i = 0; i < worArray.count; i++)
    {
        prooListData *info = [worArray objectAtIndex:i];
        
        if ([info.s_id isEqualToString:model.tew_skills])
        {
            worName = info.s_name;
        }
    }
    
    
    UIView *view = [[UIView alloc] init];
    
    
    UIView *back = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
    
    back.backgroundColor = [myselfway stringTOColor:@"0xC4CED3"];
    
    [view addSubview:back];
    
    
    
    view.backgroundColor = [UIColor whiteColor];

    UILabel *wor = [[UILabel alloc] initWithFrame:CGRectMake(15, 25, 150, 30)];
    
    wor.font = [UIFont systemFontOfSize:15];
    
    wor.text = worName;
    
    [view addSubview:wor];
    
    
    
    NSString *start = [myselfway timeWithTimeIntervalString:model.tew_start_time];
    NSString *end = [myselfway timeWithTimeIntervalString:model.tew_end_time];
    
    NSString *allTime = [NSString stringWithFormat:@"%@ 一 %@", start, end];
    
    UILabel *time = [[UILabel alloc] init];
    
    time.text = allTime;
    
    time.textAlignment = NSTextAlignmentCenter;
    
    time.font = [UIFont systemFontOfSize:15];
    
    [view addSubview:time];
    
    [time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(view).offset(25);
        make.centerX.mas_equalTo(view);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(200);
    }];
  
    return view;
    
}




- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{

    WorKeDataModel *model = [dataArray objectAtIndex:section];
    
    ListDataModel *info = [model.ordersArray objectAtIndex:0];
    

    
    UIView *view = [[UIView alloc] init];
    
    view.backgroundColor = [UIColor whiteColor];
    

        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, 250, 40)];
        
        label.text = @"确认工程结束后，系统将把\n预付的工资支付给工人";
        
        label.numberOfLines = 2;
        
        label.font = [UIFont systemFontOfSize:14];
        
        label.textColor = [UIColor grayColor];
        
        [view addSubview:label];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = 8;
        

        if ([info.o_pay isEqualToString:@"1"])
        {
            //说明已经付过款了
            
            [button setTitle:@"已完工" forState:UIControlStateNormal];
            
            button.userInteractionEnabled = NO;
            
        }
        else
        {
            
            [button setTitle:@"确认完工" forState:UIControlStateNormal];
            button.userInteractionEnabled = YES;
            
        }
   

        button.backgroundColor = [UIColor grayColor];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.tag = 700 + section;
        [button addTarget:self action:@selector(wangongBtn:) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake(SCREEN_WIDTH - 95, 10, 80, 30);
        [view addSubview:button];
  
   
    return view;
}


//确认完工
- (void)wangongBtn : (UIButton *)btn
{
    NSInteger num = btn.tag - 700;
    
    WorKeDataModel *model = [dataArray objectAtIndex:num];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请确认所有工人都在工作状态后再确认完工\n确认完工后，您将付给工作中并未产生纠纷的工人相应的工资\n是否确认已经完工？" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"还未完工" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action)
                      {
                          
                      }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确认完工" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                      {
                          BOOL zhifu = YES;
                          
                          for (int i = 0; i < model.ordersArray.count; i++)
                          {
                              ListDataModel *info = [model.ordersArray objectAtIndex:i];
                              
                              if ([info.u_task_status isEqualToString:@"0"])
                              {
                                  //说明工种下有工人为洽谈

                                  zhifu = NO;
                              }
                              
                              //判断当前工种下，是否有辞职解雇的订单，如果有，则可以结账
                              if ([info.o_status isEqualToString:@"-1"] || [info.o_status isEqualToString:@"-2"])
                              {
                                  zhifu = YES;
                              }
                              
                          }
                          
                          
                          if (zhifu == YES)
                          {
                              
                              [self jiesuan:model.tew_id t_id:model.t_id];
                              
                          }
                          else
                          {
                              [SVProgressHUD showErrorWithStatus:@"您有工人为洽谈状态，请先取消后在进行结算!"];
                          }
                          
                          
                          
                      }]];
    
    
    [self presentViewController:alert animated:YES completion:nil];
}




- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{

    return 50;
 
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}





- (void)getdata
{
    //t_id   传过来的   self.t_id
    NSString *url = [NSString stringWithFormat:@"%@Tasks/index?action=info&t_id=%@&o_worker=%@", baseUrl, self.t_id, user_ID];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject)
     {
         NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         
         if ([[dictionary objectForKey:@"code"] integerValue] == 200)
         {
             NSDictionary *dic = [dictionary objectForKey:@"data"];
             
             BigDataModel *data = [[BigDataModel alloc] init];
             
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
                
                 WorKeDataModel *info = [[WorKeDataModel alloc] init];
                 
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
                 info.tew_type = [dic1 objectForKey:@"tew_type"];
                 info.tew_status = [dic1 objectForKey:@"tew_status"];
                 info.ordersArray = [NSMutableArray array];
                                              
                 for (int q = 0; q < info.orders.count; q++)
                 {

                     ListDataModel *listModel = [[ListDataModel alloc] init];

                     NSDictionary *ListDic = [info.orders objectAtIndex:q];

                     listModel.o_id = [ListDic objectForKey:@"o_id"];
                     listModel.t_id = [ListDic objectForKey:@"t_id"];
                     listModel.u_id = [ListDic objectForKey:@"u_id"];
                     listModel.o_worker = [ListDic objectForKey:@"o_worker"];
                     listModel.o_amount = [ListDic objectForKey:@"o_amount"];
                     listModel.o_in_time = [ListDic objectForKey:@"o_in_time"];
                     listModel.o_last_edit_time = [ListDic objectForKey:@"o_last_edit_time"];
                     listModel.o_status = [ListDic objectForKey:@"o_status"];
                     listModel.tew_id = [ListDic objectForKey:@"tew_id"];
                     listModel.s_id = [ListDic objectForKey:@"s_id"];
                     listModel.o_confirm = [ListDic objectForKey:@"o_confirm"];
                     listModel.unbind_time = [ListDic objectForKey:@"unbind_time"];
                     listModel.o_pay = [ListDic objectForKey:@"o_pay"];
                     listModel.o_pay_time = [ListDic objectForKey:@"o_pay_time"];
                     listModel.o_sponsor = [ListDic objectForKey:@"o_sponsor"];
                     
                     listModel.u_name = [ListDic objectForKey:@"u_name"];
                     listModel.u_mobile = [ListDic objectForKey:@"u_mobile"];
                     listModel.u_sex = [ListDic objectForKey:@"u_sex"];
                     listModel.u_online = [ListDic objectForKey:@"u_online"];
                     listModel.u_status = [ListDic objectForKey:@"u_status"];
                     listModel.u_task_status = [ListDic objectForKey:@"u_task_status"];
                     listModel.u_start = [ListDic objectForKey:@"u_start"];
                     listModel.u_credit = [ListDic objectForKey:@"u_credit"];
                     listModel.u_jobs_num = [ListDic objectForKey:@"u_jobs_num"];
                     listModel.u_recommend = [ListDic objectForKey:@"u_recommend"];
                     listModel.u_worked_num = [ListDic objectForKey:@"u_worked_num"];
                     listModel.u_high_opinions = [ListDic objectForKey:@"u_high_opinions"];
                     listModel.u_low_opinions = [ListDic objectForKey:@"u_low_opinions"];
                     listModel.u_middle_opinions = [ListDic objectForKey:@"u_middle_opinions"];
                     listModel.u_dissensions = [ListDic objectForKey:@"u_dissensions"];
                     listModel.u_true_name = [ListDic objectForKey:@"u_true_name"];
                     listModel.u_img = [ListDic objectForKey:@"u_img"];
                     

                     [info.ordersArray addObject:listModel];

                 }
                 
                 
                 if (info.ordersArray.count != 0)
                 {
                     [dataArray addObject:info];
                 }

             }
             
             
             if (dataArray.count != 0)
             {
                 [self.tableview reloadData];
             }
             
            
             
         }
         
     }
         failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         
     }];
    
    
}


//获取工种
- (void)getdataW
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
                 
                 prooListData *data = [[prooListData alloc] init];
                 
                 data.s_id = [dic objectForKey:@"s_id"];
                 data.s_desc = [dic objectForKey:@"s_desc"];
                 data.s_info = [dic objectForKey:@"s_info"];
                 data.s_name = [dic objectForKey:@"s_name"];
                 data.s_status = [dic objectForKey:@"s_status"];
                 
                 [worArray addObject:data];
                 
                 
             }

         }
         
         
         
     } failure:^(NSURLSessionDataTask *task, NSError *error)
     {
  
     }];
    
    
}




//结算接口
- (void)jiesuan: (NSString *)tew_id t_id:(NSString *)t_id
{
    
    NSString *url = [NSString stringWithFormat:@"%@Orders/index?action=payout&tew_id=%@&t_id=%@&t_author=%@", baseUrl, tew_id, t_id, user_ID];
    
    NSLog(@"%@", url);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject)
     {
         NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         
         if ([[dictionary objectForKey:@"code"] integerValue] == 200)
         {
             NSString *msg = [dictionary objectForKey:@"data"];
             
             
                 [SVProgressHUD showInfoWithStatus:msg];
                 
                 [self.navigationController popToRootViewControllerAnimated:YES];
             
//                 [SVProgressHUD showInfoWithStatus:@"结算失败, 请检查网络!"];
//
//                 [self.navigationController popToRootViewControllerAnimated:YES];
             
             
         }

     } failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         
     }];
    
    
}





//评价的点击事件
- (void)evaBtn: (UIButton *)btn
{
    
    NSString *tag = [NSString stringWithFormat:@"%ld", btn.tag];
    
    NSString *first = [tag substringToIndex:1];//section
    
    NSString *last = [tag substringFromIndex:tag.length - 1];   //row
    
    WorKeDataModel *model = [dataArray objectAtIndex:[first integerValue]];
    
    ListDataModel *info = [model.ordersArray objectAtIndex:[last integerValue]];
    
    self.hidesBottomBarWhenPushed = YES;
    
    PartyCommentViewController *temp = [[PartyCommentViewController alloc] init];
    
    temp.t_id = info.t_id;
    temp.o_worker = info.o_worker;
    temp.worName = worName;
    
    [self.navigationController pushViewController:temp animated:YES];
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
