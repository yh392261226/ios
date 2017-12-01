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

#import "HSDatePickerVC.h"
#import "PartyDismissViewController.h"




//内存五大分区    1.堆   (存放是自己声明开辟空间的对象)   例如:   UILabel *title = [UILabel alloc] init];
//             2.栈     (就是那些由编译器在需要的时候分配，  存储变量，存储的变量通常是局部变量，函数参数等)
//             3.自由存储区  (也是由malloc开辟分配的内存块，他和堆十分相似， 区别就是它是用free来结束自己的生命的)
//             4.常量存储区  (比较特殊的存储区，里面存放的是不允许修改的常量)         例如: NSString * const name = @"1";
//             5.代码区      (存放app代码)

#import "TextViewController.h"   //练习

@implementation cityData


@end


@implementation MessDataDetail


@end


@interface MainViewController ()<UITableViewDataSource, UITableViewDelegate, BMKMapViewDelegate, BMKLocationServiceDelegate, CLLocationManagerDelegate, HSDatePickerVCDelegate, UITabBarControllerDelegate, UITabBarDelegate>
{
    TabbarView *tabbar;
    
    NSMutableArray *dataArray;
    
    BMKMapView *mapView;
    
    BMKLocationService *_locService;
    BMKGeoCodeSearch *_geocodesearch;
    
    NSMutableArray *imageArr;
    
    UILabel *num;     //主页右上角消息数量
    
    UILabel *adreeLab;
    
    NSString *cityName;  //城市名称
    NSString *cityFirst; //城市名称首字母
    
    NSMutableArray *cityArray;   //城市大数组，缓存本地
    NSMutableArray *EnglishArray;   //存放字母的数组
    
    NSString *city_id;  //定位城市的ID， 传给服务器
    
    CGFloat longitude;   //经度
    CGFloat latitude;     //纬度
    
    
    
    NSMutableArray *MessArrayWor;   //消息的数组
    NSMutableArray *MessArraySys;   //消息的数组
    
    NSString *password;  //密码
    
    NSString *mima;
    
    UITextField *field;
    
    UIButton *button;
    
    
    NSTimer *timer;
}



@property (strong, nonatomic) CLLocationManager *locationManager;  //系统定位

@property (nonatomic, strong)UITableView *tableview;



@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tabBarController.delegate = self;
    
    
    
    [self getDataNum];
    
    
   
    
    
    
}



//加锁
- (void)postDataddd
{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD showWithStatus:@"请等待..."];
    
    NSString *url = [NSString stringWithFormat:@"%@Tools/lock", baseUrl];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject)
     {
         NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         
         if ([[dictionary objectForKey:@"code"] integerValue] == 200)
         {
             NSNumber *number = [dictionary objectForKey:@"data"];
             
             NSInteger i = [number integerValue];

             if (i < 0)
             {
                 //正常
                 MessArrayWor = [NSMutableArray array];
                 MessArraySys = [NSMutableArray array];
                 
                 if ([user_ID integerValue] > 0)
                 {
                     [self getMessSys];
                     //   [self getMessWor];
                 }
                 
                 
                 // [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"u_id"];
                 
                 
                 EnglishArray = [NSMutableArray array];
                 cityArray = [NSMutableArray array];
                 
                 dataArray = [NSMutableArray arrayWithObjects:@" ",@" ",@" ", nil];
                 
                 imageArr = [NSMutableArray arrayWithObjects:@"main_image1",@"main_image2", @"main_image3", nil];
                 
                 self.navigationController.navigationBarHidden = YES;
                 
                 [self initHeadView];
                 
                 [self tableview];
                 
                 [self hotdata];
                 
             }
             else if (i == 2)
             {
                 MessArrayWor = [NSMutableArray array];
                 MessArraySys = [NSMutableArray array];
                 
                 if ([user_ID integerValue] > 0)
                 {
                     [self getMessSys];
                     //   [self getMessWor];
                 }
                 
                 
                 // [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"u_id"];
                 
                 
                 EnglishArray = [NSMutableArray array];
                 cityArray = [NSMutableArray array];
                 
                 dataArray = [NSMutableArray arrayWithObjects:@" ",@" ",@" ", nil];
                 
                 imageArr = [NSMutableArray arrayWithObjects:@"main_image1",@"main_image2", @"main_image3", nil];
                 
                 self.navigationController.navigationBarHidden = YES;
                 
                 [self initHeadView];
                 
                 [self tableview];
                 
                 [self hotdata];
                 
             }
             else if (i == 1)
             {
                
                 field = [[UITextField alloc] init];
                 
                 [field becomeFirstResponder];
                 
                 field.placeholder = @"密码";
                 field.secureTextEntry = YES;
                 
                 field.borderStyle = UITextBorderStyleLine;
                 
                 [field addTarget:self action:@selector(password:) forControlEvents:UIControlEventEditingChanged];
                 
                 [self.view addSubview:field];
                 
                 [field mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                     make.centerX.mas_equalTo(self.view);
                     make.centerY.mas_equalTo(self.view);
                     make.height.mas_equalTo(35);
                     make.width.mas_equalTo(200);
                     
                 }];
                      
                
                 
                 button = [[UIButton alloc] init];
                 
                 [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                 
                 button.titleLabel.textAlignment = NSTextAlignmentCenter;
                 
                 [button setTitle:@"确认" forState:0];
                 
                 [button addTarget:self action:@selector(dianjiBttn) forControlEvents:UIControlEventTouchUpInside];
                
                 [self.view addSubview:button];
                 
                 [button mas_makeConstraints:^(MASConstraintMaker *make) {
                     
                     make.top.mas_equalTo(field).offset(40);
                     make.centerX.mas_equalTo(self.view);
                     make.height.mas_equalTo(35);
                     make.width.mas_equalTo(200);
                     
                 }];
                     
                 
                
               
                 
             }
             
         }
         
         
         
         
     } failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         [SVProgressHUD dismiss];
     }];
    
}


