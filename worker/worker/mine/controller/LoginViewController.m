//
//  LoginViewController.m
//  worker
//
//  Created by 郭健 on 2017/8/7.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginTableViewCell.h"
#import "BFirstAnsViewController.h"
#import "ServiceViewController.h"

@interface LoginViewController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, CLLocationManagerDelegate>
{
    
    NSMutableArray *dataArray;
    
    CGFloat longitude;   //经度
    CGFloat latitude;     //纬度
    
    NSString *userPhone;
    NSString *password;
    
    NSString *user;   //用户信息， 存到本地
    
    NSMutableArray *nameArrPlist;     //用户存往plist的数组
    
}

@property (strong, nonatomic) CLLocationManager *locationManager;  //系统定位

@property (nonatomic, strong)UITableView *tableview;

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    nameArrPlist = [NSMutableArray array];
    dataArray = [NSMutableArray array];

    [self initHeadView];
    
    [self tableview];
    
}

#pragma tableview的代理

- (UITableView *)tableview
{
    if (!_tableview)
    {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStyleGrouped];
        
        _tableview.delegate = self;
        _tableview.dataSource = self;
        
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _tableview.backgroundColor = [myselfway stringTOColor:@"0xC4CED3"];
        
        _tableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.1)];
        _tableview.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.1)];
        
        [_tableview registerClass:[LoginTableViewCell class] forCellReuseIdentifier:@"cell"];
        
        [self.view addSubview:_tableview];
        
        
        [_tableview mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.top.mas_equalTo(self.view).offset(44 + StatusBarHeigh);
             make.left.mas_equalTo(self.view).offset(0);
             make.right.mas_equalTo(self.view).offset(0);
             make.bottom.mas_equalTo(self.view).offset(SCREEN_HEIGHT - 44 - StatusBarHeigh);
         }];
        
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(30, SCREEN_HEIGHT - 60, 190, 30)];
        label.font = [UIFont systemFontOfSize:13];
        
        label.textColor = [UIColor grayColor];
        label.text = @"说明: 登录/注册代表您已经同意";
        label.textAlignment = NSTextAlignmentLeft;
        [self.view addSubview:label];
        
        
        
        UIButton *protocol = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [protocol setTitle:@"《钢建众工用户协议》" forState:UIControlStateNormal];
        
        [protocol setTitleColor:[myselfway stringTOColor:@"0x3E9FEA"] forState:UIControlStateNormal];
        
        [protocol addTarget:self action:@selector(protocolBtn) forControlEvents:UIControlEventTouchUpInside];
        
        protocol.titleLabel.font = [UIFont systemFontOfSize:13];
        
        [self.view addSubview:protocol];
        
        [protocol mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.bottom.mas_equalTo(self.view).offset(- 30);
            make.left.mas_equalTo(label).offset(175);
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(150);
        }];
        
    }
    
    return _tableview;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LoginTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    [cell.yanzhengma addTarget:self action:@selector(yanzhengmaBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.login addTarget:self action:@selector(loginBtn) forControlEvents:UIControlEventTouchUpInside];
    
    cell.textuser.delegate = self;
    cell.textpassword.delegate = self;
    
    
    cell.textuser.tag = 500;
    cell.textpassword.tag = 600;
    [cell.textuser addTarget:self action:@selector(changeBtn:) forControlEvents:UIControlEventEditingChanged];
    [cell.textpassword addTarget:self action:@selector(changeBtn:) forControlEvents:UIControlEventEditingChanged];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    
    return view;
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}


#pragma textfield的代理
//限制textfield的长度
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.tag == 600)
    {
        if (string.length == 0)
            
            return YES;
        
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > 6)
        {
            return NO;
        }
    }

    else
    {
        if (string.length == 0)
            
            return YES;
        
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > 11)
        {
            return NO;
        }
    }
    
    return YES;
    
}



#pragma 自定义的方法

//加载头部view
- (void)initHeadView
{
    self.view.backgroundColor = [myselfway stringTOColor:@"0xF3F3F3"];
    
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
    
    headlabel.text = @"登录";
    
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
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(temp) forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.bottom.mas_equalTo(view).offset(-12);
         make.left.mas_equalTo(view).offset(10);
         make.height.mas_equalTo(25);
         make.width.mas_equalTo(50);
     }];
    
    UIImageView *image = [[UIImageView alloc] init];
    image.image = [UIImage imageNamed:@"return"];
    
    [view addSubview:image];
    
    [image mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.bottom.mas_equalTo(view).offset(-8);
         make.left.mas_equalTo(view).offset(15);
         make.height.mas_equalTo(25);
         make.width.mas_equalTo(25);
     }];

    
}

