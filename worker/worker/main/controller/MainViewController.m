//
//  MainViewController.m
//  worker
//
//  Created by 郭健 on 2017/7/27.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "MainViewController.h"
#import "TabbarView.h"
#import "MainTableViewCell.h"
#import "SelecdCityViewController.h"



@interface MainViewController ()<UITableViewDataSource, UITableViewDelegate, BMKLocationServiceDelegate>
{
    TabbarView *tabbar;
    
    NSArray *MainArray;
    
    BMKLocationService *location;
    
    NSString *City;    //百度定位来的当前成熟地址
    
    UILabel *adreeLab;   //首页左上角位置的数据
}


@property (nonatomic, strong)UITableView *tableview;

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    MainArray = [NSArray arrayWithObjects:@" ",@" ",@" ", nil];

    self.navigationController.navigationBarHidden = YES;
    
    [self initHeadView];
    
    [self initTabbar];
    
    [self tableview];
    
    [self startLocation];
    
}



#pragma 百度地图

//百度地图开始定位
- (void)startLocation
{
    location = [[BMKLocationService alloc] init];
    location.delegate = self;
    [location startUserLocationService];
}

//百度地图获取经纬度，城市名称的代理
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
                
                City = city;
                
                BMKOfflineMap * _offlineMap = [[BMKOfflineMap alloc] init];
                
                NSArray* records = [_offlineMap searchCity:city];
                
                BMKOLSearchRecord* oneRecord = [records objectAtIndex:0];
                
                //城市编码如:北京为131
                
                NSInteger cityId = oneRecord.cityID;
                
                NSLog(@"当前城市编号-------->%zd",cityId);
                
                //找到了当前位置城市后就关闭服务
                
                [location stopUserLocationService];
                
            }
            
        }
        
    }];
    
    adreeLab.text = City;
    
}

#pragma Tableview

- (UITableView *)tableview
{
    if (!_tableview)
    {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 113) style:UITableViewStyleGrouped];
        
        [_tableview registerClass:[MainTableViewCell class] forCellReuseIdentifier:@"MainCell"];
        
        _tableview.delegate = self;
        _tableview.dataSource = self;
        
        [self.view addSubview:_tableview];
    }
    
    return _tableview;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return MainArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MainCell"];
    
    
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (SCREEN_HEIGHT - 173) / 3;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 15;
    }
    else
    {
        return 0.1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 15;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0)
    {
        
    }
    else if (indexPath.section == 1)
    {
    
    }
    else
    {
    
    }
    
}

















#pragma 自己定义的方法: button的点击事件等

//选择城市的按钮
- (void)selectBtn
{
    SelecdCityViewController *temp = [[SelecdCityViewController alloc] init];
    
    [self.navigationController pushViewController:temp animated:YES];
    
}



//加载头部view
- (void)initHeadView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    
    view.backgroundColor = [myselfway stringTOColor:@"0x3E9FEA"];
    
    [self.view addSubview:view];
    
    UILabel *headlabel = [[UILabel alloc] init];
    
    headlabel.text = @"钢建众工";
    
    [headlabel setTextColor:[UIColor whiteColor]];
    
    headlabel.textAlignment = NSTextAlignmentCenter;
    
    headlabel.font = [UIFont systemFontOfSize:17];
    
    [self.view addSubview:headlabel];
    
    [headlabel mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.center.equalTo(self.view);
         make.bottom.mas_equalTo(view).offset(-7);
         make.height.mas_equalTo(30);
         make.width.mas_equalTo(200);
     }];
    
    adreeLab = [[UILabel alloc] init];
    
    adreeLab.text = @"全国";
    
    [adreeLab setTextColor:[UIColor whiteColor]];
    
    adreeLab.font = [UIFont systemFontOfSize:16];
    
    [self.view addSubview:adreeLab];
    
    [adreeLab mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.bottom.mas_equalTo(view).offset(-12);
         make.left.mas_equalTo(view).offset(25);
         make.height.mas_equalTo(18);
         make.width.mas_equalTo(80);
     }];
    
    UIButton *adree = [UIButton buttonWithType:UIButtonTypeCustom];
    [adree addTarget:self action:@selector(selectBtn) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:adree];
    
    [adree mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.bottom.mas_equalTo(view).offset(-12);
         make.left.mas_equalTo(view).offset(10);
         make.height.mas_equalTo(20);
         make.width.mas_equalTo(100);
     }];
    
    
    UIButton *Mess = [UIButton buttonWithType:UIButtonTypeCustom];
    [Mess addTarget:self action:@selector(MessBtn) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:Mess];
    
    [Mess mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.bottom.mas_equalTo(view).offset(-10);
         make.right.mas_equalTo(view).offset(-13);
         make.height.mas_equalTo(20);
         make.width.mas_equalTo(20);
     }];
    
}




//加载tabbar
- (void)initTabbar
{
    tabbar = [[TabbarView alloc] init];
    tabbar.frame = CGRectMake(0, SCREEN_HEIGHT - 49, SCREEN_WIDTH, 49);
    [tabbar.MainIcon addTarget:self action:@selector(MainBtn) forControlEvents:UIControlEventTouchUpInside];
    [tabbar.JobIcon addTarget:self action:@selector(JobBtn) forControlEvents:UIControlEventTouchUpInside];
    [tabbar.MessIcon addTarget:self action:@selector(MessBtn) forControlEvents:UIControlEventTouchUpInside];
    [tabbar.MineIcon addTarget:self action:@selector(MineBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:tabbar];
}

//tabbar首页点击事件
- (void)MainBtn
{
   
}

//tabbar工作管理点击事件
- (void)JobBtn
{
    
}

//tabbar优惠信息点击事件
- (void)MessBtn
{
    
}

//tabbar我的点击事件
- (void)MineBtn
{
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
