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
}



@end

@implementation RemovePhoneViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [myselfway stringTOColor:@"0xC4CED3"];
    
    [self addhead:@"重置提现密码"];
    
    
    [self initUI];
    
    
    [self initPhoneView];
    
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
    
    NSString *phoneStr = @"15840344241";
    
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
    
    
    for (int i = 0; i < 4; i++)
    {
        UILabel *num = [[UILabel alloc] initWithFrame:CGRectMake(40 + i * ((SCREEN_WIDTH - 80) / 4), 180, (SCREEN_WIDTH - 80) / 4, 45)];
        
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
         make.left.mas_equalTo(self.view).offset(50);
         make.right.mas_equalTo(self.view).offset(-50);
         make.height.mas_equalTo(35);
     }];
    
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
    NSLog(@"%@", textField.text);
    
    NSString *place = [textField.text substringWithRange:NSMakeRange(textField.text.length - 1, 1)];
    
    NSLog(@"%@", place);
    
    
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
    else
    {
        UILabel *label = [self.view viewWithTag:903];
        
        label.text = string;
    }
    
    
    
    
    if (string.length == 0)
        
        return YES;
    
    NSInteger existedLength = textField.text.length;
    NSInteger selectedLength = range.length;
    NSInteger replaceLength = string.length;
    
    if (existedLength - selectedLength + replaceLength > 3)
    {
        //编辑成功，  校验，然后跳转页面
        RemoveCardViewController *temp = [[RemoveCardViewController alloc] init];
        
        [self.navigationController pushViewController:temp animated:YES];
    }
    
    
    if (existedLength - selectedLength + replaceLength > 4)
    {
        return NO;
    }
    
    
    
    
    
    return YES;
}











- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}



@end
