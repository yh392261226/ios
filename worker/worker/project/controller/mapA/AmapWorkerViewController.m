//
//  AmapWorkerViewController.m
//  worker
//
//  Created by 郭健 on 2017/9/11.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "AmapWorkerViewController.h"
#import "PartyBinfoViewController.h"
#import "WorkerProjectViewController.h"
#import "LoginViewController.h"


#import "AYesOrNoViewController.h"

#import "BYesOrNoViewController.h"



@implementation missionData


@end



@interface worDetailData : NSObject

@property (nonatomic, strong)NSString *u_id;
@property (nonatomic, strong)NSString *u_name;
@property (nonatomic, strong)NSString *u_skills;
@property (nonatomic, strong)NSString *uei_info;
@property (nonatomic, strong)NSString *u_task_status;
@property (nonatomic, strong)NSString *u_true_name;
@property (nonatomic, strong)NSString *ucp_posit_x;
@property (nonatomic, strong)NSString *ucp_posit_y;
@property (nonatomic, strong)NSString *u_img;
@property (nonatomic, strong)NSString *is_fav;

@property (nonatomic, strong)NSString *u_mobile;
@property (nonatomic, strong)NSString *u_sex;
@property (nonatomic, strong)NSString *uei_address;
@property (nonatomic, strong)NSString *u_idcard;

@property (nonatomic, strong)NSString *relation;    //     雇主与工人是否存在关系:1存在0不存在
@property (nonatomic, strong)NSString *relation_type;     //     存在关系状态码:1是工作中 0是洽谈

@end

@implementation worDetailData


@end

@interface AmapWorkerViewController ()<BMKMapViewDelegate, BMKLocationServiceDelegate>
{
    NSMutableArray *dataArray;
    
    UIView *backview;    //页面下方的view

    UIButton *icon;   //头像
    UILabel *name;     //名字
    UIImageView *sex;   //性别
    UILabel *workerType;   //工人状态
    UILabel *worker;    //工种
    UIButton *call;     //电话按钮
    
    UIImageView *red;   //红点
    UIImageView *blue;  //蓝点
    
    UILabel *redLab;   //红点右面的文字
    UILabel *blueLab;  //蓝点右面的文字
    
    UIButton *yes;   //我要招工按钮
    
    
    NSMutableArray *missArray;    //任务数组
    
    
    NSString *workerID;  //工人id
    
    
    NSString *Xmap;
    NSString *Ymap;
    
    NSString *phone;
    
    BOOL phoneCall;
    
}

@property (nonatomic, strong)BMKMapView *mapView;
@property (nonatomic, strong)BMKLocationService *locService;


@property (nonatomic, strong) BMKGeoCodeSearch *geoCode;        // 地理编码

@property (nonatomic, assign) CGFloat longitude;  // 经度

@property (nonatomic, assign) CGFloat latitude; // 纬度

@end


@implementation AmapWorkerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    phoneCall = NO;


    dataArray = [NSMutableArray array];
    missArray = [NSMutableArray array];
    
    [self getdataMiss];
    
    [self initUI];
    

    [self getdata];

    [self addhead:@"工人位置"];


    
    
}





