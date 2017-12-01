//
//  AYesOrNoViewController.m
//  worker
//
//  Created by 郭健 on 2017/9/13.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "AYesOrNoViewController.h"
#import "PartyBinfoViewController.h"
#import "PartyRefuseViewController.h"
#import "PartyClauseViewController.h"

#import "PartyBinfoViewController.h"
#import "AYesWorkerViewController.h"
#import "PartyDomplainViewController.h"



@interface AworDetailData : NSObject

@property (nonatomic, strong)NSString *u_id;
@property (nonatomic, strong)NSString *u_mobile;
@property (nonatomic, strong)NSString *u_idcard;
@property (nonatomic, strong)NSString *u_sex;
@property (nonatomic, strong)NSString *u_name;
@property (nonatomic, strong)NSString *u_skills;
@property (nonatomic, strong)NSString *uei_info;
@property (nonatomic, strong)NSString *u_task_status;
@property (nonatomic, strong)NSString *u_true_name;
@property (nonatomic, strong)NSString *ucp_posit_x;

@property (nonatomic, strong)NSString *ucp_posit_y;
@property (nonatomic, strong)NSString *uei_address;
@property (nonatomic, strong)NSString *u_high_opinions;
@property (nonatomic, strong)NSString *u_img;




@end

@implementation AworDetailData


@end






@interface AYesOrNoViewController ()<BMKMapViewDelegate, BMKLocationServiceDelegate>
{
    NSMutableArray *dataArray;
    
    UIView *backview;
    
    
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
    
    UILabel *bluelLabTo;
    
    
    UILabel *noLab;   //
    UIButton *noBtn;  //取消工人按钮
    UILabel *yesLab;   //
    UIButton *yesBtn;   //确认开工按钮
    
    NSString *Xmap;
    NSString *Ymap;
    
    NSString *worU_id;   //当前工人ID， 传给详情页面
    
    NSString *phone;
    
    
    NSMutableArray *workerArr;
    
    NSString *name1;  //姓名
    NSString *icon1;  //头像
    NSString *haoping1;  //评价
    NSString *sex1;
    NSString *worker_id;
    NSString *workerName;
}


@property (nonatomic, strong)BMKMapView *mapView;
@property (nonatomic, strong)BMKLocationService *locService;


@end

@implementation workerArrData1

@end

@implementation AYesOrNoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view
    
    dataArray = [NSMutableArray array];
    workerArr = [NSMutableArray array];
    
    self.mapView = [[BMKMapView alloc] init];
    
    [self addhead:@"待工人就位"];

    [self initUI];
    
    
    
    [self getdatawor];
    
  //  [self answer];
    [self initDraft];
    
}


//加载投诉按钮
- (void)initDraft
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    
    [button setTitle:@"投诉" forState:0];
    
    [button addTarget:self action:@selector(Draft) forControlEvents:UIControlEventTouchUpInside];
    
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    
    [button setTitleColor:[myselfway stringTOColor:@"0x2E84F8"] forState:UIControlStateNormal];
    
    [self.view addSubview:button];
    
    
    [button mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.mas_equalTo(self.view).offset(28.5);
         make.right.mas_equalTo(self.view).offset(-15);
         make.height.mas_equalTo(30);
         make.width.mas_equalTo(60);
     }];
    
    
}




//投诉按钮点击事件
- (void)Draft
{
    self.hidesBottomBarWhenPushed = YES;
    
    PartyDomplainViewController *temp = [[PartyDomplainViewController alloc] init];
    
    temp.type = @"2";
    
    temp.name = name1;
    temp.sex = sex1;
    temp.number = haoping1;
    temp.worker = worker_id;
    temp.workerName = self.worName;
    temp.icon = icon1;
    
    [self.navigationController pushViewController:temp animated:YES];
    
    
}


- (void)initUI
{
    backview = [[[NSBundle mainBundle] loadNibNamed:@"Empty" owner:self options:nil] objectAtIndex:2];
    
    [self.view addSubview:backview];
    
    [backview mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.bottom.mas_equalTo(self.view).offset(0);
         make.left.mas_equalTo(self.view).offset(0);
         make.right.mas_equalTo(self.view).offset(0);
         make.height.mas_equalTo(292);
     }];
    
    
    icon = [backview viewWithTag:1001];
    icon.layer.cornerRadius = 35;
    icon.layer.masksToBounds = YES;
  //  icon.backgroundColor = [UIColor orangeColor];
    [icon setBackgroundImage:[UIImage imageNamed:@"job_icon"] forState:UIControlStateNormal];
    [icon addTarget:self action:@selector(detailBtn) forControlEvents:UIControlEventTouchUpInside];
    
    
    name = [backview viewWithTag:1002];
    

    sex = [backview viewWithTag:1003];
    sex.image = [UIImage imageNamed:@"job_woman"];
    

    workerType = [backview viewWithTag:1004];
    
    workerType.layer.masksToBounds = YES;
    workerType.layer.cornerRadius = 5;
    workerType.backgroundColor = [UIColor orangeColor];
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
  
    redLab.textColor = [UIColor grayColor];
    redLab.font = [UIFont systemFontOfSize:15];
    
    
    blue = [backview viewWithTag:1009];
    blue.backgroundColor = [myselfway stringTOColor:@"0x249CD3"];
    blue.layer.masksToBounds = YES;
    blue.layer.cornerRadius = 7.5;
    
    
    
    blueLab = [backview viewWithTag:1010];
   
    blueLab.textColor = [UIColor grayColor];
    blueLab.font = [UIFont systemFontOfSize:15];
    