//获取编辑框密码
- (void)password: (UITextField *)textfield
{
    
    mima = textfield.text;
}



//加锁校验
- (void)dianjiBttn
{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    
    if (![mima isEqualToString:password])
    {
        
        [SVProgressHUD showErrorWithStatus:@"密码错误"];
        
        [self performSelector:@selector(disBtn) withObject:self afterDelay:1.5];
        
    }
    else
    {
        
        button.hidden = YES;
        field.hidden = YES;
        [self.view endEditing:YES];
        
        MessArrayWor = [NSMutableArray array];
        MessArraySys = [NSMutableArray array];
        
        if ([user_ID integerValue] > 0)
        {
            [self getMessSys];
            //        [self getMessWor];
        }
        
        
        // [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"u_id"];
        
        
        EnglishArray = [NSMutableArray array];
        cityArray = [NSMutableArray array];
        
        dataArray = [NSMutableArray arrayWithObjects:@" ",@" ",@" ", nil];
        
        imageArr = [NSMutableArray arrayWithObjects:@"main_image1",@"main_image2", @"main_image3", nil];
        
        self.navigationController.navigationBarHidden = YES;
        
        [self initHeadView];
        
        [self tableview];
        
        [self hotdata];
    }
    
}



- (void)disBtn
{
    [SVProgressHUD dismiss];
}

//获取密码
- (void)getDataNum
{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD showWithStatus:@"请等待..."];
    
    NSString *url = [NSString stringWithFormat:@"%@tools/internal", baseUrl];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject)
     {
         NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         
         if ([[dictionary objectForKey:@"code"] integerValue] == 200)
         {
             password = [dictionary objectForKey:@"data"];
             
             
             [self postDataddd];
         }
         
         [SVProgressHUD dismiss];
         
         
     } failure:^(NSURLSessionDataTask *task, NSError *error)
     {
       
     }];
    
}


