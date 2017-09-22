//
//  BYesWorkerViewController.m
//  worker
//
//  Created by 郭健 on 2017/9/14.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "BYesWorkerViewController.h"
#import "PartyInfoViewController.h"
#import "PartyBdismissViewController.h"

#import "PartyBcommentViewController.h"

@interface BYesWorkerViewController ()<BMKLocationServiceDelegate, BMKMapViewDelegate>
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
    UIImageView *organer;  //黄点
    UIImageView *green;   //绿点
    
    UILabel *redLab;   //红点右面的文字
    UILabel *blueLab;  //蓝点右面的文字
    UILabel *organerLab;   //黄点右面的文字
    UILabel *greenLab;  //绿点右面的文字
    
    UILabel *bluelLabTo;
    
    
    UILabel *noLab;   //
    UIButton *noBtn;  //不想干了按钮
   
    
    
    UILabel *time;   //时间字样
}

@property (nonatomic, strong)BMKMapView *mapView;
@property (nonatomic, strong)BMKLocationService *locService;

@end

@implementation BYesWorkerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
    dataArray = [NSMutableArray array];
    
    
    [self addhead:@"已开工"];
    
    [self initUI];
    
    [self initMapView];
    
    
}


- (void)initUI
{
    
    backview = [[[NSBundle mainBundle] loadNibNamed:@"Empty" owner:self options:nil] objectAtIndex:4];
    
    [self.view addSubview:backview];
    
    [backview mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.bottom.mas_equalTo(self.view).offset(0);
         make.left.mas_equalTo(self.view).offset(0);
         make.right.mas_equalTo(self.view).offset(0);
         make.height.mas_equalTo(238);
     }];
    
    
    icon = [backview viewWithTag:1001];
    icon.layer.cornerRadius = 35;
    icon.backgroundColor = [UIColor orangeColor];
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
    
    
    red = [backview viewWithTag:1007];
    red.layer.masksToBounds = YES;
    red.layer.cornerRadius = 7.5;
    red.backgroundColor = [UIColor redColor];
    
    
    redLab = [backview viewWithTag:1008];
    //   redLab.text = @"";
    // redLab.textColor = [UIColor grayColor];
    redLab.font = [UIFont systemFontOfSize:15];
    
    organer = [backview viewWithTag:1009];
    organer.backgroundColor = [UIColor orangeColor];
    organer.layer.masksToBounds = YES;
    organer.layer.cornerRadius = 7.5;
    
    
    organerLab = [backview viewWithTag:1010];
    // organerLab.text = @"";
    
    organerLab.font = [UIFont systemFontOfSize:15];
    
    
    green = [backview viewWithTag:1011];
    green.layer.masksToBounds = YES;
    green.layer.cornerRadius = 7.5;
    green.backgroundColor = [UIColor greenColor];
    
    greenLab = [backview viewWithTag:1012];
    //  greenLab.text = @"";
    //  greenLab.textColor = [UIColor grayColor];
    greenLab.font = [UIFont systemFontOfSize:15];
    
    
    blue = [backview viewWithTag:1013];
    blue.layer.masksToBounds = YES;
    blue.layer.cornerRadius = 7.5;
    blue.backgroundColor = [UIColor blueColor];
    
    blueLab = [backview viewWithTag:1014];
    // blueLab.text = @"";
    //  greenLab.textColor = [UIColor grayColor];
    blueLab.font = [UIFont systemFontOfSize:15];
    
    
    bluelLabTo = [backview viewWithTag:1015];
    bluelLabTo.text = @"开原街  距离我0.9钱蜜蜜";
    bluelLabTo.textColor = [UIColor grayColor];
    bluelLabTo.font = [UIFont systemFontOfSize:15];
    
    
    noLab = [backview viewWithTag:1016];
    
    
    
    
    noBtn = [backview viewWithTag:1017];
    [noBtn addTarget:self action:@selector(nobtn) forControlEvents:UIControlEventTouchUpInside];
    [noBtn setTitle:@"不想干了" forState:UIControlStateNormal];
    noBtn.layer.cornerRadius = 6;
    noBtn.backgroundColor = [myselfway stringTOColor:@"0x249CD3"];
    
    
    
   
    
    
    time = [backview viewWithTag:2000];
    
    time.layer.borderColor = [myselfway stringTOColor:@"0x249CD3"].CGColor;
    time.layer.borderWidth = 1;
    time.font = [UIFont systemFontOfSize:15];
    time.text = @"2017年10月4号开工";
    time.textAlignment = NSTextAlignmentCenter;
    time.textColor = [myselfway stringTOColor:@"0x249CD3"];
    
    
}





