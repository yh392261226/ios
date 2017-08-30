//
//  PasswordViewController.m
//  worker
//
//  Created by 郭健 on 2017/8/30.
//  Copyright © 2017年 郭健. All rights reserved.
//



#import "PasswordViewController.h"
#import "SYPasswordView.h"
#import "PasswordToViewController.h"

@interface PasswordViewController ()<UITextFieldDelegate>
{
    NSMutableArray *dataArray;
    
    NSString *password;
    
}

@property (nonatomic, strong) SYPasswordView *pasView;

@end

@implementation PasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    dataArray = [NSMutableArray array];
    
    [self addhead:@"密码设置"];
    
    self.view.backgroundColor = [myselfway stringTOColor:@"0xC4CED3"];
    
    [self initUI];
    
    self.pasView = [[SYPasswordView alloc] initWithFrame:CGRectMake(16, 150, self.view.frame.size.width - 32, 45)];
    
    self.pasView.delegate = self;
    
    [self.view addSubview:_pasView];
    
    
}






- (void)initUI
{
    UILabel *title = [[UILabel alloc] init];
    
    title.font = [UIFont systemFontOfSize:17];
    
    title.textAlignment = NSTextAlignmentCenter;
    
    title.textColor = [UIColor grayColor];
    
    title.text = @"设置六位提现密码";
    
    [self.view addSubview:title];
    
    [title mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).offset(85);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(30);
    }];
    
}







//第一次编辑的密码
- (void)password: (NSString *)num
{
    self.hidesBottomBarWhenPushed = YES;
    
    PasswordToViewController *temp = [[PasswordToViewController alloc] init];
    
    temp.firPass = num;
    
    [self.navigationController pushViewController:temp animated:NO];
   
}








- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
