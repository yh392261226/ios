//
//  RemoveFirViewController.m
//  worker
//
//  Created by 郭健 on 2017/8/31.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "RemoveFirViewController.h"
#import "SYPasswordView.h"
#import "RemovePhoneViewController.h"
#import "PasswordViewController.h"

@interface RemoveFirViewController ()
{
    NSMutableArray *dataArray;
}

@property (nonatomic, strong)SYPasswordView *pasView;

@end

@implementation RemoveFirViewController


- (void)viewDidAppear:(BOOL)animated
{
    [_pasView.textField becomeFirstResponder];

}

- (void)viewWillDisappear:(BOOL)animated
{
    [_pasView.textField resignFirstResponder];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    dataArray = [NSMutableArray array];
    
    [self addhead:@"修改支付密码"];
    
    [self slitherBack:self.navigationController];
    
    
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
    
    title.text = @"输入原提现密码";
    
    [self.view addSubview:title];
    
    [title mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.centerX.mas_equalTo(self.view);
         make.top.mas_equalTo(self.view).offset(85);
         make.width.mas_equalTo(150);
         make.height.mas_equalTo(30);
     }];
    
    
    UIButton *forget = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [forget setTitle:@"忘记密码" forState:UIControlStateNormal];
    
    [forget setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    forget.titleLabel.font = [UIFont systemFontOfSize:16];
    
    [forget addTarget:self action:@selector(forgetBtn) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:forget];
    
    [forget mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.top.mas_equalTo(title).offset(160);
        make.right.mas_equalTo(self.view).offset(-20);
        make.height.mas_equalTo(25);
        make.width.mas_equalTo(70);
    }];
    
    
}


//忘记密码按钮
- (void)forgetBtn
{
    self.hidesBottomBarWhenPushed = YES;
    
    RemovePhoneViewController *temp = [[RemovePhoneViewController alloc] init];
    
    [self.navigationController pushViewController:temp animated:YES];
}





//原密码获取的代理方法
- (void)password: (NSString *)num
{
    
    [self postData:num];
    
    
    
}



//修改密码
- (void)postData: (NSString *)password
{
    
    NSString *url = [NSString stringWithFormat:@"%@Users/passwordEdit", baseUrl];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSDictionary *dic = @{@"u_id" : user_ID,
                          @"u_pass" : password
                          };

    [manager POST:url parameters:dic success:^(NSURLSessionDataTask *task, id responseObject)
     {
         NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         
         if ([[dictionary objectForKey:@"code"] integerValue] == 1)
         {
             NSDictionary *dic = [dictionary objectForKey:@"data"];
             
             NSString *msg = [dic objectForKey:@"msg"];
             
             [SVProgressHUD showSuccessWithStatus:msg];
             
             [self performSelector:@selector(DatTime) withObject:self afterDelay:1];
             
             PasswordViewController *temp = [[PasswordViewController alloc] init];
             
             temp.oldpassword = password;
             
             [self.navigationController pushViewController:temp animated:YES];
             
         }
         else
         {
             NSDictionary *dic = [dictionary objectForKey:@"data"];
             
             NSString *msg = [dic objectForKey:@"msg"];
             
             [SVProgressHUD showSuccessWithStatus:msg];
             
             [self performSelector:@selector(DatTime) withObject:self afterDelay:1];
         }
         
         
     } failure:^(NSURLSessionDataTask *task, NSError *error)
     {
          [SVProgressHUD showSuccessWithStatus:@"暂无网络，请检查网络"];
         
          [self performSelector:@selector(DatTime) withObject:self afterDelay:1];
     }];
    
}


- (void)DatTime
{
    [SVProgressHUD dismiss];
}








- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
