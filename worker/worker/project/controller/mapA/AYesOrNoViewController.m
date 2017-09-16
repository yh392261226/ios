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


#import "AYesWorkerViewController.h"

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
    
}


@property (nonatomic, strong)BMKMapView *mapView;
@property (nonatomic, strong)BMKLocationService *locService;


@end

@implementation AYesOrNoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view
    
    dataArray = [NSMutableArray array];
    
    
    [self addhead:@"待工人就位"];
    
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
    [icon addTarget:self action:@selector(detailBtn) forControlEvents:UIControlEventTouchUpInside];
    
    
    name = [backview viewWithTag:1002];
    
    
    
    sex = [backview viewWithTag:1003];
    sex.image = [UIImage imageNamed:@"job_woman"];
    
    
    
    
    workerType = [backview viewWithTag:1004];
    workerType.text = @"洽谈中";
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
    
    bluelLabTo = [backview viewWithTag:1011];
    bluelLabTo.text = @"开原街  距离我0.9钱蜜蜜";
    bluelLabTo.textColor = [UIColor grayColor];
    bluelLabTo.font = [UIFont systemFontOfSize:15];
    
    
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
    [yesBtn setTitle:@"确认开工" forState:UIControlStateNormal];
    
    
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
         make.bottom.mas_equalTo(backview).offset(-292);
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


//头像按钮， 进入工人详情
- (void)detailBtn
{
    PartyBinfoViewController *temp = [[PartyBinfoViewController alloc] init];
    
    [self.navigationController pushViewController:temp animated:YES];
}




//拨打电话按钮
- (void)callBtn
{
    AYesWorkerViewController *temp = [[AYesWorkerViewController alloc] init];
    
    [self.navigationController pushViewController:temp animated:YES];
}




//取消工人按钮
- (void)nobtn
{
    UIAlertController *alertcontroller = [UIAlertController alertControllerWithTitle:@"提示" message:@"确认不想用该工人？\n确认之后您将无法与Ta取得联系" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"在考虑考虑" style:UIAlertActionStyleCancel handler:nil];
    
    UIAlertAction *yAction = [UIAlertAction actionWithTitle:@"不想用Ta" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
        PartyRefuseViewController *temp = [[PartyRefuseViewController alloc] init];
        
        [self.navigationController pushViewController:temp animated:YES];
        
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
    
    [self.navigationController pushViewController:temp animated:YES];
}


//代理发放， 传回确认开工信息
- (void)secuuss
{
    [yesBtn setTitle:@"等待工人确认" forState:UIControlStateNormal];
    yesBtn.userInteractionEnabled = NO;
    yesBtn.backgroundColor = [UIColor grayColor];
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
