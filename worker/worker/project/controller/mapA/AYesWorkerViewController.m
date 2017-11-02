//
//  AYesWorkerViewController.m
//  worker
//
//  Created by 郭健 on 2017/9/13.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "AYesWorkerViewController.h"
#import "PartyBinfoViewController.h"
#import "PartyDismissViewController.h"
#import "PartyCommentViewController.h"

@interface BworDetailData : NSObject

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
@property (nonatomic, strong)NSString *u_img;




@end

@implementation BworDetailData


@end

@interface AYesWorkerViewController ()<BMKMapViewDelegate, BMKLocationServiceDelegate>
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
    UIButton *noBtn;  //解雇工人按钮
    UILabel *yesLab;   //
    UIButton *yesBtn;   //工程结束按钮
    
    
    NSString *Xmap;
    NSString *Ymap;
    NSString *worU_id;   //当前工人ID， 传给详情页面
    
    NSString *phone;
}

@property (nonatomic, strong)BMKMapView *mapView;
@property (nonatomic, strong)BMKLocationService *locService;

@end

@implementation AYesWorkerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    dataArray = [NSMutableArray array];
    
    self.mapView = [[BMKMapView alloc] init];
    
     [self getdata];
    [self addhead:@"已开工"];
    
    [self initUI];
    
    [self initMapView];
    
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
    icon.backgroundColor = [UIColor orangeColor];
    icon.layer.masksToBounds = YES;
    [icon addTarget:self action:@selector(detailBtn) forControlEvents:UIControlEventTouchUpInside];
    
    
    name = [backview viewWithTag:1002];
    
    
    
    sex = [backview viewWithTag:1003];
    sex.image = [UIImage imageNamed:@"job_woman"];
    

    workerType = [backview viewWithTag:1004];
    workerType.text = @"工作中";
    workerType.layer.masksToBounds = YES;
    workerType.layer.cornerRadius = 5;
    workerType.backgroundColor = [UIColor redColor];
    workerType.textAlignment = NSTextAlignmentCenter;
    workerType.textColor = [UIColor whiteColor];
    workerType.font = [UIFont systemFontOfSize:14];
    
    
    worker = [backview viewWithTag:1005];
    worker.textColor = [UIColor grayColor];
    
    
    call = [backview viewWithTag:1006];
    [call addTarget:self action:@selector(callBtn) forControlEvents:UIControlEventTouchUpInside];
    [call setBackgroundImage:[UIImage imageNamed:@"mine_call"] forState:UIControlStateNormal];
    
    
    red = [backview viewWithTag:1007];
    red.layer.masksToBounds = YES;
    red.layer.cornerRadius = 7.5;
    red.backgroundColor = [UIColor redColor];
    
    
    redLab = [backview viewWithTag:1008];
    redLab.text = @"完成过个人家装";
    redLab.textColor = [UIColor grayColor];
    redLab.font = [UIFont systemFontOfSize:15];
    
    
    blue = [backview viewWithTag:1009];
    blue.backgroundColor = [myselfway stringTOColor:@"0x249CD3"];
    blue.layer.masksToBounds = YES;
    blue.layer.cornerRadius = 7.5;
    
    
    blueLab = [backview viewWithTag:1010];
    blueLab.text = @"哈尔滨市第四中学";
    blueLab.textColor = [UIColor grayColor];
    blueLab.font = [UIFont systemFontOfSize:15];
    
//    bluelLabTo = [backview viewWithTag:1011];
//    bluelLabTo.text = @"开原街  距离我0.9钱蜜蜜";
//    bluelLabTo.textColor = [UIColor grayColor];
//    bluelLabTo.font = [UIFont systemFontOfSize:15];
//
//    bluelLabTo.hidden = YES;
    
    
    noLab = [backview viewWithTag:1012];
    
    
    
    
    noBtn = [backview viewWithTag:1013];
    [noBtn addTarget:self action:@selector(nobtn) forControlEvents:UIControlEventTouchUpInside];
    [noBtn setTitle:@"解雇工人" forState:UIControlStateNormal];
    noBtn.layer.cornerRadius = 6;
    noBtn.backgroundColor = [myselfway stringTOColor:@"0x249CD3"];
    
    
    yesLab = [backview viewWithTag:1014];


    
    
    yesLab.hidden = YES;

    yesBtn = [backview viewWithTag:1015];
 //   [yesBtn addTarget:self action:@selector(yesbtn) forControlEvents:UIControlEventTouchUpInside];
    yesBtn.backgroundColor = [myselfway stringTOColor:@"0xFC4154"];
    yesBtn.layer.cornerRadius = 6;
    [yesBtn setTitle:@"工程结束" forState:UIControlStateNormal];

    
    yesBtn.hidden = YES;
    
    
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
    coor.latitude = [Xmap doubleValue];
    coor.longitude = [Ymap doubleValue];
    
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




