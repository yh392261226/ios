//
//  AppDelegate.m
//  worker
//
//  Created by 郭健 on 2017/7/26.
//  Copyright © 2017年 郭健. All rights reserved.


#import "AppDelegate.h"
#import "JPUSHService.h"
#import <UserNotifications/UserNotifications.h>
#import <UMSocialCore/UMSocialCore.h>
#import "ViewpagerViewController.h"
#import "WorkerViewController.h"


#define UshareKey @"598278a7310c937245000d29"


@interface AppDelegate () <UISplitViewControllerDelegate, UITabBarControllerDelegate, JPUSHRegisterDelegate, WXApiDelegate, CLLocationManagerDelegate, BMKLocationServiceDelegate>
{
    CGFloat longitude;   //经度
    CGFloat latitude;     //纬度
    NSTimer *time;
    
    NSUserDefaults *useDef;
    
    
    
    
}

@property (strong, nonatomic) CLLocationManager *locationManager;  //系统定位




@end



@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    longitude = 0;
    latitude = 0;


    self.window = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    useDef = [NSUserDefaults standardUserDefaults];
    
    NSString *userName = [useDef objectForKey:@"firstName"];
    
    // 使用 NSUserDefaults 读取用户数据
    if (![userName isEqualToString:@"userId"])
    {
        
        
        //第一次引导页， 正常走
        //正常走
        [useDef setObject:@"userId" forKey:@"firstName"];
        
        _window.rootViewController = [[ViewpagerViewController alloc] init];
        
        

    }
    else
    {
        // 否则直接进入应用
        
        WorkerViewController *tabBarController = [[WorkerViewController alloc] init];
        
        self.window.rootViewController = tabBarController;

    } 
    
    [self BaiduMap];
    
    [self Jpush];
    
    [self Ushare];
    
    //   [WXApi registerApp：@"wxd930ea5d5a258f4f" withDescription：@"demo 2.0"];
    
    
    [WXApi registerApp:@"wx88a7414f850651c8"];    //注册微信， 一定要在友盟的后面
    
    
    //获取经纬度
    [self startLocation];
    
    
    time =  [NSTimer scheduledTimerWithTimeInterval:600 target:self selector:@selector(function:) userInfo:nil repeats:YES];
    
    
    [self.window makeKeyAndVisible];
    
   
    return YES;
    
}

//十分钟请求一次
- (void)function: (id)sender
{
    if ([user_ID integerValue] > 0 && longitude != 0 && latitude != 0)
    {
        //获取经纬度
        [self startLocation];
        
    }
}







- (void)disBtn
{
    [SVProgressHUD dismiss];
}






//友盟
- (void)Ushare
{
    /* 打开调试日志 */
    [[UMSocialManager defaultManager] openLog:YES];
    
    /* 设置友盟appkey */
    [[UMSocialManager defaultManager] setUmSocialAppkey:UshareKey];
    
    [self configUSharePlatforms];
    
    [self confitUShareSettings];
}

//设置系统回调
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
  
    
    
    return [WXApi handleOpenURL:url delegate:self];
    
    
    
}


- (void)confitUShareSettings
{
    /*
     * 打开图片水印
     */
    //[UMSocialGlobal shareInstance].isUsingWaterMark = YES;
    
    /*
     * 关闭强制验证https，可允许http图片分享，但需要在info.plist设置安全域名
     <key>NSAppTransportSecurity</key>
     <dict>
     <key>NSAllowsArbitraryLoads</key>
     <true/>
     </dict>
     */
    //[UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;
    
}