- (void)initUI
{
    
    backview = [[[NSBundle mainBundle] loadNibNamed:@"Empty" owner:self options:nil] objectAtIndex:0];
    
    backview.frame = CGRectMake(0, SCREEN_HEIGHT - 267, SCREEN_WIDTH, 267);

    [self.view addSubview:backview];

//    [backview mas_makeConstraints:^(MASConstraintMaker *make)
//    {
//        make.bottom.mas_equalTo(self.view).offset(0);
//        make.left.mas_equalTo(self.view).offset(0);
//        make.right.mas_equalTo(self.view).offset(0);
//        make.height.mas_equalTo(267);
//    }];


    icon = [backview viewWithTag:1001];
    icon.layer.cornerRadius = 35;
    icon.layer.masksToBounds = YES;
   // icon.backgroundColor = [UIColor orangeColor];
    [icon setBackgroundImage:[UIImage imageNamed:@"job_icon"] forState:UIControlStateNormal];
    [icon addTarget:self action:@selector(detailBtn) forControlEvents:UIControlEventTouchUpInside];


    name = [backview viewWithTag:1002];

    sex = [backview viewWithTag:1003];
    


    workerType = [backview viewWithTag:1004];
//    workerType.text = @"空闲";
    workerType.layer.masksToBounds = YES;
    workerType.layer.cornerRadius = 5;
    workerType.backgroundColor = [UIColor greenColor];
    workerType.textAlignment = NSTextAlignmentCenter;
    workerType.textColor = [UIColor whiteColor];
    workerType.font = [UIFont systemFontOfSize:14];


    worker = [backview viewWithTag:1005];
    worker.textColor = [UIColor grayColor];


    call = [backview viewWithTag:1006];
    [call addTarget:self action:@selector(callBtn) forControlEvents:UIControlEventTouchUpInside];


    red = [backview viewWithTag:1007];
    red.layer.masksToBounds = YES;
    red.layer.cornerRadius = 7.5;
    red.backgroundColor = [UIColor redColor];


    redLab = [backview viewWithTag:1008];
  //  redLab.text = @"完成过个人家装";
    redLab.textColor = [UIColor grayColor];
    redLab.font = [UIFont systemFontOfSize:15];


    blue = [backview viewWithTag:1009];
    blue.backgroundColor = [myselfway stringTOColor:@"0x249CD3"];
    blue.layer.masksToBounds = YES;
    blue.layer.cornerRadius = 7.5;


    blueLab = [backview viewWithTag:1010];
  //  blueLab.text = @"哈尔滨市第四中学，  开原街，  现据我0.9千米";
    blueLab.textColor = [UIColor grayColor];
    blueLab.font = [UIFont systemFontOfSize:15];


    yes = [backview viewWithTag:1011];
    yes.backgroundColor = [myselfway stringTOColor:@"0x249CD3"];
    yes.layer.cornerRadius = 7;
    [yes addTarget:self action:@selector(yesBtn) forControlEvents:UIControlEventTouchUpInside];
    
    


}




//加载百度地图
- (void)initMapView
{

    self.mapView = [[BMKMapView alloc] init];

    self.mapView.delegate = self;

    self.mapView.showsUserLocation = YES;

    self.mapView.zoomLevel = 15;

    [_mapView setMapType:BMKMapTypeStandard];

    //设置地图上是否显示比例尺
 //   self.mapView.showMapScaleBar = NO;

    //设置地图比例尺在地图上的位置
    self.mapView.mapScaleBarPosition = CGPointMake(200, 100);
    
    //开启路况
    [_mapView setTrafficEnabled:YES];

    //添加到view上
    [self.view addSubview:self.mapView];



    [self.mapView mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.top.mas_equalTo(self.view).offset(64);
        make.left.mas_equalTo(self.view).offset(0);
        make.right.mas_equalTo(self.view).offset(0);
        make.bottom.mas_equalTo(backview).offset(-267);
    }];

    

    BMKPointAnnotation *annotation = [[BMKPointAnnotation alloc] init];
    
    // annotationV.image = [UIImage imageNamed:@"5ud.png"];//大头针的显示图片
    CLLocationCoordinate2D coor;
    coor.latitude = [Ymap doubleValue];
    coor.longitude = [Xmap doubleValue];
    
    annotation.coordinate = coor;
    
    self.mapView.centerCoordinate = annotation.coordinate;
    
    [self.mapView addAnnotation:annotation];
    




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


- (void)viewWillAppear:(BOOL)animated
{
    [self.mapView viewWillAppear];
    self.mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.mapView viewWillDisappear];
    self.mapView.delegate = nil; // 不用时，置nil
}







