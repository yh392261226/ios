//
//  BmapWorkerViewController.m
//  worker
//
//  Created by 郭健 on 2017/9/12.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "BmapWorkerViewController.h"

@interface BmapWorkerViewController ()<BMKMapViewDelegate, BMKLocationServiceDelegate>
{
    NSMutableArray *dataArray;
    
    UIView *backview;     //页面下面的view
    
    
    UIImageView *icon;   //头像
    UILabel *name;     //名字
    UIImageView *sex;   //性别
    UILabel *workerType;   //工人状态
    UILabel *worker;    //工种
    UILabel *time;      //开工时间
    UIButton *call;     //电话按钮

    
    UIImageView *red;    //红点
    UILabel *redLab;    //红点文字
    
    UIImageView *oranger;   //黄点
    UILabel *orangerLab;    //黄点文字
    
    UIImageView *green;     //绿点
    UILabel *greenLab;      //绿点文字
    
    UIImageView *blue;      //蓝点
    UILabel *blueLab;       //蓝点文字
    
    
    UILabel *adree;    //地址文字
    
    UIButton *yes;    //我要接活按钮
    
    
    
    
}

@property (nonatomic, strong)BMKMapView *mapView;
@property (nonatomic, strong)BMKLocationService *locService;


@end

@implementation BmapWorkerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    dataArray = [NSMutableArray array];
    
    [self addhead:@"雇主位置"];
    
    [self initUI];
    
    [self initMapView];
    
    
}


//加载ui
- (void)initUI
{
    backview = [[[NSBundle mainBundle] loadNibNamed:@"Empty" owner:self options:nil] objectAtIndex:1];
    
    [self.view addSubview:backview];
    
    [backview mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.bottom.mas_equalTo(self.view).offset(0);
         make.left.mas_equalTo(self.view).offset(0);
         make.right.mas_equalTo(self.view).offset(0);
         make.height.mas_equalTo(267);
     }];
    
    
    
    icon = [backview viewWithTag:1001];
    icon.layer.masksToBounds = yes;
    icon.layer.cornerRadius = 35;
    icon.backgroundColor = [UIColor orangeColor];
    
    
    name = [backview viewWithTag:1002];
    
    
    
    sex = [backview viewWithTag:1003];
    sex.image = [UIImage imageNamed:@"job_woman"];
    
    
    
    
    workerType = [backview viewWithTag:1004];
    workerType.text = @"空闲";
    workerType.layer.masksToBounds = YES;
    workerType.layer.cornerRadius = 5;
    workerType.backgroundColor = [UIColor greenColor];
    workerType.textAlignment = NSTextAlignmentCenter;
    workerType.textColor = [UIColor whiteColor];
    workerType.font = [UIFont systemFontOfSize:14];
    
    
    worker = [backview viewWithTag:1005];
    worker.textColor = [UIColor grayColor];
    
    
    time = [backview viewWithTag:1006];
    time.layer.borderColor = [myselfway stringTOColor:@"0x249CD3"].CGColor;
    time.layer.borderWidth = 1;
    time.font = [UIFont systemFontOfSize:15];
    time.text = @"2017年10月4号开工";
    time.textAlignment = NSTextAlignmentCenter;
    time.textColor = [myselfway stringTOColor:@"0x249CD3"];
    
    
    call = [backview viewWithTag:1007];
    [call addTarget:self action:@selector(callBtn) forControlEvents:UIControlEventTouchUpInside];

    
    red = [backview viewWithTag:1008];
    red.layer.masksToBounds = YES;
    red.layer.cornerRadius = 7.5;
    red.backgroundColor = [UIColor redColor];
    
    
    
    redLab = [backview viewWithTag:1009];
    
    
    oranger = [backview viewWithTag:1010];
    oranger.layer.masksToBounds = YES;
    oranger.layer.cornerRadius = 7.5;
    oranger.backgroundColor = [UIColor orangeColor];
    
    orangerLab = [backview viewWithTag:1011];
    
    
    green = [backview viewWithTag:1012];
    green.layer.masksToBounds = YES;
    green.layer.cornerRadius = 7.5;
    green.backgroundColor = [UIColor greenColor];
    
    
    greenLab = [backview viewWithTag:1013];
    
    
    
    
    blue = [backview viewWithTag:1014];
    blue.layer.masksToBounds = YES;
    blue.layer.cornerRadius = 7.5;
    blue.backgroundColor = [UIColor blueColor];
    
    
    blueLab = [backview viewWithTag:1015];
    
    
    adree = [backview viewWithTag:1016];
    adree.textColor = [UIColor grayColor];
    
    
    yes = [backview viewWithTag:1017];
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
    
    self.mapView.zoomLevel = 10;
    
    
    //添加到view上
    [self.view addSubview:self.mapView];
    
    
    [self.mapView mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.mas_equalTo(self.view).offset(64);
         make.left.mas_equalTo(self.view).offset(0);
         make.right.mas_equalTo(self.view).offset(0);
         make.bottom.mas_equalTo(backview).offset(-267);
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
                
                BMKOfflineMap * _offlineMap = [[BMKOfflineMap alloc] init];
                
                //     _offlineMap.delegate = self;//可以不要
                
                NSArray* records = [_offlineMap searchCity:city];
                
                BMKOLSearchRecord* oneRecord = [records objectAtIndex:0];
                
                //城市编码如:北京为131
                
                NSInteger cityId = oneRecord.cityID;
                
                NSLog(@"当前城市编号-------->%zd",cityId);
                
                //找到了当前位置城市后就关闭服务
                
                [_locService stopUserLocationService];
                
            }
            
        }
        
    }];
    
    
    
}




//拨打电话按钮
- (void)callBtn
{
    NSLog(@"拨打");
}


//我要接活按钮
- (void)yesBtn
{
    NSLog(@"1接活");
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