- (void)configUSharePlatforms
{
    /*
     设置微信的appKey和appSecret
     [微信平台从U-Share 4/5升级说明]http://dev.umeng.com/social/ios/%E8%BF%9B%E9%98%B6%E6%96%87%E6%A1%A3#1_1
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wx88a7414f850651c8" appSecret:@"3baf1193c85774b3fd9d18447d76cab0" redirectURL:nil];
    /*
     * 移除相应平台的分享，如微信收藏
     */
    //[[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite)]];
    
    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
     100424468.no permission of union id
     [QQ/QZone平台集成说明]http://dev.umeng.com/social/ios/%E8%BF%9B%E9%98%B6%E6%96%87%E6%A1%A3#1_3
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1105821097"/*设置QQ平台的appID*/  appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
    
    /*
     设置新浪的appKey和appSecret
     [新浪微博集成说明]http://dev.umeng.com/social/ios/%E8%BF%9B%E9%98%B6%E6%96%87%E6%A1%A3#1_2
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"3921700954"  appSecret:@"04b48b094faeb16683c32669824ebdad" redirectURL:@"https://sns.whalecloud.com/sina2/callback"];
    
    /* 钉钉的appKey */
    [[UMSocialManager defaultManager] setPlaform: UMSocialPlatformType_DingDing appKey:@"dingoalmlnohc0wggfedpk" appSecret:nil redirectURL:nil];
    
    /* 支付宝的appKey */
    [[UMSocialManager defaultManager] setPlaform: UMSocialPlatformType_AlipaySession appKey:@"2015111700822536" appSecret:nil redirectURL:nil];
    
    
}



//极光推送
- (void)Jpush
{
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0)
    {
        JPUSHRegisterEntity *entity = [[JPUSHRegisterEntity alloc] init];
        
        entity.types = UNAuthorizationOptionAlert|UNAuthorizationOptionBadge|UNAuthorizationOptionSound;
        
        [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    }
    else if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0)
    {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert) categories:nil];
        
    }
    else
    {
        //categories 必须为nil
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert) categories:nil];

    }
    NSDictionary *launchOptions = [NSDictionary dictionary];
    
    [JPUSHService setupWithOption:launchOptions appKey:@"246e2fe4b6e564597c8652f7"
                          channel:@"apple store"
                 apsForProduction:NO
            advertisingIdentifier:nil];
    
    // 这里是没有advertisingIdentifier的情况，有的话，大家在自行添加
    //注册远端消息通知获取device token
    
   
    
    
    
}


// ios 10 support 处于前台时接收到通知
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler { NSDictionary * userInfo = notification.request.content.userInfo; if ([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]])
    {
        [JPUSHService handleRemoteNotification:userInfo]; // 添加各种需求。。。。。
    }
    
    completionHandler(UNNotificationPresentationOptionAlert);
    // 处于前台时，添加需求，一般是弹出alert跟用户进行交互，这时候completionHandler(UNNotificationPresentationOptionAlert)这句话就可以注释掉了，这句话是系统的alert，显示在app的顶部，
}


// iOS 10 Support  点击处理事件
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler
{
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]])
    {
        [JPUSHService handleRemoteNotification:userInfo];
        //推送打开
        if (userInfo)
        {
            // 取得 APNs 标准信息内容 //
            NSDictionary *aps = [userInfo valueForKey:@"aps"];
            //
            NSString *content = [aps valueForKey:@"alert"]; //推送显示的内容 //
            NSInteger badge = [[aps valueForKey:@"badge"] integerValue];
            //badge数量 //
            NSString *sound = [aps valueForKey:@"sound"];
            //播放的声音
            
            // 添加各种需求。。。。。
            [JPUSHService handleRemoteNotification:userInfo]; completionHandler(UIBackgroundFetchResultNewData);
          }
    completionHandler();
    // 系统要求执行这个方法
    
    }
    
}



- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    
    completionHandler(UIBackgroundFetchResultNewData);
    
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive)
    {
        // 处于前台时 ，添加各种需求代码。。。。
    
    }
    else if ([UIApplication sharedApplication].applicationState == UIApplicationStateBackground)
    {
        // app 处于后台 ，添加各种需求
        
    }
        
        
}

//设置角标为0

//当程序被推送到后台的时候调用。所以要设置后台继续运行，则在这个函数里面设置即可
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [[UIApplication alloc] setApplicationIconBadgeNumber:0];
}



