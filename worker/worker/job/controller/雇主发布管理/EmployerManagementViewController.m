//
//  EmployerManagementViewController.m
//  worker
//
//  Created by 郭健 on 2017/8/8.
//  Copyright © 2017年 郭健. All rights reserved.
//




#import "EmployerManagementViewController.h"
#import "TypeView.h"
#import "OneTableViewCell.h"
#import "draftViewController.h"
#import "AYesOrNoViewController.h"
#import "ProDetailListViewController.h"
#import "ProfessionViewController.h"

@interface EmpDataModel : NSObject

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

@end


@implementation EmpDataModel


@end



@interface EmployerManagementViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *dataArray;
    
    TypeView *typeView;  //上面选择类型的view
    
    NSMutableArray *nameArr;   //类型上的view名字数组,传给自定义view
}

@property (nonatomic, strong)UITableView *tableview;

@end

@implementation EmployerManagementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self addhead:@"雇主发布管理"];
    
//    [self slitherBack:self.navigationController];
    
    dataArray = [NSMutableArray array];
    
    
    nameArr = [NSMutableArray arrayWithObjects:@"全部", @"待联系", @"洽谈中", @"进行中", @"已结束", nil];
    
    [self tableview];
    
    [self initTypeView];
    
  //  [self initDraft];
    
    
    //网络请求
    [self getdata:@"99"];
    

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
    EmpDataModel *model = [dataArray objectAtIndex:indexPath.section];

    OneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    [cell.favoriteBtn addTarget:self action:@selector(favoriteBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.favoriteBtn.hidden = YES;
    cell.details.hidden = YES;
    cell.distance.hidden = YES;
    
    cell.centerBtn.hidden = NO;
    cell.rightBtn.hidden = NO;
    
    cell.title.text = model.t_title;
    cell.introduce.text = model.t_info;
    
    
    if ([model.t_status isEqualToString:@"0"])
    {
        cell.state.image = [UIImage imageNamed:@"main_state1"];
       // [cell.centerBtn setTitle:@"" forState:0];
        cell.centerBtn.hidden = YES;
        [cell.rightBtn setTitle:@"取消发布" forState:0];
    }
    else if ([model.t_status isEqualToString:@"1"])
    {
        cell.state.image = [UIImage imageNamed:@"main_state3"];
        [cell.rightBtn setTitle:@"取消发布" forState:0];
        
        cell.centerBtn.hidden = YES;
    
    }
    else if ([model.t_status isEqualToString:@"2"] || [model.t_status isEqualToString:@"5"] || [model.t_status isEqualToString:@"-3"])
    {
        cell.state.image = [UIImage imageNamed:@"main_state5"];
        
        cell.centerBtn.hidden = YES;
        cell.rightBtn.hidden = YES;
        
    }
    else if([model.t_status isEqualToString:@"3"] || [model.t_status isEqualToString:@"4"])
    {
        
        cell.state.image = [UIImage imageNamed:@"main_state6"];
        cell.centerBtn.hidden = YES;
        [cell.rightBtn setTitle:@"删除信息" forState:0];
        
    }
    
    
    NSURL *url = [NSURL URLWithString:model.u_img];
    
    [cell.IconBtn sd_setImageWithURL:url];
    
    
    cell.leftBtn.tag = 100 + indexPath.section;
    //需求改动，暂时隐藏
    cell.leftBtn.hidden = YES;
    
    
    
    cell.centerBtn.tag = 200 + indexPath.section;
    cell.rightBtn.tag = 300 + indexPath.section;
    
    
 //   [cell.leftBtn addTarget:self action:@selector(leftbtn:) forControlEvents:UIControlEventTouchUpInside];
    [cell.centerBtn addTarget:self action:@selector(centerbtn:) forControlEvents:UIControlEventTouchUpInside];
    [cell.rightBtn addTarget:self action:@selector(rightbtn:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
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
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    EmpDataModel *model = [dataArray objectAtIndex:indexPath.section];
    
    if ([model.t_status isEqualToString:@"0"])
    {
       //空闲
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"还没有工人联系此单，是否主动邀约工人?" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action)
                          {
                              
                          }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"去邀约" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                          {
                              self.hidesBottomBarWhenPushed = YES;
                              
                              ProfessionViewController *temp = [[ProfessionViewController alloc] init];
                              
                              [self.navigationController pushViewController:temp animated:YES];
                           
                          }]];
        
        
        [self presentViewController:alert animated:YES completion:nil];
        
        
        
    }
    else if ([model.t_status isEqualToString:@"1"])
    {
        //洽谈
        self.hidesBottomBarWhenPushed = YES;
        
        ProDetailListViewController *temp = [[ProDetailListViewController alloc] init];
        
        temp.type = @"0";
        
        temp.t_id = model.t_id;
        
        [self.navigationController pushViewController:temp animated:YES];
        
    }
    else if ([model.t_status isEqualToString:@"2"] || [model.t_status isEqualToString:@"5"] || [model.t_status isEqualToString:@"-3"])
    {
        //工作中
        self.hidesBottomBarWhenPushed = YES;
        
        ProDetailListViewController *temp = [[ProDetailListViewController alloc] init];
        
        temp.t_id = model.t_id;
        
        temp.type = @"1";
        
        [self.navigationController pushViewController:temp animated:YES];
        
    }
    else if([model.t_status isEqualToString:@"4"] || [model.t_status isEqualToString:@"3"])
    {
        //完成
        
        self.hidesBottomBarWhenPushed = YES;
        
        ProDetailListViewController *temp = [[ProDetailListViewController alloc] init];
        
        temp.t_id = model.t_id;
        
        temp.type = @"2";
        
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
        [self getdata:@"99"];
    }
    else if (i == 1)
    {
        [self getdata:@"0"];
    }
    else if (i == 2)
    {
        [self getdata:@"1"];
    }
    else if(i == 3)
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
    NSInteger index = btn.tag - 200;
    
    EmpDataModel *model = [dataArray objectAtIndex:index];
    
    if ([model.t_status isEqualToString:@"0"])
    {
        
        
    }
    else if ([model.t_status isEqualToString:@"1"])
    {
        
        
    }
    else if ([model.t_status isEqualToString:@"2"] || [model.t_status isEqualToString:@"5"] || [model.t_status isEqualToString:@"-3"])
    {
        //进行
        
    }
    else if([model.t_status isEqualToString:@"3"] || [model.t_status isEqualToString:@"4"])
    {
     
        
    }
    
}




