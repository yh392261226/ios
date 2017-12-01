//
//  RemovePhoneViewController.m
//  worker
//
//  Created by 郭健 on 2017/8/31.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "RemovePhoneViewController.h"
#import "RemoveCardViewController.h"

@interface RemovePhoneViewController ()<UITextFieldDelegate>
{
    NSMutableArray *dataArray;
    
    UIView *phoneView;     //编辑框的view
    
    UITextField *passwordNum;    //密码
    
    NSInteger secondsCountDown;   //倒计数秒60秒
    
    NSTimer *countDownTimer;
    
    UILabel *time;     //倒计数秒的label
    
    UIButton *again;   //重新获取的按钮
    
    NSString *yanzhengma;   //验证码
}



@end

@implementation RemovePhoneViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [myselfway stringTOColor:@"0xC4CED3"];
    
    [self addhead:@"重置提现密码"];
    
    [self postData];
    
    
    
}



- (void)initUI
{
    UILabel *title = [[UILabel alloc] init];
    
    title.font = [UIFont systemFontOfSize:17];
    
    title.textAlignment = NSTextAlignmentCenter;
    
    title.textColor = [UIColor grayColor];
    
    title.text = @"我们已发送验证码到您的手机";
    
    [self.view addSubview:title];
    
    [title mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.centerX.mas_equalTo(self.view);
         make.top.mas_equalTo(self.view).offset(85);
         make.width.mas_equalTo(300);
         make.height.mas_equalTo(30);
     }];
    
    NSString *phoneStr = user_phone;
    
    UILabel *phone = [[UILabel alloc] init];
    
    phone.font = [UIFont systemFontOfSize:18];
    
    phone.textAlignment = NSTextAlignmentCenter;
    
    phone.textColor = [UIColor blackColor];
    
    phone.text = [phoneStr stringByReplacingCharactersInRange:NSMakeRange(3, 4)  withString:@"****"];
    
    [self.view addSubview:phone];
    
    [phone mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.centerX.mas_equalTo(self.view);
         make.top.mas_equalTo(title).offset(45);
         make.width.mas_equalTo(300);
         make.height.mas_equalTo(30);
     }];
    
    
    
    
    
}


//加载编辑框的view
- (void)initPhoneView
{
//    phoneView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 80, 45)];
//    
//    phoneView.backgroundColor = [UIColor greenColor];
//    
//    [passwordNum addSubview:phoneView];
    
    passwordNum = [[UITextField alloc] initWithFrame:CGRectMake(40, 180, SCREEN_WIDTH - 80, 45)];
    passwordNum.backgroundColor = [myselfway stringTOColor:@"0xF3F3F3"];
    //输入的文字颜色为白色
    passwordNum.textColor = [myselfway stringTOColor:@"0xF3F3F3"];
    //输入框光标的颜色为白色
    passwordNum.tintColor = [myselfway stringTOColor:@"0xF3F3F3"];
    passwordNum.delegate = self;
    passwordNum.autocapitalizationType = UITextAutocapitalizationTypeNone;
    passwordNum.keyboardType = UIKeyboardTypeNumberPad;
//    passwordNum.layer.borderColor = [[UIColor grayColor] CGColor];
//    passwordNum.layer.borderWidth = 1;
    [passwordNum addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:passwordNum];
    
    
    for (int i = 0; i < 6; i++)
    {
        UILabel *num = [[UILabel alloc] initWithFrame:CGRectMake(40 + i * ((SCREEN_WIDTH - 80) / 6), 180, (SCREEN_WIDTH - 80) / 6, 45)];
        
        num.textAlignment = NSTextAlignmentCenter;
        
        num.tag = 900 + i;
        
        num.font = [UIFont systemFontOfSize:20];
        
        [self.view addSubview:num];
        
        
        UIView *line = [[UIView alloc] init];
        
        line.backgroundColor = [UIColor grayColor];
        
        [num addSubview:line];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.top.mas_equalTo(num).offset(44);
            make.left.mas_equalTo(num).offset(5);
            make.right.mas_equalTo(num).offset(-5);
            make.height.mas_equalTo(1);
        }];
        
    }
    
    
    
    
    secondsCountDown = 60;    //60秒倒计时
    
    time = [[UILabel alloc] init];
    
    time.text = [NSString stringWithFormat:@"%ld 秒后可重新发送", secondsCountDown];
    
    time.font = [UIFont systemFontOfSize:15];
    
    time.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:time];
    
    
    [time mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.mas_equalTo(self.view).offset(250);
         make.centerX.mas_equalTo(self.view);
         make.width.mas_equalTo(200);
         make.height.mas_equalTo(20);
     }];

    countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
    
    
    again = [UIButton buttonWithType:UIButtonTypeCustom];
    
    again.layer.cornerRadius = 5;
    
    again.backgroundColor = [myselfway stringTOColor:@"0x2E84F8"];
    
    [again setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [again setTitle:@"重新获取" forState:UIControlStateNormal];
    
    [again addTarget:self action:@selector(againBtn) forControlEvents:UIControlEventTouchUpInside];
    
    again.hidden = YES;
    
    [self.view addSubview:again];
    
    [again mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.mas_equalTo(self.view).offset(250);
         make.left.mas_equalTo(self.view).offset(80);
         make.right.mas_equalTo(self.view).offset(-80);
         make.height.mas_equalTo(35);
     }];
    
    
    UIButton *buYes = [UIButton buttonWithType:UIButtonTypeCustom];
    
    buYes.layer.cornerRadius = 5;
    
    buYes.backgroundColor = [myselfway stringTOColor:@"0x2E84F8"];
    
    [buYes setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [buYes setTitle:@"下一步" forState:UIControlStateNormal];
    
    [buYes addTarget:self action:@selector(YesBtn) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:buYes];
    
    [buYes mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(again).offset(70);
        make.left.mas_equalTo(self.view).offset(40);
        make.right.mas_equalTo(self.view).offset(-40);
        make.height.mas_equalTo(35);
    }];
    
    
    
}


