//
//  RemovePhoneViewController.m
//  worker
//
//  Created by 郭健 on 2017/8/31.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "RemovePhoneViewController.h"

@interface RemovePhoneViewController ()
{
    NSMutableArray *dataArray;
    
    UIView *phoneView;     //编辑框的view
    
}



@end

@implementation RemovePhoneViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [myselfway stringTOColor:@"0xC4CED3"];
    
    [self addhead:@"重置提现密码"];
    
    [self slitherBack:self.navigationController];
    
    [self initUI];
    
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
    phoneView = [[UIView alloc] initWithFrame:CGRectMake(30, 120, SCREEN_WIDTH - 60, 45)];
    
    phoneView.backgroundColor = [UIColor greenColor];
    
    
    
    
    
    
}






- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}



@end