//工人头像按钮， 进入工人详情页面
- (void)detailBtn
{
    PartyBinfoViewController *temp = [[PartyBinfoViewController alloc] init];

    temp.u_id = self.worker_id;

    [self.navigationController pushViewController:temp animated:YES];
}



//我要招工按钮
- (void)yesBtn
{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    
    if ([user_ID isEqualToString:@"0"] || user_ID == nil)
    {
        //未登录提示
        
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        
        [SVProgressHUD showErrorWithStatus:@"请您先登录"];
        
        

        LoginViewController *temp = [[LoginViewController alloc] init];
        
        
        [self presentViewController:temp animated:YES completion:nil];
        
    }
    else if ([user_u_idcard isEqualToString:@""] || user_u_idcard == NULL || [user_u_idcard isEqualToString:@""])
    {
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD showErrorWithStatus:@"请完善您的个人信息"];
    }
    else if (missArray.count == 0)
    {
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD showErrorWithStatus:@"您暂时没有发布与该工种相关任务"];
    }
    else
    {
        
        WorkerProjectViewController *temp = [[WorkerProjectViewController alloc] init];
        
        temp.delegate = self;
        
        temp.worker_id = workerID;
        
        temp.dataArray = missArray;
        
        temp.gongzhongID = self.skills_id;
        
        [self presentViewController:temp animated:YES completion:nil];
        
    }
    
    
    [self performSelector:@selector(disNO) withObject:self afterDelay:3];
    
  
}


- (void)disNO
{
    [SVProgressHUD dismiss];
}


//拨打电话按钮
- (void)callBtn
{
    if (phoneCall == YES)
    {
        NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"telprompt://%@", phone];
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }
    else
    {
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        
        [SVProgressHUD showErrorWithStatus:@"您还没有邀约，无法电话沟通"];
        
    }
    
    
}


//邀请成功的代理方法
- (void)success
{
    
    phoneCall = YES;
    
    [yes setTitle:@"邀约请求以发送" forState:UIControlStateNormal];

    yes.userInteractionEnabled = NO;
    
}




