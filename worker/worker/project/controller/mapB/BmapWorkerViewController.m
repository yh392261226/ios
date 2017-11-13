//
//  BmapWorkerViewController.m
//  worker
//
//  Created by 郭健 on 2017/9/12.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "BmapWorkerViewController.h"
#import "PartyInfoViewController.h"
#import "BYesOrNoViewController.h"
#import "mapFirstguTableViewCell.h"
#import "mapTwoguTableViewCell.h"
#import "mapWorkerTableViewCell.h"
#import "PartyBinfoViewController.h"

@interface uiDataModel : NSObject

@property (nonatomic, strong)NSString *type;

@property (nonatomic, strong)NSString *icon;
@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSString *sex;
@property (nonatomic, strong)NSString *startTime;
@property (nonatomic, strong)NSString *workerName;


@property (nonatomic, strong)NSString *adree;
@property (nonatomic, strong)NSString *detail;



@property (nonatomic, strong)NSString *person;
@property (nonatomic, strong)NSString *money;
@property (nonatomic, strong)NSString *time;



@end


@implementation uiDataModel


@end

@implementation guzhuDetaillimian


@end
@implementation guzhuDetail


@end


@interface guzhuWorkerList : NSObject

@property (nonatomic, strong)NSString *s_id;
@property (nonatomic, strong)NSString *s_name;
@property (nonatomic, strong)NSString *s_info;
@property (nonatomic, strong)NSString *s_desc;
@property (nonatomic, strong)NSString *s_status;


@property (nonatomic, strong)NSString *s_image;


@end

@implementation guzhuWorkerList


@end


@interface BmapWorkerViewController ()<BMKMapViewDelegate, BMKLocationServiceDelegate, UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *dataArray;

    
    UIButton *yesBtn;    //我要接活按钮
    
    guzhuDetail *data;   //数据类
    
    NSMutableArray *workerArray;    //工种列表数组
    
    NSMutableArray *worAr;
    
    NSString *gongzhongName;  //工种名
    
    NSString *mapX;
    NSString *mapy;
    
    NSString *phone;  //电话
    
    NSString *guzhuID;  //雇主ID
}


@property (nonatomic, strong)UITableView *tableview;

@property (nonatomic, strong)BMKMapView *mapView;
@property (nonatomic, strong)BMKLocationService *locService;


@property (nonatomic, strong)BMKMapManager *mapManager;

@end



@implementation BmapWorkerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    workerArray = [NSMutableArray array];
    worAr = [NSMutableArray array];
    
    self.mapView = [[BMKMapView alloc] init];
    
    dataArray = [NSMutableArray array];
    
    index = [NSIndexPath indexPathForRow:2 inSection:0];
    
    
    [self getdata];
    
    [self addhead:@"雇主位置"];
    
    [self tableview];
    
    
    
    
    
    
}

//制作页面数据类
- (void)initUiData
{

    uiDataModel *model = [[uiDataModel alloc] init];
    
    model.type = @"1";
    
    model.icon = data.u_img;
    
    model.name = data.t_title;
    
    
    
    [dataArray addObject:model];
    
    
    
    
    uiDataModel *model1 = [[uiDataModel alloc] init];
    
    model1.type = @"2";
    
    model1.adree = data.t_adree;
    
    model1.detail = data.t_info;
    
    [dataArray addObject:model1];
    
    
    
    for (int i = 0; i < workerArray.count; i++)
    {
        guzhuDetaillimian *info = [workerArray objectAtIndex:i];
        
        uiDataModel *model10 = [[uiDataModel alloc] init];
        
        model10.type = @"0";

        model10.person = [NSString stringWithFormat:@"%ld", [info.remaining integerValue]];

        model10.money = info.tew_price;
        
        NSString *time1 = [myselfway timeWithTimeIntervalString:info.tew_start_time];
        NSString *time2 = [myselfway timeWithTimeIntervalString:info.tew_end_time];
        
        model10.time = [NSString stringWithFormat:@"%@ 一 %@", time1, time2];
        
        
        for (int k = 0; k < worAr.count; k++)
        {
            guzhuWorkerList *val = [worAr objectAtIndex:k];
            
            if ([val.s_id isEqualToString:info.tew_skills])
            {
                model10.workerName = val.s_name;
            }
        }
        
        
        
        [dataArray addObject:model10];
        
    }
    
    
    
    yesBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    yesBtn.backgroundColor = [myselfway stringTOColor:@"0x249CD3"];
    yesBtn.layer.cornerRadius = 7;
    yesBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [yesBtn setTitle:@"我要接活" forState:UIControlStateNormal];
    
    
    if ([data.t_author isEqualToString:user_ID])
    {
        [yesBtn setTitle:@"这是您本人发布的工作" forState:UIControlStateNormal];
        yesBtn.backgroundColor = [UIColor redColor];
        yesBtn.userInteractionEnabled = NO;
    }
    else
    {
        if ([data.relation isEqualToString:@"1"])
        {
            if ([data.relation_type isEqualToString:@"0"])
            {
                //与雇主洽谈关系
                [yesBtn setTitle:@"您与此工作正在洽谈" forState:UIControlStateNormal];
                yesBtn.backgroundColor = [UIColor redColor];
                yesBtn.userInteractionEnabled = NO;
            }
            else
            {
                //与雇主工作关系
                [yesBtn setTitle:@"您已经参与此工作" forState:UIControlStateNormal];
                yesBtn.backgroundColor = [UIColor redColor];
                yesBtn.userInteractionEnabled = NO;
            }
        }
    }
    
    
    
    
    
    [yesBtn addTarget:self action:@selector(yesBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:yesBtn];
    
    [yesBtn mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.bottom.mas_equalTo(self.view).offset(-10);
         make.left.mas_equalTo(self.view).offset(20);
         make.right.mas_equalTo(self.view).offset(-20);
         make.height.mas_equalTo(35);
     }];
    
    

    
    
}



