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



#import "AYesOrNoViewController.h"

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
    
    
    dataArray = [NSMutableArray array];
    
    [self addhead:@"工人位置"];
    
    [self initUI];
    
    [self initMapView];
    
    
   
}





- (void)initUI
{
    
    backview = [[[NSBundle mainBundle] loadNibNamed:@"Empty" owner:self options:nil] objectAtIndex:0];
    
    [self.view addSubview:backview];
    
    [backview mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.bottom.mas_equalTo(self.view).offset(0);
        make.left.mas_equalTo(self.view).offset(0);
        make.right.mas_equalTo(self.view).offset(0);
        make.height.mas_equalTo(267);
    }];
    
    
    icon = [backview viewWithTag:1001];
    icon.layer.cornerRadius = 35;
    icon.backgroundColor = [UIColor orangeColor];
    [icon addTarget:self action:@selector(detailBtn) forControlEvents:UIControlEventTouchUpInside];
    
    
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
    
    
    call = [backview viewWithTag:1006];
    [call addTarget:self action:@selector(callBtn) forControlEvents:UIControlEventTouchUpInside];
    
    
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
    blueLab.text = @"哈尔滨市第四中学，  开原街，  现据我0.9千米";
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
    
    [self createBtn];
    
    [_mapView setMapType:BMKMapTypeStandard];
    
    //设置地图上是否显示比例尺
    self.mapView.showMapScaleBar = YES;
    
    //设置地图比例尺在地图上的位置
    self.mapView.mapScaleBarPosition = CGPointMake(200, 100);
    
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
    _locService = [[BMKLocationService alloc] init];
    _locService.delegate = self;
    [_locService startUserLocationService];
    
    
    
    //个人位置蓝色图标设置
    BMKLocationViewDisplayParam *displayParam = [[BMKLocationViewDisplayParam alloc] init];
    displayParam.isRotateAngleValid = NO;
    displayParam.isAccuracyCircleShow = NO;
    
    displayParam.locationViewOffsetX = 0;//定位偏移量(经度)
    displayParam.locationViewOffsetY = 0;//定位偏移量（纬度）
    [self.mapView updateLocationViewWithParam:displayParam];

    
     [self.mapView setShowsUserLocation:YES];//显示定位的蓝点儿
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

//创建按钮
- (void)createBtn
{
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    leftBtn.frame =CGRectMake(SCREEN_WIDTH*0.6,SCREEN_HEIGHT*0.93,60, 30);
    leftBtn.backgroundColor = [UIColor orangeColor];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"left_btn"]forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.mapView addSubview:leftBtn];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    rightBtn.backgroundColor = [UIColor greenColor];
    rightBtn.frame =CGRectMake(SCREEN_WIDTH*0.6+61,SCREEN_HEIGHT*0.93,60, 30);
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"right_btn"]forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightAction:)forControlEvents:UIControlEventTouchUpInside];
    [self.mapView addSubview:rightBtn];
}

//实现点击按钮地图放大和缩小，后面的数字表示，点击一次按钮放大或者缩小地图的等级数
- (void)leftBtnAction:(UIButton *)btn
{
    [_mapView setZoomLevel:_mapView.zoomLevel - 3];
}

- (void)rightAction:(UIButton *)btn
{
    [_mapView setZoomLevel:_mapView.zoomLevel + 3];
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
    
    //展示定位
    self.mapView.showsUserLocation = YES;
    
    //更新位置数据
    [self.mapView updateLocationData:userLocation];
    
    
    self.mapView.zoomLevel = 15;
    
    //获取自身的位置
    CLLocationCoordinate2D coor = CLLocationCoordinate2DMake(userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude);
    //将中心点设置为自身位置
    _mapView.centerCoordinate = coor;
    BMKPointAnnotation *annotation = [[BMKPointAnnotation alloc] init];
    annotation.coordinate = coor;
    [_mapView addAnnotation:annotation];
    [_mapView updateLocationData:userLocation];
    
}


//工人头像按钮， 进入工人详情页面
- (void)detailBtn
{
    PartyBinfoViewController *temp = [[PartyBinfoViewController alloc] init];
    
    [self.navigationController pushViewController:temp animated:YES];
}



//我要招工按钮
- (void)yesBtn
{
    WorkerProjectViewController *temp = [[WorkerProjectViewController alloc] init];
    
    temp.delegate = self;
    
    [self presentViewController:temp animated:YES completion:nil];
}


//拨打电话按钮
- (void)callBtn
{
    AYesOrNoViewController *temp = [[AYesOrNoViewController alloc] init];
    
    [self.navigationController pushViewController:temp animated:YES];
}


//邀请成功的代理方法
- (void)success
{
    [yes setTitle:@"邀约请求以发送" forState:UIControlStateNormal];
    
    yes.userInteractionEnabled = NO;
}






- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