//    bluelLabTo = [backview viewWithTag:1011];
//
//    bluelLabTo.textColor = [UIColor grayColor];
//    bluelLabTo.font = [UIFont systemFontOfSize:15];
    
    
    noLab = [backview viewWithTag:1012];
    
    
    
    
    noBtn = [backview viewWithTag:1013];
    [noBtn addTarget:self action:@selector(nobtn) forControlEvents:UIControlEventTouchUpInside];
    [noBtn setTitle:@"取消工人" forState:UIControlStateNormal];
    noBtn.layer.cornerRadius = 6;
    noBtn.backgroundColor = [myselfway stringTOColor:@"0x249CD3"];
    

    yesLab = [backview viewWithTag:1014];
    
    
    
    
    yesBtn = [backview viewWithTag:1015];
    [yesBtn addTarget:self action:@selector(yesbtn) forControlEvents:UIControlEventTouchUpInside];
    yesBtn.backgroundColor = [myselfway stringTOColor:@"0xFC4154"];
    yesBtn.layer.cornerRadius = 6;
    
    
    if ([self.o_status isEqualToString:@"0"])
    {
        
        if ([self.o_confirm isEqualToString:@"0"])
        {
            [yesBtn setTitle:@"确认工资" forState:UIControlStateNormal];
        }
        else
        {
            
            [yesBtn setTitle:@"等待工人确认开工" forState:UIControlStateNormal];
            
            yesBtn.backgroundColor = [UIColor grayColor];
            
            yesBtn.titleLabel.font = [UIFont systemFontOfSize:11];
            
            yesBtn.userInteractionEnabled = NO;
            
        }
        
    }
    
    
    
    
    
    
}





//加载百度地图
- (void)initMapView
{
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
         make.bottom.mas_equalTo(backview).offset(-292);
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


-(void)viewWillDisappear:(BOOL)animated
{
    [self.mapView viewWillDisappear];
    self.mapView.delegate = nil; // 不用时，置nil
}



//头像按钮， 进入工人详情
- (void)detailBtn
{
    
    PartyBinfoViewController *temp = [[PartyBinfoViewController alloc] init];
    
    temp.u_id = self.o_worker;
    
    [self.navigationController pushViewController:temp animated:YES];
    
}




//拨打电话按钮
- (void)callBtn
{
    
    NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"telprompt://%@", phone];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    
}




//取消工人按钮
- (void)nobtn
{
    
    UIAlertController *alertcontroller = [UIAlertController alertControllerWithTitle:@"提示" message:@"确认不想用该工人？\n确认之后您将无法与Ta取得联系" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"在考虑考虑" style:UIAlertActionStyleCancel handler:nil];
    
    UIAlertAction *yAction = [UIAlertAction actionWithTitle:@"不想用Ta" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
        [self Noworker];
        
    }];
    
    
    
    [alertcontroller addAction:action];
    [alertcontroller addAction:yAction];
    
    
    [self presentViewController:alertcontroller animated:YES completion:nil];
    
}



//确认开工按钮
- (void)yesbtn
{
    PartyClauseViewController *temp = [[PartyClauseViewController alloc] init];
    
    temp.delegate = self;
    
    temp.o_id = self.o_id;
    temp.t_id = self.t_id;
    
    temp.o_worker = self.o_worker;
    temp.tew_id = self.tew_id;
    temp.worName = self.worNameMM;
    temp.person = self.person;
    temp.money = self.money;
    temp.startTime = self.startTime;
    temp.endTime = self.endTime;
    temp.skill = self.skill;
    
    [self.navigationController pushViewController:temp animated:YES];
    
    
}




//代理发放， 传回确认开工信息
- (void)secuuss
{
    [yesBtn setTitle:@"等待工人确认" forState:UIControlStateNormal];
    yesBtn.userInteractionEnabled = NO;
    yesBtn.backgroundColor = [UIColor grayColor];
}





