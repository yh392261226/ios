//
//  WorkerManagementViewController.m
//  worker
//
//  Created by 郭健 on 2017/8/8.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "WorkerManagementViewController.h"
#import "TypeView.h"
#import "OneTableViewCell.h"
#import "BYesOrNoViewController.h"
#import "BYesWorkerViewController.h"
#import "endDetailViewController.h"

@interface WorPerDataModel : NSObject

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
@property (nonatomic, strong)NSString *u_img;
@property (nonatomic, strong)NSString *unbind_time;

@property (nonatomic, strong)NSString *o_confirm;
@property (nonatomic, strong)NSString *s_id;
@property (nonatomic, strong)NSString *tew_id;
@property (nonatomic, strong)NSString *o_status;
@property (nonatomic, strong)NSString *o_last_edit_time;
@property (nonatomic, strong)NSString *o_in_time;
@property (nonatomic, strong)NSString *o_amount;
@property (nonatomic, strong)NSString *o_worker;
@property (nonatomic, strong)NSString *u_id;
@property (nonatomic, strong)NSString *o_id;




@end


@implementation WorPerDataModel


@end

@interface WorkerManagementViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *dataArray;
    
    TypeView *typeView;  //上面选择类型的view
    
    NSMutableArray *nameArr;   //类型上的view名字数组,传给自定义view
}


@property (nonatomic, strong)UITableView *tableview;

@end

@implementation WorkerManagementViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    dataArray = [NSMutableArray array];
    
    nameArr = [NSMutableArray arrayWithObjects:@"全部",@"洽谈中", @"进行中", @"已结束", nil];
    
    [self addhead:@"工人工作管理"];
    
  //  [self slitherBack:self.navigationController];
    
    [self tableview];
    
    [self initTypeView];
    
    [self getdata:@"0"];
}


#pragma tableview 代理方法