//返回
- (void)temp
{
    [self dismissViewControllerAnimated:YES completion:nil];
}



#pragma 自己的方法
//获取手机号和验证码
- (void)changeBtn: (UITextField *)textfield
{
    if (textfield.tag == 500)
    {
        userPhone = textfield.text;
    }
    else
    {
        password = textfield.text;
    }
}


//点击验证码按钮
- (void)yanzhengmaBtn: (UIButton *)btn
{

    
    
    
    
    
    if (userPhone.length == 0)
    {
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD showInfoWithStatus:@"手机号为空"];
        
        [self performSelector:@selector(disBtn) withObject:self afterDelay:1.5];
    }
    else if (![self yanzhengshoujihao])
    {
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD showInfoWithStatus:@"请输入正确的手机号"];
        
        [self performSelector:@selector(disBtn) withObject:self afterDelay:1.5];
    }
    
    else
    {
        [self getdata:btn];
    }
    
    
}


//验证是否为手机号
- (BOOL)yanzhengshoujihao
{
    if (userPhone.length != 11)
    {
        return NO;
    }
    /**
     * 手机号码:
     * 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 17[6, 7, 8], 18[0-9], 170[0-9]
     * 移动号段: 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
     * 联通号段: 130,131,132,155,156,185,186,145,176,1709
     * 电信号段: 133,153,180,181,189,177,1700
     */
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[0678])\\d{8}$";
    /**
     * 中国移动：China Mobile
     * 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
     */
    NSString *CM = @"(^1(3[4-9]|4[7]|5[0-27-9]|7[8]|8[2-478])\\d{8}$)|(^1705\\d{7}$)";
    /**
     * 中国联通：China Unicom
     * 130,131,132,155,156,185,186,145,176,1709
     */
    NSString *CU = @"(^1(3[0-2]|4[5]|5[56]|7[6]|8[56])\\d{8}$)|(^1709\\d{7}$)";
    /**
     * 中国电信：China Telecom
     * 133,153,180,181,189,177,1700
     */
    NSString *CT = @"(^1(33|53|77|8[019])\\d{8}$)|(^1700\\d{7}$)";
    /**
     25     * 大陆地区固话及小灵通
     26     * 区号：010,020,021,022,023,024,025,027,028,029
     27     * 号码：七位或八位
     28     */
    //  NSString * PHS = @"^(0[0-9]{2})\\d{8}$|^(0[0-9]{3}(\\d{7,8}))$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    if (([regextestmobile evaluateWithObject:userPhone] == YES)
        || ([regextestcm evaluateWithObject:userPhone] == YES)
        || ([regextestct evaluateWithObject:userPhone] == YES)
        || ([regextestcu evaluateWithObject:userPhone] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
    
    
}



- (void)disBtn
{
    [SVProgressHUD dismiss];
}


//登录按钮
- (void)loginBtn
{
        //登录
    if (userPhone.length == 0)
    {
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD showInfoWithStatus:@"手机号为空"];
    }
    else if (password.length == 0)
    {
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD showInfoWithStatus:@"验证码为空"];
    }
    else
    {
        [self logindata];
        
    }
    
    
    [self performSelector:@selector(disBtn) withObject:self afterDelay:1.5];

}


//倒计数秒
- (void)time: (UIButton *)timebutton
{
    __block int timeout = 60; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(timeout <= 0)
        { //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置界面的按钮显示
                
                [timebutton setTitle:@"重新获取" forState:UIControlStateNormal];
                
                timebutton.userInteractionEnabled = YES;
                
                timebutton.backgroundColor = [myselfway stringTOColor:@"0x3E9FEA"];
                
            });
            
        }
        else
        {
            
            int seconds = timeout;
            
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //让按钮变为不可点击的灰色
                
                timebutton.backgroundColor = [UIColor grayColor];
                
                timebutton.userInteractionEnabled = NO;
                
                //设置界面的按钮显示
                
                [UIView beginAnimations:nil context:nil];
                
                [UIView setAnimationDuration:1];
                
                [timebutton setTitle:[NSString stringWithFormat:@"%@秒后重新发送",strTime] forState:UIControlStateNormal];
                
                [UIView commitAnimations];
                
            });
            
            timeout--;
            
        }
        
    });
    
    dispatch_resume(_timer);
}