- (void)getdata
{
    
    NSString *url = [NSString stringWithFormat:@"%@Users/getUsers?u_id=%@", baseUrl, self.worU_id];

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
                 AworDetailData *data = [[AworDetailData alloc] init];

                 data.u_id = [dicInfo objectForKey:@"u_id"];
                 data.u_mobile = [dicInfo objectForKey:@"u_mobile"];
                 data.u_idcard = [dicInfo objectForKey:@"u_idcard"];
                 data.u_sex = [dicInfo objectForKey:@"u_sex"];
                 data.u_name = [dicInfo objectForKey:@"u_name"];
                 data.u_skills = [dicInfo objectForKey:@"u_skills"];
                 data.uei_info = [dicInfo objectForKey:@"uei_info"];
                 data.u_task_status = [dicInfo objectForKey:@"u_task_status"];
                 data.u_true_name = [dicInfo objectForKey:@"u_true_name"];
                 data.ucp_posit_x = [dicInfo objectForKey:@"ucp_posit_x"];
                 data.u_high_opinions = [dicInfo objectForKey:@"u_high_opinions"];
                 data.ucp_posit_y = [dicInfo objectForKey:@"ucp_posit_y"];
                 data.uei_address = [dicInfo objectForKey:@"uei_address"];
                 data.u_img = [dicInfo objectForKey:@"u_img"];
                 
                 phone = data.u_mobile;
               
                 Xmap = data.ucp_posit_x;
                 Ymap = data.ucp_posit_y;

                 worU_id = data.u_id;
                 
                 name.text = data.u_true_name;
                 worker.text = self.worName;
                 
                 name1 = data.u_true_name;
                 sex1 = data.u_sex;
                 worker_id = data.u_id;
                 haoping1 = data.u_high_opinions;
                 icon1 = data.u_img;
                 
                 if ([data.u_sex isEqualToString:@"0"])
                 {
                     sex.image = [UIImage imageNamed:@"job_woman"];
                 }
                 else if ([data.u_sex isEqualToString:@"1"])
                 {
                     sex.image = [UIImage imageNamed:@"job_man"];
                 }
                 
                 
                 
                 if ([data.u_task_status isEqualToString:@"0"])
                 {
                     workerType.text = @"洽谈中";
                 }

                 
                 
                 [call setBackgroundImage:[UIImage imageNamed:@"mine_nocall"] forState:UIControlStateNormal];
                 
                 
                 redLab.text = data.uei_info;
                 
                 blueLab.text = data.uei_address;
                 

                 NSURL *url = [NSURL URLWithString:data.u_img];

                 [icon sd_setBackgroundImageWithURL:url forState:UIControlStateNormal];

                 
                 
                 
//                 for (int i = 0; i < workerArr.count; i++)
//                 {
//                     workerArrData1 *data1 = [workerArr objectAtIndex:i];
//
//                   NSString *string = [data.u_skills substringToIndex:2];//截取掉下标7之后的字符串
//                     NSLog(@"截取的值为：%@",string);
//                    string = [string substringFromIndex:1];//截取掉下标2之前的字符串
//                     NSLog(@"截取的值为：%@",string);
//
//                     if ([data1.s_id isEqualToString:string])
//                     {
//                         workerName = data1.s_name;
//                     }
//
//                 }
                 
                 
                  [self initMapView];
             }




         }
     } failure:^(NSURLSessionDataTask *task, NSError *error)
     {

     }];


}



//取消工人
- (void)Noworker
{
  //  NSString *url = [NSString stringWithFormat:@"%@Orders/index?action=cancel&o_id=%@&tew_id=%@&t_id=%@&o_worker=%@&u_id=%@&s_id=%@&o_confirm=%@&o_status=%@", baseUrl, self.o_id,self.tew_id, self.t_id,self.o_worker, user_ID, self.s_id, self.o_confirm, self.o_status];
    
    NSString *url = [NSString stringWithFormat:@"%@Orders/index?action=cancel&o_id=%@&sponsor=%@", baseUrl, self.o_id, user_ID];
    
    NSLog(@"%@", url);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject)
     {
         NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         
         if ([[dictionary objectForKey:@"code"] integerValue] == 200)
         {
             
             NSDictionary *dic = [dictionary objectForKey:@"data"];
             
             [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
             
             [SVProgressHUD showSuccessWithStatus:@"取消成功"];
             
             self.hidesBottomBarWhenPushed = YES;
             
             [self.navigationController popToRootViewControllerAnimated:YES];

             
         }
         
         
         
     } failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
         [SVProgressHUD showErrorWithStatus:@"网络连接失败"];
     }];
    
    
}



- (void)getdatawor
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
                 
                 workerArrData1 *data = [[workerArrData1 alloc] init];
                 
                 data.s_id = [dic objectForKey:@"s_id"];
                 data.s_desc = [dic objectForKey:@"s_desc"];
                 data.s_info = [dic objectForKey:@"s_info"];
                 data.s_name = [dic objectForKey:@"s_name"];
                 data.s_status = [dic objectForKey:@"s_status"];
                 
                 [workerArr addObject:data];
                 
                 
             }
             
             
             [self getdata];
             
          
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