//下一步按钮 ，网络请求
- (void)YesBtn
{
    NSLog(@"%@",yanzhengma);
    
    
    //编辑成功，  校验，然后网络请求， 跳转页面
    [self yanzhengmaData:yanzhengma];
}



//倒计数秒的方法
- (void)timeFireMethod
{
    secondsCountDown --;
    
    time.text = [NSString stringWithFormat:@"%ld 秒后可重新发送", secondsCountDown];
    
    if(secondsCountDown == 0)
    {
        [countDownTimer invalidate];
        
        secondsCountDown = 60;    //60秒倒计时
        
        time.hidden = YES;
        
        again.hidden = NO;
    }
}


//重新获取验证码按钮
- (void)againBtn
{
    again.hidden = YES;
    time.hidden = NO;
    
    time.text = [NSString stringWithFormat:@"%ld 秒后可重新发送", secondsCountDown];
    
    countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
}



//获取编辑框字符串
- (void)textFieldDidChange:(UITextField *)textField
{
    yanzhengma = textField.text;
    
    NSString *place = [textField.text substringWithRange:NSMakeRange(textField.text.length - 1, 1)];
    
    
}




#pragma textfield的代理


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if (range.location == 0)
    {
        UILabel *label = [self.view viewWithTag:900];
        
        label.text = string;
    
    }
    else if (range.location == 1)
    {
        UILabel *label = [self.view viewWithTag:901];
        
        label.text = string;
    }
    else if (range.location == 2)
    {
        UILabel *label = [self.view viewWithTag:902];
        
        label.text = string;
    }
    else if(range.location == 3)
    {
        UILabel *label = [self.view viewWithTag:903];
        
        label.text = string;
    }
    else if(range.location == 4)
    {
        UILabel *label = [self.view viewWithTag:904];
        
        label.text = string;
    }
    else
    {
        UILabel *label = [self.view viewWithTag:905];
        
        label.text = string;
    }
    
    
    
    if (string.length == 0)
        
        return YES;
    
    NSInteger existedLength = textField.text.length;
    NSInteger selectedLength = range.length;
    NSInteger replaceLength = string.length;
    
    if (existedLength - selectedLength + replaceLength > 5)
    {
        
        
    }
    
    
    if (existedLength - selectedLength + replaceLength > 6)
    {
        
        
        return NO;
    }
    
    
    
    
    
    return YES;
}




//发送验证码接口
- (void)postData
{
    NSString *url = [NSString stringWithFormat:@"%@Users/passwordEdit?u_mobile=%@", baseUrl, user_phone];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject)
     {
         NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         
         if ([[dictionary objectForKey:@"code"] integerValue] == 1)
         {
             [self initUI];
             
             [self initPhoneView];
             
             NSDictionary *dic = [dictionary objectForKey:@"data"];
             
             NSString *msg = [dic objectForKey:@"msg"];
             
             [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
             [SVProgressHUD showSuccessWithStatus:msg];
             
             [self performSelector:@selector(DatTime) withObject:self afterDelay:1];
             
         }
         else
         {
             NSDictionary *dic = [dictionary objectForKey:@"data"];
             
             NSString *msg = [dic objectForKey:@"msg"];
             
             [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
             [SVProgressHUD showSuccessWithStatus:msg];
             
             [self performSelector:@selector(DatTime) withObject:self afterDelay:1];
         }
         
         
     } failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         [SVProgressHUD showSuccessWithStatus:@"暂无网络，请检查您的网络"];
         
         [self performSelector:@selector(DatTime) withObject:self afterDelay:2];
     }];
    
}


- (void)DatTime
{
    [SVProgressHUD dismiss];
}







//判断验证码是否正确的校验
- (void)yanzhengmaData: (NSString *)yanzhengma
{
    NSString *url = [NSString stringWithFormat:@"%@Users/passwordEdit", baseUrl];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSDictionary *dic = @{@"u_mobile": user_phone,
                          @"verify_code": yanzhengma
                          };
    
    
    [manager POST:url parameters:dic success:^(NSURLSessionDataTask *task, id responseObject)
     {
         NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         
         if ([[dictionary objectForKey:@"code"] integerValue] == 1)
         {
             NSDictionary *dic = [dictionary objectForKey:@"data"];
             
             NSString *msg = [dic objectForKey:@"msg"];
             
             [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
             
             [SVProgressHUD showSuccessWithStatus:msg];
             
             [self performSelector:@selector(DatTime) withObject:self afterDelay:1.5];
             
             RemoveCardViewController *temp = [[RemoveCardViewController alloc] init];
             
             temp.yanzhengmaNum = yanzhengma;
             
             [self.navigationController pushViewController:temp animated:YES];
             
         }
         else
         {
             NSDictionary *dic = [dictionary objectForKey:@"data"];
             
             NSString *msg = [dic objectForKey:@"msg"];
             
             [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
             [SVProgressHUD showSuccessWithStatus:msg];
             
             [self performSelector:@selector(DatTime) withObject:self afterDelay:1];
         }
         
         
     } failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
         [SVProgressHUD showSuccessWithStatus:@"暂无网络，请检查您的网络"];
         
         [self performSelector:@selector(DatTime) withObject:self afterDelay:2];
     }];
    
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}



@end
