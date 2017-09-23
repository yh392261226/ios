//
//  MainViewController.m
//  worker
//
//  Created by 郭健 on 2017/7/27.
//  Copyright © 2017年 郭健. All rights reserved.

#import "MainViewController.h"
#import "TabbarView.h"
#import "MainTableViewCell.h"
#import "SelecdCityViewController.h"
#import "ProfessionViewController.h"
#import "SeachJobViewController.h"
#import "MineMessViewController.h"
#import "IssueViewController.h"


#import "PartyDismissViewController.h"

@interface MainViewController ()<UITableViewDataSource, UITableViewDelegate, BMKMapViewDelegate, BMKLocationServiceDelegate>
{
    TabbarView *tabbar;
    
    NSMutableArray *dataArray;
    
    BMKMapView *mapView;
    
    BMKLocationService *_locService;
    BMKGeoCodeSearch *_geocodesearch;
    
    NSMutableArray *imageArr;
    
    UILabel *num;     //主页右上角消息数量
    
    UILabel *adreeLab;
    
    
    
}


@property (nonatomic, strong)UITableView *tableview;

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    dataArray = [NSMutableArray arrayWithObjects:@" ",@" ",@" ", nil];
    
    imageArr = [NSMutableArray arrayWithObjects:@"main_image1",@"main_image2", @"main_image3", nil];

    self.navigationController.navigationBarHidden = YES;
    
    [self initHeadView];
    
    [self tableview];
    
    [self initBaiduMap];
    
}

//百度地图
- (void)initBaiduMap
{
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    //启动LocationService
    [_locService startUserLocationService];
    
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
            
            if (placemark != nil) {
                
                NSString *city = placemark.locality;
                
                NSLog(@"当前城市名称------%@",city);
                
                //找到了当前位置城市后就关闭服务
                
                [_locService stopUserLocationService];
                
                adreeLab.text = city;
                
            }
            
        }
        
    }];
    
    
}

#pragma Tableview

- (UITableView *)tableview
{
    if (!_tableview)
    {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 113) style:UITableViewStylePlain];
        
        [_tableview registerClass:[MainTableViewCell class] forCellReuseIdentifier:@"MainCell"];
        
        _tableview.backgroundColor = [myselfway stringTOColor:@"0xC4CED3"];
        
        _tableview.delegate = self;
        _tableview.dataSource = self;
        
        _tableview.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 15)];
        _tableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 15)];
        
        [self.view addSubview:_tableview];
        
        [_tableview mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.top.mas_equalTo(self.view).offset(44 + StatusBarHeigh);
             make.left.mas_equalTo(self.view).offset(0);
             make.right.mas_equalTo(self.view).offset(0);
             make.bottom.mas_equalTo(self.view).offset(SCREEN_HEIGHT - 44 - StatusBarHeigh);
         }];
    }
    
    return _tableview;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MainCell"];
    
    cell.backgroundColor = [myselfway stringTOColor:@"0xC4CED3"];
    
    cell.worker.image = [UIImage imageNamed:[imageArr objectAtIndex:indexPath.section]];
    
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

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    
    return view;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    self.hidesBottomBarWhenPushed = YES;
    
    if (indexPath.section == 0)
    {

       
        ProfessionViewController *temp = [[ProfessionViewController alloc] init];
        
        [self.navigationController pushViewController:temp animated:YES];
        
        
    }
    else if (indexPath.section == 1)
    {
        
        
        SeachJobViewController *temp = [[SeachJobViewController alloc] init];
        
        [self.navigationController pushViewController:temp animated:YES];
        
        
        
    }
    else
    {
        IssueViewController *temp = [[IssueViewController alloc] init];
        
        [self.navigationController pushViewController:temp animated:YES];
    }
    
    self.hidesBottomBarWhenPushed = NO;
    
}

















#pragma 自己定义的方法: button的点击事件等

