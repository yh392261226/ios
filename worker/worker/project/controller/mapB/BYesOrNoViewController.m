//
//  BYesOrNoViewController.m
//  worker
//
//  Created by 郭健 on 2017/9/14.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "BYesOrNoViewController.h"
#import "PartyInfoViewController.h"
#import "PartyBrefuseViewController.h"
#import "PartyBclauseViewController.h"
#import "BYesWorkerViewController.h"

@interface BYesOrNoViewController ()<BMKLocationServiceDelegate, BMKMapViewDelegate>
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
    UIButton *noBtn;  //不想接此单按钮
    UILabel *yesLab;   //
    UIButton *yesBtn;   //开始干活按钮
    
    
    UILabel *time;   //时间字样

}

@property (nonatomic, strong)BMKMapView *mapView;
@property (nonatomic, strong)BMKLocationService *locService;


@end

@implementation BYesOrNoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    dataArray = [NSMutableArray array];
    
    
    [self addhead:@"待雇主就位"];
    
    [self initUI];
    
    [self initMapView];
    
    
}




- (void)initUI
{
    
    backview = [[[NSBundle mainBundle] loadNibNamed:@"Empty" owner:self options:nil] objectAtIndex:3];
    
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
    [noBtn setTitle:@"不想接此单" forState:UIControlStateNormal];
    noBtn.layer.cornerRadius = 6;
    noBtn.backgroundColor = [myselfway stringTOColor:@"0x249CD3"];
    
    
    
    
    yesLab = [backview viewWithTag:1018];
    
    
    
    
    yesBtn = [backview viewWithTag:1019];
    [yesBtn addTarget:self action:@selector(yesbtn) forControlEvents:UIControlEventTouchUpInside];
    yesBtn.backgroundColor = [myselfway stringTOColor:@"0xFC4154"];
    yesBtn.layer.cornerRadius = 6;
    [yesBtn setTitle:@"开始干活" forState:UIControlStateNormal];
    
    
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
                
                
                //找到了当前位置城市后就关闭服务
                
                [_locService stopUserLocationService];
                
            }
            
        }
        
    }];
    
    
    
}


//头像按钮， 进入工人详情
- (void)detailBtn
{
    PartyInfoViewController *temp = [[PartyInfoViewController alloc] init];
    
    [self.navigationController pushViewController:temp animated:YES];
}




//拨打电话按钮
- (void)callBtn
{
   
    
    
}




//不想接此单按钮
- (void)nobtn
{
    UIAlertController *alertcontroller = [UIAlertController alertControllerWithTitle:@"提示" message:@"确认不想接该工作？\n确认之后您将无法与Ta联系" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"在考虑考虑" style:UIAlertActionStyleCancel handler:nil];
    
    UIAlertAction *yAction = [UIAlertAction actionWithTitle:@"不想接此活" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
        PartyBrefuseViewController *temp = [[PartyBrefuseViewController alloc] init];
        
        [self.navigationController pushViewController:temp animated:YES];
        
    }];
    
    
    [alertcontroller addAction:action];
    [alertcontroller addAction:yAction];
    
    [self presentViewController:alertcontroller animated:YES completion:nil];
    
}



//开始干活按钮
- (void)yesbtn
{
    PartyBclauseViewController *temp = [[PartyBclauseViewController alloc] init];
    
    [self.navigationController pushViewController:temp animated:YES];
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