//七星定位
-(void)startLocation
{
    
    if ([CLLocationManager locationServicesEnabled])
    {//判断定位操作是否被允许
        
        self.locationManager = [[CLLocationManager alloc] init];
        
        self.locationManager.delegate = self;//遵循代理
        
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        
        self.locationManager.distanceFilter = 10.0f;
        
        [_locationManager requestWhenInUseAuthorization];
        
        [self.locationManager startUpdatingLocation];//开始定位
        
    }
    else
    {
        
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:nil
                                                             message:@"您还没有授权本应用使用定位服务,请到 设置 > 隐私 > 位置 > 定位服务 中授权"
                                                            delegate:nil
                                                   cancelButtonTitle:@"确定"
                                                   otherButtonTitles:nil,  nil];
        [alertView show];
    }
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation
          fromLocation:(CLLocation *)oldLocation
{
    // 获取经纬度
//    NSLog(@"纬度:%f",newLocation.coordinate.latitude);
//    NSLog(@"经度:%f",newLocation.coordinate.longitude);
    
    
    //系统定位坐标转换百度地图经纬度坐标
    CLLocationCoordinate2D test = CLLocationCoordinate2DMake(newLocation.coordinate.latitude, newLocation.coordinate.longitude);
    
    NSDictionary *testdic = BMKConvertBaiduCoorFrom(test,BMK_COORDTYPE_COMMON);
    //转换GPS坐标至百度坐标
    testdic = BMKConvertBaiduCoorFrom(test,BMK_COORDTYPE_GPS);
    
    CLLocationCoordinate2D trans = BMKCoorDictionaryDecode(testdic); //转换方法
    
    longitude = trans.longitude;
    latitude = trans.latitude;
    

    if ([user_ID integerValue] > 0)
    {
        //位置信息上传服务器
        [self PostAdree];
    }
    


    
    
    // 停止位置更新
    [manager stopUpdatingLocation];
    
    // 保存 Device 的现语言 (英语 法语 ，，，)
    NSMutableArray *userDefaultLanguages = [[NSUserDefaults standardUserDefaults]
                                            objectForKey:@"AppleLanguages"];
    // 强制 成 简体中文
    [[NSUserDefaults standardUserDefaults] setObject:[NSArray arrayWithObjects:@"zh-hans",nil]
                                              forKey:@"AppleLanguages"];
    
    // 逆地理编码
    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        if(!error){
            for (CLPlacemark * placemark in placemarks)
            {
                cityName = [placemark locality];
                NSLog(@"cityName===》%@", cityName);//这里可看到输出为中文
                break;
            }
            
            adreeLab.text = cityName;
            
            //获取首字母
            [self getStrCity:cityName];
        }
        // 还原Device 的语言
        [[NSUserDefaults standardUserDefaults] setObject:userDefaultLanguages forKey:@"AppleLanguages"];
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
    
    NSString *iphone = [myselfway iphoneType];
    
    if ([iphone isEqualToString:@"iPhone X"])
    {
        return (SCREEN_HEIGHT - 183 - StatusBarHeigh) / 3;
    }
    else
    {
        return (SCREEN_HEIGHT - 153 - StatusBarHeigh) / 3;
    }

    
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
        temp.longitudeWor = longitude;
        temp.latitudeWor = latitude;
        temp.cityID = city_id;
        [self.navigationController pushViewController:temp animated:YES];

    }
    else if (indexPath.section == 1)
    {
        
        
        SeachJobViewController *temp = [[SeachJobViewController alloc] init];
        
        temp.longitudeWor = longitude;
        temp.latitudeWor = latitude;
        
        [self.navigationController pushViewController:temp animated:YES];
        
        
        
    }
    else
    {
        NSLog(@"%@  -  %@  -  %@", user_ID, user_u_idcard, user_pass);
        
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        
        if ([user_ID isEqualToString:@"0"] || user_ID == nil)
        {
            LoginViewController *temp = [[LoginViewController alloc] init];
            
            [self presentViewController:temp animated:YES completion:nil];
        }
        else if ([user_u_idcard isEqualToString:@"0"] || user_u_idcard == nil || user_u_idcard == NULL || [user_u_idcard isEqualToString:@""])
        {
            [SVProgressHUD showErrorWithStatus:@"请完善个人信息"];
        }
        else if (user_pass == nil || [user_pass isEqualToString:@"0"] || user_pass == NULL || [user_pass isEqualToString:@""])
        {
            [SVProgressHUD showErrorWithStatus:@"请设置提现密码"];
        }
        else
        {
            IssueViewController *temp = [[IssueViewController alloc] init];
            
            temp.longitudeWor = longitude;
            temp.latitudeWor = latitude;
            
            [self.navigationController pushViewController:temp animated:YES];
            
        }
        
    }
    
    self.hidesBottomBarWhenPushed = NO;
    
}

















#pragma 自己定义的方法: button的点击事件等

//选择城市的按钮
- (void)selectBtn
{
    self.hidesBottomBarWhenPushed = YES;
    
    SelecdCityViewController *temp = [[SelecdCityViewController alloc] init];

    temp.delegate = self;
    temp.EnglishArray = EnglishArray;
    temp.dataArray = cityArray;
    temp.cityN = cityName;

    [self.navigationController pushViewController:temp animated:YES];
    
    
    
    
    
    
//    TextViewController *temp = [[TextViewController alloc] init];
//
//    [self.navigationController pushViewController:temp animated:YES];
    
  
    
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
    
    headlabel.text = @"新用工";
    
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
    num.text = @"0";
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
    if([user_ID isEqualToString:@"0"] || user_ID == nil)
    {
        
        LoginViewController *temp = [[LoginViewController alloc] init];
        
        [self presentViewController:temp animated:YES completion:nil];

    }
    else
    {
        
        MineMessViewController *temp = [[MineMessViewController alloc] init];
        
        temp.delegate = self;
        
        [self.navigationController pushViewController:temp animated:YES];
        
    }
    
    self.hidesBottomBarWhenPushed = NO;
    
}


