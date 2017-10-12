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
#import "ProtocolViewController.h"

@interface LoginViewController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
{
    NSMutableArray *dataArray;
    
    NSString *userPhone;
    NSString *password;
    
    NSString *user;   //用户信息， 存到本地
    
    NSMutableArray *nameArrPlist;     //用户存往plist的数组
    
}

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
    if (textField.tag == 10001)
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
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    
    view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:view];
    
    UILabel *headlabel = [[UILabel alloc] init];
    
    headlabel.text = @"登录";
    
    [headlabel setTextColor:[myselfway stringTOColor:@"0x2E84F8"]];
    
    headlabel.textAlignment = NSTextAlignmentCenter;
    
    headlabel.font = [UIFont boldSystemFontOfSize:17];
    
    [self.view addSubview:headlabel];
    
    [headlabel mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.center.equalTo(self.view);
         make.bottom.mas_equalTo(view).offset(-7);
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
        [SVProgressHUD showInfoWithStatus:@"手机号为空"];
    }
    else
    {
        [self getdata:btn];
    }
    
    
}


//登录按钮
- (void)loginBtn
{
        //登录
    if (userPhone.length == 0)
    {
        [SVProgressHUD showInfoWithStatus:@"手机号为空"];
    }
    else if (password.length == 0)
    {
        [SVProgressHUD showInfoWithStatus:@"验证码为空"];
    }
    else
    {
        [self logindata];
        
    }

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
             
             [SVProgressHUD showInfoWithStatus:mess];
             
             [self time:btn];
             
             
         }
         else
         {
             
         }
         
         
         
     } failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         
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
            
            NSLog(@"%@", [dic objectForKey:@"msg"]);
            
            //储存账户
            [[NSUserDefaults standardUserDefaults] setObject:[dic objectForKey:@"u_id"] forKey:@"u_id"];
            [[NSUserDefaults standardUserDefaults] setObject:[dic objectForKey:@"u_img"] forKey:@"u_img"];
            [[NSUserDefaults standardUserDefaults] setObject:[dic objectForKey:@"u_name"] forKey:@"u_name"];
            [[NSUserDefaults standardUserDefaults] setObject:[dic objectForKey:@"u_online"] forKey:@"u_online"];
            [[NSUserDefaults standardUserDefaults] setObject:[dic objectForKey:@"u_sex"] forKey:@"u_sex"];
            
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            
            
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
    ProtocolViewController *temp = [[ProtocolViewController alloc] init];
    
    [self presentViewController:temp animated:NO completion:nil];
}





@end