- (void)getdata
{
    NSString *url = [NSString stringWithFormat:@"%@Users/getUsers?u_id=%@&fu_id=%@&o_status=0,-3", baseUrl, self.worker_id, user_ID];

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
                 NSDictionary *dicInfo = [arr objectAtIndex:i];
                 worDetailData *data = [[worDetailData alloc] init];
                 
                 data.u_id = [dicInfo objectForKey:@"u_id"];
                 data.u_name = [dicInfo objectForKey:@"u_name"];
                 data.u_skills = [dicInfo objectForKey:@"u_skills"];
                 data.uei_info = [dicInfo objectForKey:@"uei_info"];
                 data.u_task_status = [dicInfo objectForKey:@"u_task_status"];
                 data.u_true_name = [dicInfo objectForKey:@"u_true_name"];
                 data.ucp_posit_x = [dicInfo objectForKey:@"ucp_posit_x"];
                 data.ucp_posit_y = [dicInfo objectForKey:@"ucp_posit_y"];
                 data.u_img = [dicInfo objectForKey:@"u_img"];
                 data.is_fav = [dicInfo objectForKey:@"is_fav"];

                 data.u_mobile = [dicInfo objectForKey:@"u_mobile"];
                 data.u_sex = [dicInfo objectForKey:@"u_sex"];
                 data.uei_address = [dicInfo objectForKey:@"uei_address"];
                 data.u_idcard = [dicInfo objectForKey:@"u_idcard"];
                 data.relation = [dicInfo objectForKey:@"relation"];
                 data.relation_type = [dicInfo objectForKey:@"relation_type"];
                 Xmap = data.ucp_posit_x;
                 Ymap = data.ucp_posit_y;
                 phone = data.u_mobile;
                 workerID = data.u_id;
                 

                 NSURL *url = [NSURL URLWithString:data.u_img];

                 [icon sd_setBackgroundImageWithURL:url forState:UIControlStateNormal];

                 name.text = data.u_name;

                 if ([data.u_sex isEqualToString:@"-1"])
                 {
                     sex.image = [UIImage imageNamed:@""];
                 }
                 else if ([data.u_sex isEqualToString:@"0"])
                 {
                     sex.image = [UIImage imageNamed:@"job_woman"];
                 }
                 else
                 {
                     sex.image = [UIImage imageNamed:@"job_man"];
                 }

                 
                 
                 if ([data.u_task_status isEqualToString:@"0"])
                 {
                     workerType.text = @"空闲";
                 }
                 else
                 {
                     workerType.text = @"工作中";
                     workerType.backgroundColor = [UIColor redColor];
                     
                     [yes setTitle:@"此工人正在工作中" forState:UIControlStateNormal];
                     
                     yes.userInteractionEnabled = NO;
                     
                     yes.backgroundColor = [UIColor redColor];
                 }

            


                 redLab.text = data.uei_info;
                 blueLab.text = data.uei_address;
                 
                 worker.text = self.workerNN;
                 

                 if ([data.u_id isEqualToString:user_ID])
                 {
                     [yes setTitle:@"您不能招工自己" forState:UIControlStateNormal];

                     yes.userInteractionEnabled = NO;
                     
                     yes.backgroundColor = [UIColor redColor];
                 }
                 else
                 {
                     if ([data.relation intValue] == 1)
                     {
                         if ([data.relation_type intValue] == 1)
                         {
                             [yes setTitle:@"此工人正在您的任务中工作" forState:UIControlStateNormal];
                             
                             phoneCall = YES;
                             
                             yes.userInteractionEnabled = NO;
                             
                             yes.backgroundColor = [UIColor redColor];
                         }
                         else if([data.relation_type intValue] == 0)
                         {
                             
                             [yes setTitle:@"此工人正在与您洽谈" forState:UIControlStateNormal];
                             
                             phoneCall = YES;
                             
                             yes.userInteractionEnabled = NO;
                             
                             yes.backgroundColor = [UIColor redColor];
                             
                         }
                     }
                     else
                     {
                         
                     }
                     
                 }
                 
                 
                
                 
                 
                 [self initMapView];
                 
             }




         }
     } failure:^(NSURLSessionDataTask *task, NSError *error)
     {

     }];


}









//任务数据网络请求
- (void)getdataMiss
{
    NSString *url = [NSString stringWithFormat:@"%@Tasks/index?t_author=%@&t_storage=0&t_status=0,1,5&skills=%@", baseUrl, user_ID, self.skills_id];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject)
     {
         NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         
         if ([[dictionary objectForKey:@"code"] integerValue] == 200)
         {
             NSArray *tem = [dictionary objectForKey:@"data"];
             
             for (int i = 0; i < tem.count; i++)
             {
                 NSDictionary *dic = [tem objectAtIndex:i];
                 
                 missionData *model = [[missionData alloc] init];
                 
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
     
                 model.t_storage = [dic objectForKey:@"t_storage"];
                 model.favorate = [dic objectForKey:@"favorate"];
                 
                 model.tew_id = [dic objectForKey:@"tew_id"];
                 model.tew_skills = [dic objectForKey:@"tew_skills"];
                 model.tew_worker_num = [dic objectForKey:@"tew_worker_num"];
                 model.tew_price = [dic objectForKey:@"tew_price"];
                 model.tew_start_time = [dic objectForKey:@"tew_start_time"];
                 model.tew_end_time = [dic objectForKey:@"tew_end_time"];
                 model.r_province = [dic objectForKey:@"r_province"];
                 model.r_city = [dic objectForKey:@"r_city"];
                 
                 model.tew_address = [dic objectForKey:@"tew_address"];
                 model.tew_lock = [dic objectForKey:@"tew_lock"];
                 model.r_city = [dic objectForKey:@"r_city"];
                 
                 
                 [missArray addObject:model];
                 
             }
             
             
           

         }
         
         
         
     } failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         
     }];
    
}







































- (void)didReceiveMemoryWarning
{
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}



@end