//回传数据，   控制消息个数
- (void)tempVaalllllll
{
    //网络获取消息个数
    [self getMessSys];
}



#pragma 城市列表数据获取，然后缓存到本地，城市列表页面从本地获取数据

//获取城市列表的数据，缓存本地
- (void)hotdata
{
    //[SVProgressHUD showWithStatus:@"加载中..."];
    
    NSString *url = [NSString stringWithFormat:@"%@%@", baseUrl, @"Regions/index?action=hot"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject)
     {
         NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         
         if ([[dictionary objectForKey:@"code"] integerValue] == 200)
         {
             NSArray *tem = [dictionary objectForKey:@"data"];
             
             NSMutableArray *cityHot = [NSMutableArray array];
             
             [EnglishArray addObject:@"热门城市"];
             
             for (int i = 0; i < tem.count; i++)
             {
                 NSDictionary *dic = [tem objectAtIndex:i];
                 
                 cityData *data = [[cityData alloc] init];
                 
                 data.r_id = [dic objectForKey:@"r_id"];
                 data.r_hot = [dic objectForKey:@"r_hot"];
                 data.r_pid = [dic objectForKey:@"r_pid"];
                 data.r_name = [dic objectForKey:@"r_name"];
                 data.r_first = [dic objectForKey:@"r_first"];
                 data.r_status = [dic objectForKey:@"r_status"];
                 data.r_shortname = [dic objectForKey:@"r_shortname"];
                 
                 [cityHot addObject:data];
                 
             }
             
             [cityArray addObject:cityHot];
             
             [self getdata];
             
         }
     } failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         
     }];
    
    
}


- (void)getdata
{
    
    NSString *url = [NSString stringWithFormat:@"%@%@", baseUrl, @"Regions/index?action=letter"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject)
     {
         NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         
         if ([[dictionary objectForKey:@"code"] integerValue] == 200)
         {
             NSDictionary *tem = [dictionary objectForKey:@"data"];
             
             NSMutableArray *allkey = (NSMutableArray *)[tem allKeys];
             
             //数组排序
             NSArray *sortResultArr = [allkey sortedArrayUsingSelector:@selector(compare:)];
             
             
             //制作所有head头的数组
             for (int k = 0; k < sortResultArr.count; k++)
             {
                 NSString *str = [sortResultArr objectAtIndex:k];
                 
                 [EnglishArray addObject:str];
             }
             
             for (int i = 0; i < sortResultArr.count; i++)
             {
                 NSArray *arr = [tem objectForKey:[sortResultArr objectAtIndex:i]];
                 
                 NSMutableArray *cityA = [NSMutableArray array];
                 
                 for (int j = 0; j < arr.count; j++)
                 {
                     NSDictionary *dic = [arr objectAtIndex:j];
                     
                     cityData *data = [[cityData alloc] init];
                     
                     data.r_id = [dic objectForKey:@"r_id"];
                     data.r_hot = [dic objectForKey:@"r_hot"];
                     data.r_pid = [dic objectForKey:@"r_pid"];
                     data.r_name = [dic objectForKey:@"r_name"];
                     data.r_first = [dic objectForKey:@"r_first"];
                     data.r_status = [dic objectForKey:@"r_status"];
                     data.r_shortname = [dic objectForKey:@"r_shortname"];
                     
                     
                     [cityA addObject:data];
                 }
                 
                 [cityArray addObject:cityA];
             }
             
             //网络请求成功之后获取定位城市信息
             
             [self startLocation];
         }
         
         
         
     } failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         
     }];
    
    
}


//去除定位城市的“市”字， 并且获取城市首字母， 用于查找城市ID， 传给服务器
- (void)getStrCity: (NSString *)city
{
    //去除“市”字
    NSString *city_Name = [city substringToIndex:[city length] - 1];
    
    //获取城市首字母
    NSMutableString *str = [NSMutableString stringWithString:city_Name];
    
    CFStringTransform((CFMutableStringRef) str, NULL, kCFStringTransformMandarinLatin, NO);
    
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformStripDiacritics, NO);
    
    NSString *pinYin = [str capitalizedString];
    
    NSString *TEACHERLower = [pinYin substringToIndex:1];
    
    //大小写转换
    cityFirst = [TEACHERLower lowercaseString];
    
    //记录在数组中是第多少个
    NSInteger num = 0;
    
    //城市首字母在数组中多少位
    for (int i = 0; i < EnglishArray.count; i++)
    {
        NSString *citySss = [EnglishArray objectAtIndex:i];
        
        if ([citySss isEqualToString:cityFirst])
        {
            num = i;
            
            break;
        }
        
    }
    
        NSArray *arr = [cityArray objectAtIndex:num];
        
        for (int k = 0; k < arr.count; k++)
        {
            cityData *data = [arr objectAtIndex:k];
            
            if ([data.r_name isEqualToString:city_Name])
            {
                city_id = data.r_id;
                
                NSLog(@"城市ID == %@", city_id);
            }
        }
    

}