//百度地图
- (void)initMap
{
    self.mapView.delegate = self;
    
    self.mapView.showsUserLocation = YES;
    
    self.mapView.zoomLevel = 15;
    
    
    //添加到view上
    [self.view addSubview:self.mapView];
    
    [self.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(64);
        make.height.mas_equalTo(300);
        make.left.mas_equalTo(self.view).offset(0);
        make.right.mas_equalTo(self.view).offset(0);
    }];
    
    
    // 添加一个PointAnnotation
    BMKPointAnnotation *annotation = [[BMKPointAnnotation alloc] init];
    CLLocationCoordinate2D coor;

    
    coor.latitude = [data.t_posit_y doubleValue];
    coor.longitude = [data.t_posit_x doubleValue];

    annotation.coordinate = coor;
    self.mapView.centerCoordinate = annotation.coordinate;

    [_mapView addAnnotation:annotation];
    

    
}



- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]])
    {
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        newAnnotationView.pinColor = BMKPinAnnotationColorPurple;
        newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
        return newAnnotationView;
    }
    return nil;
    
}



- (UITableView *)tableview
{
    if (!_tableview)
    {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 364, SCREEN_WIDTH, SCREEN_HEIGHT - 415) style:UITableViewStyleGrouped];
        
        _tableview.delegate = self;
        _tableview.dataSource = self;
        
        
        [_tableview registerClass:[mapFirstguTableViewCell class] forCellReuseIdentifier:@"Fircell"];
        [_tableview registerClass:[mapTwoguTableViewCell class] forCellReuseIdentifier:@"Twocell"];
        [_tableview registerClass:[mapWorkerTableViewCell class] forCellReuseIdentifier:@"nomcell"];
        
        [self.view addSubview:_tableview];
    }
    
    return _tableview;
}






- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    uiDataModel *model = [dataArray objectAtIndex:indexPath.row];
    
    if ([model.type isEqualToString:@"1"])
    {
        mapFirstguTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Fircell"];
        
        NSURL *url = [NSURL URLWithString:model.icon];
        
        [cell.call addTarget:self action:@selector(callBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.icon sd_setBackgroundImageWithURL:url forState:UIControlStateNormal];
        [cell.icon addTarget:self action:@selector(iconBtn) forControlEvents:UIControlEventTouchUpInside];
  
        cell.name.text = model.name;
        
        return cell;
        
    }
    else if ([model.type isEqualToString:@"2"])
    {
        
        mapTwoguTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        if (!cell)
        {
            cell = [[mapTwoguTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Twocell"];
            
            cell.dian2.hidden = YES;
            cell.money.hidden = YES;
            cell.seleced.hidden = YES;
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.dian.backgroundColor = [myselfway stringTOColor:@"0x009DD9"];
            cell.dian1.backgroundColor = [myselfway stringTOColor:@"0x009DD9"];
            
            cell.adree.text = model.adree;
            
            cell.detail.text = model.detail;
            
        }
        
     

        return cell;
    }
    else
    {
        mapTwoguTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        if (!cell)
        {
            cell = [[mapTwoguTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Twocell"];
            
            cell.adree.text = [NSString stringWithFormat:@"招%@%@人", model.workerName, model.person];
            
            cell.dian.backgroundColor = [myselfway stringTOColor:@"0xFF66FF"];
            cell.dian1.backgroundColor = [myselfway stringTOColor:@"0x66CC66"];
            cell.dian2.backgroundColor = [myselfway stringTOColor:@"0xFF9933"];
            
            cell.seleced.image = [UIImage imageNamed:@"job_back"];
            
            if (index == indexPath)
            {
                
                cell.seleced.image = [UIImage imageNamed:@"job_dd"];
                
            }
            
            cell.money.text = [NSString stringWithFormat:@"工资%@元/天", model.money];
            
            cell.detail.text = model.time;
            
        }
        

        return cell;
        
    }
    
 
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   // [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    uiDataModel *model = [dataArray objectAtIndex:indexPath.row];
    
    if ([model.type isEqualToString:@"0"])
    {
        index = indexPath;
        
        
        [self.tableview reloadData];
    }
   
    
}



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    
    

    
    
    return view;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    uiDataModel *model = [dataArray objectAtIndex:indexPath.row];
    
    if ([model.type isEqualToString:@"1"])
    {
        return 100;
    }
    else
    {
        return 60;
    }
  
}


- (void)callBtn
{
    NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"telprompt://%@", phone];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
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
             
             data = [[guzhuDetail alloc] init];
             
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
             
             
             phone = data.t_phone;
             guzhuID = data.t_id;
             
             for (int i = 0; i < data.t_workers.count; i++)
             {
                 guzhuDetaillimian *info = [[guzhuDetaillimian alloc] init];
                 
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
                 
                 NSInteger typeNum = [info.remaining integerValue];
                 
                 
                 if (typeNum == 0)
                 {

                 }
                 else
                 {
                     [workerArray addObject:info];
                 }

             }

             [self getdataWor];
             
             [self initMap];

         }
         
     }
         failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         
         

         }];
    
    
}