//新浪微博第三方登录
- (void)getAuthWithUserInfoFromSina
{
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_Sina currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
            
        } else {
            UMSocialUserInfoResponse *resp = result;
            
            // 授权信息
            NSLog(@"Sina uid: %@", resp.uid);
            NSLog(@"Sina accessToken: %@", resp.accessToken);
            NSLog(@"Sina refreshToken: %@", resp.refreshToken);
            NSLog(@"Sina expiration: %@", resp.expiration);
            
            // 用户信息
            NSLog(@"Sina name: %@", resp.name);
            NSLog(@"Sina iconurl: %@", resp.iconurl);
            NSLog(@"Sina gender: %@", resp.unionGender);
            
            // 第三方平台SDK源数据
            NSLog(@"Sina originalResponse: %@", resp.originalResponse);
        }
    }];
}




//qq第三方登录
- (void)getAuthWithUserInfoFromQQ
{
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_QQ currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
            
        } else {
            UMSocialUserInfoResponse *resp = result;
            
            // 授权信息
            NSLog(@"QQ uid: %@", resp.uid);
            NSLog(@"QQ openid: %@", resp.openid);
            NSLog(@"QQ unionid: %@", resp.unionId);
            NSLog(@"QQ accessToken: %@", resp.accessToken);
            NSLog(@"QQ expiration: %@", resp.expiration);
            
            // 用户信息
            NSLog(@"QQ name: %@", resp.name);
            NSLog(@"QQ iconurl: %@", resp.iconurl);
            NSLog(@"QQ gender: %@", resp.unionGender);
            
            // 第三方平台SDK源数据
            NSLog(@"QQ originalResponse: %@", resp.originalResponse);
        }
    }];
}




//微信第三方登录
- (void)getAuthWithUserInfoFromWechat
{
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_WechatSession currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
            
        } else {
            UMSocialUserInfoResponse *resp = result;
            
            // 授权信息
            NSLog(@"Wechat uid: %@", resp.uid);
            NSLog(@"Wechat openid: %@", resp.openid);
            NSLog(@"Wechat unionid: %@", resp.unionId);
            NSLog(@"Wechat accessToken: %@", resp.accessToken);
            NSLog(@"Wechat refreshToken: %@", resp.refreshToken);
            NSLog(@"Wechat expiration: %@", resp.expiration);
            
            // 用户信息
            NSLog(@"Wechat name: %@", resp.name);
            NSLog(@"Wechat iconurl: %@", resp.iconurl);
            NSLog(@"Wechat gender: %@", resp.unionGender);
            
            // 第三方平台SDK源数据
            NSLog(@"Wechat originalResponse: %@", resp.originalResponse);
        }
    }];
}



//获取验证码接口
- (void)getdata: (UIButton *)btn
{
    NSString *url = [NSString stringWithFormat:@"%@Users/sendVerifyCode?phone_number=%@", baseUrl, userPhone];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject)
     {
         NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         
         if ([[dictionary objectForKey:@"code"] integerValue] == 1)
         {
             NSDictionary *dic = [dictionary objectForKey:@"data"];
             
             NSString *mess = [dic objectForKey:@"msg"];
             [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
             [SVProgressHUD showInfoWithStatus:mess];
             
             [self time:btn];
             
             
         }
         else
         {
             
         }
         
         
         
     } failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
         [SVProgressHUD showInfoWithStatus:@"请检查网络！"];
         
         [self performSelector:@selector(disBtn) withObject:self afterDelay:1.5];
     }];
    
    
}