- (void)PostAdree
{
    
    NSString *x = [NSString stringWithFormat:@"%f", longitude];
    NSString *y = [NSString stringWithFormat:@"%f", latitude];
    
    NSString *url = [NSString stringWithFormat:@"%@Users/updatePosition?u_id=%@&ucp_posit_x=%@&ucp_posit_y=%@", baseUrl, user_ID, x, y];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject)
     {
         NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         
         if ([[dictionary objectForKey:@"code"] integerValue] == 1)
         {
             
         }
         
         
         
     } failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         
     }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//选择城市的回传代理
- (void)cityNameT: (NSString *)city
{
    adreeLab.text = city;
}










//获取消息数据的网络请求   系统
- (void)getMessSys
{
    NSString *url = [NSString stringWithFormat:@"%@Users/msgList?u_id=%@&wm_type=0", baseUrl, @"198"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject)
     {
         NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         
         if ([[dictionary objectForKey:@"code"] integerValue] == 1)
         {
             NSDictionary *dic = [dictionary objectForKey:@"data"];
             
             NSArray *arr = [dic objectForKey:@"data"];
             
             [MessArraySys removeAllObjects];
             
             for (int i = 0; i < arr.count; i++)
             {
                 
                 NSDictionary *dic = [arr objectAtIndex:i];
                 
                 MessDataDetail *data = [[MessDataDetail alloc] init];
                 
                 data.wm_title = [dic objectForKey:@"wm_title"];
                 data.um_in_time = [dic objectForKey:@"um_in_time"];
                 data.wm_type = [dic objectForKey:@"wm_type"];
                 data.wm_id = [dic objectForKey:@"wm_id"];
                 data.um_id = [dic objectForKey:@"um_id"];
                 data.wm_desc = [dic objectForKey:@"wm_desc"];
                 data.um_status = [dic objectForKey:@"um_status"];
                 
                 if ([data.um_status isEqualToString:@"0"])
                 {
                     [MessArraySys addObject:data];
                 }
                 
                 
                 

             }
             
             
             [self getMessWor];
             
             
         }
         

     } failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         
     }];
    
    
}




//获取消息数据的网络请求   工作
- (void)getMessWor
{
    
    NSString *url = [NSString stringWithFormat:@"%@Users/msgList?u_id=%@&wm_type=1", baseUrl, user_ID];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject)
     {
         NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         
         if ([[dictionary objectForKey:@"code"] integerValue] == 1)
         {
             NSDictionary *dic = [dictionary objectForKey:@"data"];
             
             NSArray *arr = [dic objectForKey:@"data"];
             
             [MessArrayWor removeAllObjects];
             
             for (int i = 0; i < arr.count; i++)
             {
                 NSDictionary *dic = [arr objectAtIndex:i];
                 
                 MessDataDetail *data = [[MessDataDetail alloc] init];
                 
                 data.wm_title = [dic objectForKey:@"wm_title"];
                 data.um_in_time = [dic objectForKey:@"um_in_time"];
                 data.wm_type = [dic objectForKey:@"wm_type"];
                 data.wm_id = [dic objectForKey:@"wm_id"];
                 data.um_id = [dic objectForKey:@"um_id"];
                 data.wm_desc = [dic objectForKey:@"wm_desc"];
                 data.um_status = [dic objectForKey:@"um_status"];
                 
                 
                 if ([data.um_status isEqualToString:@"0"])
                 {
                     [MessArrayWor addObject:data];
                 }
                 
                 NSInteger price = MessArrayWor.count + MessArraySys.count;
                 
                 num.text = [NSString stringWithFormat:@"%ld", price];
                 
             }
             
             
         }
         
         
     } failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         
     }];
    
    
}




- (void)viewWillAppear:(BOOL)animated
{
    [self getMessSys];
    
    timer =  [NSTimer scheduledTimerWithTimeInterval:6 target:self selector:@selector(function:) userInfo:nil repeats:YES];
}




- (void)function: (id)sender
{
    [self getMessSys];
}




- (void)viewDidDisappear:(BOOL)animated
{
    
    [timer invalidate];  // 从运行循环中移除， 对运行循环的引用进行一次 release
    timer = nil;            // 将销毁定时器
    
}





@end