//选择城市的按钮
- (void)selectBtn
{
    self.hidesBottomBarWhenPushed = YES;
    
    SelecdCityViewController *temp = [[SelecdCityViewController alloc] init];
    
    [self.navigationController pushViewController:temp animated:YES];
    
    self.hidesBottomBarWhenPushed = NO;
}



//加载头部view
- (void)initHeadView
{
    UIView *view = [[UIView alloc] init];
    
    view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:view];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.mas_equalTo(self.view).offset(0);
         make.left.mas_equalTo(self.view).offset(0);
         make.right.mas_equalTo(self.view).offset(0);
         make.height.mas_equalTo(44 + StatusBarHeigh);
     }];
    
    UILabel *headlabel = [[UILabel alloc] init];
    
    headlabel.text = @"钢建众工";
    
    [headlabel setTextColor:[myselfway stringTOColor:@"0x2E84F8"]];
    
    headlabel.textAlignment = NSTextAlignmentCenter;
    
    headlabel.font = [UIFont boldSystemFontOfSize:17];
    
    [view addSubview:headlabel];
    
    [headlabel mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.centerX.equalTo(view);
         make.bottom.mas_equalTo(view).offset(-6);
         make.height.mas_equalTo(30);
         make.width.mas_equalTo(200);
     }];
    
    adreeLab = [[UILabel alloc] init];
    
    adreeLab.text = @"定位中...";
    
    [adreeLab setTextColor:[myselfway stringTOColor:@"0x2E84F8"]];
    
    adreeLab.font = [UIFont boldSystemFontOfSize:17];
    
    [view addSubview:adreeLab];
    
    [adreeLab mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.bottom.mas_equalTo(view).offset(-12);
         make.left.mas_equalTo(view).offset(20);
         make.height.mas_equalTo(18);
         make.width.mas_equalTo(85);
     }];
    
    UIButton *adree = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [adree addTarget:self action:@selector(selectBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:adree];
    
    [adree mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.bottom.mas_equalTo(view).offset(-12);
         make.left.mas_equalTo(view).offset(10);
         make.height.mas_equalTo(20);
         make.width.mas_equalTo(100);
     }];
    
    
    UIButton *Mess = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [Mess setBackgroundImage:[UIImage imageNamed:@"main_mess"] forState:UIControlStateNormal];
    
    [Mess addTarget:self action:@selector(MessBtn) forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:Mess];
    
    [Mess mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.bottom.mas_equalTo(view).offset(-12);
         make.right.mas_equalTo(view).offset(-15);
         make.height.mas_equalTo(22);
         make.width.mas_equalTo(22);
     }];
    
    
    UIImageView *numback = [[UIImageView alloc] init];
    
    numback.layer.cornerRadius = 7.5;
    
    numback.backgroundColor = [UIColor redColor];
    
    [view addSubview:numback];
    
    [numback mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.bottom.mas_equalTo(view).offset(-27);
         make.right.mas_equalTo(view).offset(-10);
         make.height.mas_equalTo(15);
         make.width.mas_equalTo(15);
     }];
    
    
    
    
    
    num = [[UILabel alloc] init];
    num.textColor = [UIColor whiteColor];
    num.font = [UIFont systemFontOfSize:12];
    num.text = @"5";
    num.textAlignment = NSTextAlignmentCenter;
    [numback addSubview:num];
    
    [num mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.bottom.mas_equalTo(numback).offset(0);
         make.right.mas_equalTo(numback).offset(0);
         make.top.mas_equalTo(numback).offset(0);
         make.left.mas_equalTo(numback).offset(0);
     }];
    
    
}




//消息的点击事件
- (void)MessBtn
{
    self.hidesBottomBarWhenPushed = YES;
    
    MineMessViewController *temp = [[MineMessViewController alloc] init];
    
    [self.navigationController pushViewController:temp animated:YES];
    
    self.hidesBottomBarWhenPushed = NO;
}









- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