//加载百度地图
- (void)initMapView
{
    
    self.mapView = [[BMKMapView alloc] init];
    
    self.mapView.delegate = self;
    
    self.mapView.showsUserLocation = YES;
    
    self.mapView.zoomLevel = 10;
    
    
    //添加到view上
    [self.view addSubview:self.mapView];
    
    
    [self.mapView mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.mas_equalTo(self.view).offset(64);
         make.left.mas_equalTo(self.view).offset(0);
         make.right.mas_equalTo(self.view).offset(0);
         make.bottom.mas_equalTo(backview).offset(-238);
     }];
    
    
    
    
    
    
    
    //定位
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    [_locService startUserLocationService];
    
    
    
    //个人位置蓝色图标设置
    BMKLocationViewDisplayParam *displayParam = [[BMKLocationViewDisplayParam alloc] init];
    displayParam.isRotateAngleValid = NO;
    displayParam.isAccuracyCircleShow = NO;
    displayParam.locationViewOffsetX = 0;//定位偏移量(经度)
    displayParam.locationViewOffsetY = 0;//定位偏移量（纬度）
    [self.mapView updateLocationViewWithParam:displayParam];
    
    
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




//获取经纬度，城市名称
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    BMKCoordinateRegion region;
    
    region.center.latitude  = userLocation.location.coordinate.latitude;
    
    region.center.longitude = userLocation.location.coordinate.longitude;
    
    region.span.latitudeDelta = 0;
    
    region.span.longitudeDelta = 0;
    
    NSLog(@"当前的坐标是:%f,%f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    [geocoder reverseGeocodeLocation: userLocation.location completionHandler:^(NSArray *array, NSError *error) {
        
        if (array.count > 0) {
            
            CLPlacemark *placemark = [array objectAtIndex:0];
            
            if (placemark != nil)
            {
                NSString *city = placemark.locality;
                
                NSLog(@"当前城市名称------%@",city);
                
                
                
                //找到了当前位置城市后就关闭服务
                
                [_locService stopUserLocationService];
                
            }
            
        }
        
    }];
    
    
    
}


//头像按钮， 进入工人详情
- (void)detailBtn
{
    PartyBcommentViewController *temp = [[PartyBcommentViewController alloc] init];
    
    [self.navigationController pushViewController:temp animated:YES];
    
    
//    PartyInfoViewController *temp = [[PartyInfoViewController alloc] init];
//    
//    [self.navigationController pushViewController:temp animated:YES];
}




//拨打电话按钮
- (void)callBtn
{
    
    PartyBdismissViewController *temp = [[PartyBdismissViewController alloc] init];
    
    [self.navigationController pushViewController:temp animated:YES];
    
}




//不想干了按钮
- (void)nobtn
{
    UIAlertController *alertcontroller = [UIAlertController alertControllerWithTitle:@"请与雇主先进行沟通再进行此项操作" message:@"当日辞职，雇主不需要支付您当日工资\n建议今日工作完毕后，明天再辞职" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"再考虑考虑" style:UIAlertActionStyleCancel handler:nil];
    
    UIAlertAction *yAction = [UIAlertAction actionWithTitle:@"我不干了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
    {
        
        [SVProgressHUD showInfoWithStatus:@"辞职通知已发送，等待雇主确认后结算工资"];
        
       // [self performSelector:@selector(infoYse) withObject:nil afterDelay:2];
        
        [noBtn setTitle:@"已发送辞职通知" forState:UIControlStateNormal];
        
        noBtn.backgroundColor = [UIColor grayColor];
        
        noBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        
        noBtn.userInteractionEnabled = NO;
        
        
    }];
    
    
    [alertcontroller addAction:action];
    [alertcontroller addAction:yAction];
    
    [self presentViewController:alertcontroller animated:YES completion:nil];
    
}


//- (void)infoYse
//{
//    [SVProgressHUD dismiss];
//}







- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}









@end