//点击之后badge清零

//当程序从后台将要重新回到前台时候调用

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [application setApplicationIconBadgeNumber:0];
    
    [[UNUserNotificationCenter alloc] removeAllPendingNotificationRequests];
}





    




//- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
//{
//    
//    /// Required - 注册 DeviceToken
//    [JPUSHService registerDeviceToken:deviceToken];
//    
//}
//
//
//- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
//{
//    //处理收到的 APNs 消息
//    [JPUSHService handleRemoteNotification:userInfo];
//    
//    
//}
//
//
//- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
//    
//    // IOS 7 Support Required
//    [JPUSHService handleRemoteNotification:userInfo];
//    completionHandler(UIBackgroundFetchResultNewData);
//}
//
//
//- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
//{
//    //Optional
//    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
//}



//集成百度地图
- (void)BaiduMap
{
    // 要使用百度地图，请先启动BaiduMapManager  _mapManager = [[BMKMapManager alloc] init]; // 如果要关注网络及授权验证事件，请设定 generalDelegate参数
    
    mapManager = [[BMKMapManager alloc] init];
    
    BOOL ret = [mapManager start:@"EMcgUVa9NRQe9EgILyKOrFv9l7Zj3iIv" generalDelegate:nil];
    
    if (!ret)
    {
        NSLog(@"manager start failed!");
    }
    
    
}








- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    return [WXApi handleOpenURL:url delegate:self];
}






//9.0后的方法
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options{
    //这里判断是否发起的请求为微信支付，如果是的话，用WXApi的方法调起微信客户端的支付页面（://pay 之前的那串字符串就是你的APPID，）
    return  [WXApi handleOpenURL:url delegate:self];
}


//微信SDK自带的方法，处理从微信客户端完成操作后返回程序之后的回调方法,显示支付结果的
- (void)onResp:(BaseResp *)resp
{
    //启动微信支付的response
    NSString *payResoult = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
    if([resp isKindOfClass:[PayResp class]])
    {
        //支付返回结果，实际支付结果需要去微信服务器端查询
        switch (resp.errCode)
        {
            case 0:
                payResoult = @"支付结果：成功！";
                break;
            case -1:
                payResoult = @"支付结果：失败！";
                break;
            case -2:
                payResoult = @"用户已经退出支付！";
                break;
            default:
                payResoult = [NSString stringWithFormat:@"支付结果：失败！ retcode = %d, retstr = %@", resp.errCode,resp.errStr];
                break;
        }
    }
}








- (void)applicationWillResignActive:(UIApplication *)application
{
  
}





- (void)applicationDidBecomeActive:(UIApplication *)application
{
    
}


- (void)applicationWillTerminate:(UIApplication *)application
{
   
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
   
    
    
    //系统定位坐标转换百度地图经纬度坐标
    CLLocationCoordinate2D test = CLLocationCoordinate2DMake(newLocation.coordinate.latitude, newLocation.coordinate.longitude);
    
    NSDictionary *testdic = BMKConvertBaiduCoorFrom(test,BMK_COORDTYPE_COMMON);
    //转换GPS坐标至百度坐标
    testdic = BMKConvertBaiduCoorFrom(test,BMK_COORDTYPE_GPS);
    
    CLLocationCoordinate2D trans = BMKCoorDictionaryDecode(testdic); //转换方法
    
    longitude = trans.longitude;
    latitude = trans.latitude;
    
    
    
    //位置信息上传服务器
    [self PostAdree];
    
    
    
    
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
                
                break;
            }
            
            
            
        }
        // 还原Device 的语言
        [[NSUserDefaults standardUserDefaults] setObject:userDefaultLanguages forKey:@"AppleLanguages"];
    }];
}

//上传经纬度
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
             NSLog(@"位置上传成功");
         }
         
         
         
     } failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         
     }];
    
    
}




// http://api.gangjianwang.com/ApplicationConfig/getAppConfig




@end