//登录接口
- (void)logindata
{
    
    NSString *url = [NSString stringWithFormat:@"%@Users/login?phone_number=%@&verify_code=%@", baseUrl, userPhone, password];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject)
    {
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        if ([[dictionary objectForKey:@"code"] integerValue] == 1)
        {
            
            NSDictionary *dic = [dictionary objectForKey:@"data"];

            //储存账户
            [[NSUserDefaults standardUserDefaults] setObject:[dic objectForKey:@"u_id"] forKey:@"u_id"];
            [[NSUserDefaults standardUserDefaults] setObject:[dic objectForKey:@"u_img"] forKey:@"u_img"];
            [[NSUserDefaults standardUserDefaults] setObject:[dic objectForKey:@"u_name"] forKey:@"u_name"];
            [[NSUserDefaults standardUserDefaults] setObject:[dic objectForKey:@"u_online"] forKey:@"u_online"];
            [[NSUserDefaults standardUserDefaults] setObject:[dic objectForKey:@"u_sex"] forKey:@"u_sex"];
            [[NSUserDefaults standardUserDefaults] setObject:[dic objectForKey:@"u_pass"] forKey:@"u_pass"];
            [[NSUserDefaults standardUserDefaults] setObject:[dic objectForKey:@"u_idcard"] forKey:@"u_idcard"];
            [[NSUserDefaults standardUserDefaults] setObject:userPhone forKey:@"u_phone"];
            
            
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            
            //获取经纬度
            
            [self startLocation];
            
           
            
            
            
            
            [self dismissViewControllerAnimated:YES completion:nil];
            
            
            [self.delegate Sussecc];
            
        //多账号登录用， 做用户信息缓存
      //  [self cacheUser:dic];
            
            
            
        }
        else
        {
            

            
        }
        
        
        
    }
     failure:^(NSURLSessionDataTask *task, NSError *error)
    {
       [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD showInfoWithStatus:@"请检查网络！"];
        
        [self performSelector:@selector(disBtn) withObject:self afterDelay:1.5];
    }];
    
    
}


//用户信息缓存
- (void)cacheUser: (NSDictionary *)userDic
{

    NSFileManager *fileManager = [[NSFileManager alloc] init];
    
    NSString *pathDocuments = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    [Singleton instance].dataPath = [NSString stringWithFormat:@"%@/User", pathDocuments];
    
    
    NSString *str = [NSString stringWithFormat:@"%@/%@", [Singleton instance].dataPath, [userDic objectForKey:@"u_id"]];
    
    
     //判断文件夹是否存在，如果不存在，则创建
    if (![[NSFileManager defaultManager] fileExistsAtPath:str])
    {
        [fileManager createDirectoryAtPath:str withIntermediateDirectories:YES attributes:nil error:nil];
    }

    else
    {

    }
    
    //存储本地用户数据
    NSString *userInfo = [str stringByAppendingPathComponent:@"Info.plist"];
    
    [userDic writeToFile:userInfo atomically:YES];
    
    
    
    //获取本地的账号路径
    
    NSString *filePath = [[Singleton instance].dataPath stringByAppendingPathComponent:@"userName.plist"];
    
    NSMutableArray *arr = [NSMutableArray arrayWithContentsOfFile:filePath];
    
    
    
    if (arr.count == 0)
    {
        //记录登录过的账号的数据
        
        NSMutableDictionary *dicInfo = [NSMutableDictionary dictionary];
        
        [dicInfo setValue:[userDic objectForKey:@"u_id"] forKey:@"phone"];
        
        [nameArrPlist insertObject:dicInfo atIndex:0];
        
        [nameArrPlist writeToFile:filePath atomically:YES];
        
    }
    else
    {
        
        NSMutableArray *newArr = [NSMutableArray array];
        
        for (int i = 0; i < arr.count; i++)
        {
            NSDictionary *userdddDic = [arr objectAtIndex:i];
            
            [newArr addObject:userdddDic];
        }
        
        NSMutableDictionary *dicInfo = [NSMutableDictionary dictionary];
        
        [dicInfo setValue:[userDic objectForKey:@"u_id"] forKey:@"phone"];
        
        [newArr insertObject:dicInfo atIndex:0];
        
        [newArr writeToFile:filePath atomically:YES];
        
    }
    
    
    
    
   
    
}





//用工协议按钮
- (void)protocolBtn
{
    ServiceViewController *temp = [[ServiceViewController alloc] init];
    
    temp.type = @"1";
    
    [self presentViewController:temp animated:NO completion:nil];
}


//获取经纬度

- (void)startLocation
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
    
    
    
    //上传位置信息
    if (![user_ID isEqualToString:@"0"])
    {
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



@end