- (UITableView *)tableview
{
    if (!_tableview)
    {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 104, SCREEN_WIDTH, SCREEN_HEIGHT - 104) style:UITableViewStyleGrouped];
        
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
    WorPerDataModel *model = [dataArray objectAtIndex:indexPath.section];
    
    OneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    [cell.favoriteBtn addTarget:self action:@selector(favoriteBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.favoriteBtn.hidden = YES;
    
    cell.details.hidden = YES;
    cell.leftBtn.hidden = YES;
    cell.centerBtn.hidden = YES;
    cell.rightBtn.hidden = NO;
    
    cell.title.text = model.t_title;
    cell.introduce.text = model.t_info;
    cell.distance.hidden = YES;
    
    NSURL *url = [NSURL URLWithString:model.u_img];
    
    [cell.IconBtn sd_setImageWithURL:url];
    
    
    
    if ([model.o_status isEqualToString:@"0"])
    {
        if ([model.o_confirm isEqualToString:@"0"] || [model.o_confirm isEqualToString:@"2"])
        {
            //洽谈
            cell.state.image = [UIImage imageNamed:@"main_state3"];
        }
        else
        {
            //工作
            cell.state.image = [UIImage imageNamed:@"main_state5"];
        }
        
        cell.rightBtn.hidden = YES;
        
    }
    else
    {
        //完成
        cell.state.image = [UIImage imageNamed:@"main_state6"];
        
        [cell.rightBtn setTitle:@"删除信息" forState:0];
        
    }
    
    
    
    
    
    
    
    
    cell.leftBtn.tag = 100 + indexPath.section;
    cell.centerBtn.tag = 200 + indexPath.section;
    cell.rightBtn.tag = 300 + indexPath.section;
    
    
    [cell.leftBtn addTarget:self action:@selector(leftbtn:) forControlEvents:UIControlEventTouchUpInside];
    [cell.centerBtn addTarget:self action:@selector(centerbtn:) forControlEvents:UIControlEventTouchUpInside];
    [cell.rightBtn addTarget:self action:@selector(rightbtn:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 115;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    WorPerDataModel *model = [dataArray objectAtIndex:indexPath.section];
    
    self.hidesBottomBarWhenPushed = YES;
  
        if ([model.o_status isEqualToString:@"0"])
        {
            if ([model.o_confirm isEqualToString:@"0"] || [model.o_confirm isEqualToString:@"2"])
            {
                //洽谈
                
                BYesOrNoViewController *temp = [[BYesOrNoViewController alloc] init];
                
                temp.t_id = model.t_id;
                
                [self.navigationController pushViewController:temp animated:YES];
                

            }
            else
            {
                //工作
                
                BYesWorkerViewController *temp = [[BYesWorkerViewController alloc] init];
                
                temp.t_id = model.t_id;
                
                [self.navigationController pushViewController:temp animated:YES];
                
            }
            
      
            
        }
        else
        {
            //完成
            endDetailViewController *temp = [[endDetailViewController alloc] init];
            
            temp.t_id = model.t_id;
            
            [self.navigationController pushViewController:temp animated:YES];
            
        }
        
        
    
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


#pragma type的view
- (void)initTypeView
{
    self.view.backgroundColor = [myselfway stringTOColor:@"0xC4CED3"];
    
    typeView = [[TypeView alloc] initWithFrame:CGRectMake(0, 69, SCREEN_WIDTH, 40)];
    
    typeView.delegate = self;
    
    typeView.backgroundColor = [UIColor whiteColor];
    
    typeView.nameArray = nameArr;
    
    [self.view addSubview:typeView];
    
}


//上面选择栏点击事件的代理方法
- (void)tempVal: (NSInteger)type
{
    NSInteger i = type - 500;
    
    if (i == 0)
    {
        [self getdata:@"0"];
    }
    else if (i == 1)
    {
        [self getdata:@"1"];
    }
    else if (i == 2)
    {
        [self getdata:@"2"];
    }
    else
    {
        [self getdata:@"3"];
    }
}


#pragma 自己的方法

//cell上按钮的点击
- (void)leftbtn: (UIButton *)btn
{
    NSLog(@"1");
}


- (void)centerbtn: (UIButton *)btn
{
    NSLog(@"2");
}



- (void)rightbtn: (UIButton *)btn
{
    NSInteger num = btn.tag - 300;
    
    WorPerDataModel *model = [dataArray objectAtIndex:num];
    
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"是否删除该任务信息？" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action)
                      {
                          
                      }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                      {
                          //删除信息
                          [self DDDDDdeldata:model.o_id index:num];
                          
                      }]];
    
    
    [self presentViewController:alert animated:YES completion:nil];
    

}



//收藏按钮点击
- (void)favoriteBtn: (UIButton *)btn
{
    NSLog(@"%ld", btn.tag);
}






//任务数据网络请求
- (void)getdata: (NSString *)t_status
{
    NSString *url;
    
    //工人工作管理
    
    if ([t_status isEqualToString:@"0"])
    {
        url = [NSString stringWithFormat:@"%@Tasks/index?action=worked&o_worker=%@", baseUrl, user_ID];
    }
    else if ([t_status isEqualToString:@"1"])
    {
        url = [NSString stringWithFormat:@"%@Tasks/index?action=worked&o_worker=%@&o_status=0&o_confirm=0,2", baseUrl,user_ID];
    }
    else if ([t_status isEqualToString:@"2"])
    {
        url = [NSString stringWithFormat:@"%@Tasks/index?action=worked&o_worker=%@&o_status=0&o_confirm=1", baseUrl,user_ID];
    }
    else
    {
        url = [NSString stringWithFormat:@"%@Tasks/index?action=worked&o_worker=%@&o_status=1", baseUrl,user_ID];
    }
    
    NSLog(@"%@", url);
    
    
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
                 
                 WorPerDataModel *model = [[WorPerDataModel alloc] init];
                 
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
                 model.u_img = [dic objectForKey:@"u_img"];
                 
                 model.unbind_time = [dic objectForKey:@"unbind_time"];
                 model.o_confirm = [dic objectForKey:@"o_confirm"];
                 model.s_id = [dic objectForKey:@"s_id"];
                 model.tew_id = [dic objectForKey:@"tew_id"];
                 model.o_status = [dic objectForKey:@"o_status"];
                 model.o_last_edit_time = [dic objectForKey:@"o_last_edit_time"];
                 model.o_in_time = [dic objectForKey:@"o_in_time"];
                 model.o_amount = [dic objectForKey:@"o_amount"];
                 model.o_worker = [dic objectForKey:@"o_worker"];
                 model.u_id = [dic objectForKey:@"u_id"];
                 model.o_id = [dic objectForKey:@"o_id"];
                 
                 
                 
                 [dataArray addObject:model];
                 
             }
             
             
             [self.tableview reloadData];
         }
         
         
         
     } failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         
     }];
    
}








//删除订单， 假删
- (void)DDDDDdeldata: (NSString *)o_id index:(NSUInteger)index
{
    NSString *url = [NSString stringWithFormat:@"%@Orders/index?action=del2&o_worker=%@&o_id=%@", baseUrl, user_ID, o_id];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject)
     {
         NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         
         if ([[dictionary objectForKey:@"code"] integerValue] == 200)
         {
             NSString *msg = [dictionary objectForKey:@"data"];
             
             
             if ([msg isEqualToString:@"success"])
             {
                 [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
                 [SVProgressHUD showInfoWithStatus:@"取消成功"];
                 
                 [self performSelector:@selector(deleBtn) withObject:self afterDelay:1];
                 
                 [dataArray removeObjectAtIndex:index];
                 
                 [self.tableview reloadData];
             }
             else
             {
                 [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
                 [SVProgressHUD showInfoWithStatus:msg];
             }
             
             
         }
         
         
         
         
     } failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         
     }];
    
    
}

- (void)deleBtn
{
    [SVProgressHUD dismiss];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
