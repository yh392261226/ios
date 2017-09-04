//
//  RemoveCardViewController.m
//  worker
//
//  Created by 郭健 on 2017/8/31.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "RemoveCardViewController.h"

@interface RemoveCardViewController ()<UITextFieldDelegate>
{
    
    UITextField *cardNumber;
    
    
    UILabel *showLabel;     // 显示的label
    
}

@end

@implementation RemoveCardViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [myselfway stringTOColor:@"0xC4CED3"];
    
    [self addhead:@"重置提现密码"];
    
    
    [self initUI];
    
    
}


//加载UI控件
- (void)initUI
{
    UILabel *title = [[UILabel alloc] init];
    
    title.font = [UIFont systemFontOfSize:17];
    
    title.textAlignment = NSTextAlignmentCenter;
    
    title.textColor = [UIColor grayColor];
    
    title.text = @"请填写小二的身份证号";
    
    [self.view addSubview:title];
    
    [title mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.centerX.mas_equalTo(self.view);
         make.top.mas_equalTo(self.view).offset(85);
         make.width.mas_equalTo(300);
         make.height.mas_equalTo(30);
     }];

    UITextField *phone = [[UITextField alloc] init];
    
    phone.borderStyle = UITextBorderStyleRoundedRect;
    
    phone.delegate = self;
    
    phone.keyboardType = UIKeyboardTypeNumberPad;
    
    [phone addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    phone.placeholder = @"请输入身份证号";
    
    [self.view addSubview:phone];
    
    [phone mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.centerX.mas_equalTo(self.view);
         make.top.mas_equalTo(title).offset(45);
         make.width.mas_equalTo(300);
         make.height.mas_equalTo(30);
     }];

    
    
    UIButton *again = [UIButton buttonWithType:UIButtonTypeCustom];
    
    again.layer.cornerRadius = 5;
    
    again.backgroundColor = [myselfway stringTOColor:@"0x2E84F8"];
    
    [again setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [again setTitle:@"下一步" forState:UIControlStateNormal];
    
    [again addTarget:self action:@selector(againBtn) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:again];
    
    [again mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.mas_equalTo(self.view).offset(220);
         make.left.mas_equalTo(self.view).offset(50);
         make.right.mas_equalTo(self.view).offset(-50);
         make.height.mas_equalTo(35);
     }];

    
    
}


//下一步按钮
- (void)againBtn
{
    [SVProgressHUD showInfoWithStatus:@"密码设置成功"];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}


//获取编辑框编辑内容
- (void)textFieldDidChange:(UITextField *)textField
{
    NSLog(@"%@", textField.text);
}


//消键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