- (void)getdataWor
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
                 
                 guzhuWorkerList *data = [[guzhuWorkerList alloc] init];
                 
                 data.s_id = [dic objectForKey:@"s_id"];
                 data.s_desc = [dic objectForKey:@"s_desc"];
                 data.s_info = [dic objectForKey:@"s_info"];
                 data.s_name = [dic objectForKey:@"s_name"];
                 data.s_status = [dic objectForKey:@"s_status"];
                 
                 [worAr addObject:data];
                 
                 
             }
             
             
              [self initUiData];
             

              [self.tableview reloadData];
            
         }
         
         
         
     } failure:^(NSURLSessionDataTask *task, NSError *error)
     {
        
     }];
    
    
}

    

    


- (void)viewWillAppear:(BOOL)animated
{
    [self.mapView viewWillAppear];
    self.mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.mapView viewWillDisappear];
    self.mapView.delegate = nil; // 不用时，置nil
}



//雇主详情   头像按钮
- (void)iconBtn
{
    PartyBinfoViewController *temp = [[PartyBinfoViewController alloc] init];
    
    temp.u_id = guzhuID;
    
    [self.navigationController pushViewController:temp animated:YES];
}


//拨打电话按钮
- (void)callBtn: (UIButton *)btn
{
    
    NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"telprompt://%@", phone];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    
}




//我要接活按钮
- (void)yesBtn
{
    
    NSInteger num = index.row - 2;
    
    
    if (workerArray.count > 0)
    {
        guzhuDetaillimian *info = [workerArray objectAtIndex:num];
        
        NSLog(@"%@", info.tew_id);
        
        
        [self getdata:info.tew_id];
    }
    else
    {
        [SVProgressHUD setForegroundColor:[UIColor blackColor]];
        [SVProgressHUD setBackgroundColor:[myselfway stringTOColor:@"0xE6E7EE"]];
        [SVProgressHUD showErrorWithStatus:@"该任务已结束或暂无工作可接"];
    }
    

}






//成单接口
- (void)getdata: (NSString *)tew_id
{
    NSString *url = [NSString stringWithFormat:@"%@Orders/index?action=create&tew_id=%@&t_id=%@&o_worker=%@&o_sponsor=%@", baseUrl, tew_id , data.t_id , user_ID, user_ID];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject)
     {
         NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         
         if ([[dictionary objectForKey:@"code"] integerValue] == 200)
         {
             [SVProgressHUD setForegroundColor:[UIColor blackColor]];
             [SVProgressHUD setBackgroundColor:[myselfway stringTOColor:@"0xE6E7EE"]];
             [SVProgressHUD showSuccessWithStatus:@"求职邀约以发送 \n 等待雇主同意可进行电话沟通"];
             
             [self performSelector:@selector(Invitation) withObject:nil afterDelay:1.5];
             
             [yesBtn setTitle:@"邀约请求已发送" forState:UIControlStateNormal];
             
             yesBtn.userInteractionEnabled = NO;
         }
         
         
         
         
     } failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         
     }];
    
    
}






















//定时取消弹窗
- (void)Invitation
{
    [SVProgressHUD dismiss];
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