- (void)rightbtn: (UIButton *)btn
{
    
    NSInteger index = btn.tag - 300;
    
    NSString *inde = [NSString stringWithFormat:@"%ld", index];
    
    EmpDataModel *model = [dataArray objectAtIndex:index];
    
    if([model.t_status isEqualToString:@"3"] || [model.t_status isEqualToString:@"4"])
    {
        //结束
        [self DDDDDdeldata:model.t_id];
    }
    else if ([model.t_status isEqualToString:@"0"])
    {
        //空闲
        [self deldata:model.t_id index:inde];
    }
    else if ([model.t_status isEqualToString:@"1"])
    {
        //洽谈
        [self deldata:model.t_id index:inde];
  
    }
 
}





//收藏按钮点击
- (void)favoriteBtn: (UIButton *)btn
{
    NSLog(@"%ld", btn.tag);
}





//加载草稿箱
- (void)initDraft
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    
    [button setTitle:@"草稿箱" forState:0];
    
    [button addTarget:self action:@selector(Draft) forControlEvents:UIControlEventTouchUpInside];
    
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    [self.view addSubview:button];
    

    [button mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.mas_equalTo(self.view).offset(27.5);
         make.right.mas_equalTo(self.view).offset(-15);
         make.height.mas_equalTo(30);
         make.width.mas_equalTo(60);
     }];
    
}



//草稿箱点击事件
- (void)Draft
{
    self.hidesBottomBarWhenPushed = YES;
    
    draftViewController *temp = [[draftViewController alloc] init];
    
    [self.navigationController pushViewController:temp animated:YES];
    
}




//任务数据网络请求
- (void)getdata: (NSString *)t_status
{
    NSString *url;
    
    //雇主发布管理
    if ([t_status isEqualToString:@"99"])
    {
        url = [NSString stringWithFormat:@"%@Tasks/index?t_author=%@", baseUrl, user_ID];
    }
    else
    {
        if ([t_status isEqualToString:@"2"] || [t_status isEqualToString:@"5"])
        {
            url = [NSString stringWithFormat:@"%@Tasks/index?t_author=%@&t_status=%@", baseUrl, user_ID, @"2,5"];
        }
        else
        {
            url = [NSString stringWithFormat:@"%@Tasks/index?t_author=%@&t_status=%@", baseUrl, user_ID, t_status];
        }
        
    }
    
    
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
             
                 EmpDataModel *model = [[EmpDataModel alloc] init];
                 
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
                 
                 [dataArray addObject:model];
                 
             }
             
             
             [self.tableview reloadData];
             
         }
         
         
         
     } failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         
     }];
    
}



//删除订单， 真删
- (void)deldata: (NSString *)t_id index:(NSString *)index
{
    NSString *url = [NSString stringWithFormat:@"%@Tasks/index?action=del&t_id=%@&t_author=%@", baseUrl, t_id, user_ID];

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    [manager GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject)
     {
         NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];

         if ([[dictionary objectForKey:@"code"] integerValue] == 200)
         {
             
             NSString *msg = [dictionary objectForKey:@"data"];
             [SVProgressHUD setForegroundColor:[UIColor blackColor]];
             
             if ([msg isEqualToString:@"success"])
             {
                 [SVProgressHUD showInfoWithStatus:@"取消成功"];
                 
                 
             }
             else
             {
                 [SVProgressHUD showInfoWithStatus:@"取消失败，请检查网络"];
             }

             [self performSelector:@selector(deleBtn) withObject:self afterDelay:1];

         }



         
     } failure:^(NSURLSessionDataTask *task, NSError *error)
     {

     }];


}







//删除订单， 假删
- (void)DDDDDdeldata: (NSString *)t_id
{
    NSString *url = [NSString stringWithFormat:@"%@Tasks/index?action=del2&t_id=%@&t_author=%@", baseUrl, t_id, user_ID];
    
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
                 [SVProgressHUD setForegroundColor:[UIColor blackColor]];
                 [SVProgressHUD showInfoWithStatus:@"取消成功"];
                 
                 [self getdata:@"99"];
             }
             else
             {
                 [SVProgressHUD setForegroundColor:[UIColor blackColor]];
                 [SVProgressHUD showInfoWithStatus:@"取消失败，请检查网络"];
             }
             
             
             
             [self performSelector:@selector(deleBtn) withObject:self afterDelay:1];
             
             
            

         }
         
         
         
         
     } failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         
     }];
    
    
}

- (void)deleBtn
{
    [SVProgressHUD dismiss];
}



- (void)viewWillAppear:(BOOL)animated
{
    //获取缓存图片的大小(字节)
    NSUInteger bytesCache = [[SDImageCache sharedImageCache] getSize];
    
    //换算成 MB (注意iOS中的字节之间的换算是1000不是1024)
    float MBCache = bytesCache/1000/1000;
    
    //异步清除图片缓存 （磁盘中的）
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        [[SDImageCache sharedImageCache] clearDisk];
    });
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
