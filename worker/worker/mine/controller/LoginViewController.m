//
//  LoginViewController.m
//  worker
//
//  Created by 郭健 on 2017/8/7.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginTableViewCell.h"

@interface LoginViewController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
{
    NSMutableArray *dataArray;
}

@property (nonatomic, strong)UITableView *tableview;

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
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
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, SCREEN_HEIGHT - 60, SCREEN_WIDTH - 40, 30)];
        label.font = [UIFont systemFontOfSize:13];
        
        label.textColor = [UIColor grayColor];
        label.text = @"说明: 登录/注册代表您已经同意《钢建众工用户协议》";
        label.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:label];
        
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
        if (existedLength - selectedLength + replaceLength > 11)
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
        if (existedLength - selectedLength + replaceLength > 4)
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

//点击验证码按钮
- (void)yanzhengmaBtn: (UIButton *)btn
{
    UITextField *field = [self.view viewWithTag:10001];
    
    if (field.text.length == 0)
    {
        [SVProgressHUD showInfoWithStatus:@"手机号为空"];
    }
    else
    {
        [self time:btn];
    }
    
}


//登录按钮
- (void)loginBtn
{
    UITextField *field = [self.view viewWithTag:10001];
    UITextField *fielf1 = [self.view viewWithTag:10002];
    
    if (field.text.length == 0)
    {
        [SVProgressHUD showInfoWithStatus:@"手机号为空"];
    }
    else if (fielf1.text.length == 1)
    {
        [SVProgressHUD showInfoWithStatus:@"验证码为空"];
    }
    else
    {
        NSLog(@"1");
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









@end