//解雇工人按钮
- (void)nobtn
{
    UIAlertController *alertcontroller = [UIAlertController alertControllerWithTitle:@"请与工人先进行沟通再进行此项操作" message:@"当日解雇工人需支付工人当日工资 \n建议今日工作完毕后再解雇工人" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"再考虑考虑" style:UIAlertActionStyleCancel handler:nil];
    
    UIAlertAction *yAction = [UIAlertAction actionWithTitle:@"我要解雇工人" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        PartyDismissViewController *temp = [[PartyDismissViewController alloc] init];
        
        temp.t_id = self.t_id;
        temp.o_worker = self.o_worker;
        temp.s_id = self.s_id;
        temp.tew_id = self.tew_id;
        temp.wornAME = self.worName;
        
        [self.navigationController pushViewController:temp animated:YES];
        
        
    }];
    
    
    [alertcontroller addAction:action];
    [alertcontroller addAction:yAction];
    
    [self presentViewController:alertcontroller animated:YES completion:nil];
    
}



//工程结束按钮
//- (void)yesbtn
//{
//    UIAlertController *alertcontroller = [UIAlertController alertControllerWithTitle:@"注意" message:@"确认完工后，您将付给工人相应的工资 \n 200元/人/天，工期2天，共400元 \n 是否确认已经完工？" preferredStyle:UIAlertControllerStyleAlert];
//
//    UIAlertAction *action = [UIAlertAction actionWithTitle:@"还未完工" style:UIAlertActionStyleCancel handler:nil];
//
//    UIAlertAction *yAction = [UIAlertAction actionWithTitle:@"确认完工" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//        PartyCommentViewController *temp = [[PartyCommentViewController alloc] init];
//
//        [self.navigationController pushViewController:temp animated:YES];
//
//
//    }];
//
//
//    [alertcontroller addAction:action];
//    [alertcontroller addAction:yAction];
//
//    [self presentViewController:alertcontroller animated:YES completion:nil];
//}




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
                 BworDetailData *data = [[BworDetailData alloc] init];
                 
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
                 
                 data.ucp_posit_y = [dicInfo objectForKey:@"ucp_posit_y"];
                 data.uei_address = [dicInfo objectForKey:@"uei_address"];
                 data.u_img = [dicInfo objectForKey:@"u_img"];
                 
                 Xmap = data.ucp_posit_x;
                 Ymap = data.ucp_posit_y;
                 
                 worU_id = data.u_id;
                 
                 name.text = data.u_true_name;
                 worker.text = self.worName;
                 
                 phone = data.u_mobile;
                 
                 if ([data.u_sex isEqualToString:@"0"])
                 {
                     sex.image = [UIImage imageNamed:@"job_woman"];
                 }
                 else if ([data.u_sex isEqualToString:@"1"])
                 {
                     sex.image = [UIImage imageNamed:@"job_man"];
                 }
                 
                 
                 
                 if ([data.u_task_status isEqualToString:@"1"])
                 {
                     workerType.text = @"工作中";
                 }
                 
                 
                 [call setBackgroundImage:[UIImage imageNamed:@"mine_call"] forState:UIControlStateNormal];
                 

                 redLab.text = data.uei_info;
                 
                 blueLab.text = data.uei_address;
                 
                 
                 NSURL *url = [NSURL URLWithString:data.u_img];
                 
                 [icon sd_setBackgroundImageWithURL:url forState:UIControlStateNormal];
                 
                 
                 
                 
             }
             
             
             
             
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
