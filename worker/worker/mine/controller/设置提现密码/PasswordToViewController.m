//
//  PasswordToViewController.m
//  worker
//
//  Created by 郭健 on 2017/8/30.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "PasswordToViewController.h"
#import "SYPasswordView.h"
#import "SetPasswordViewController.h"

@interface PasswordToViewController ()
{
    NSMutableArray *dataArray;
    
    NSString *erpassword;
}


@property (nonatomic, strong) SYPasswordView *pasView;

@end

@implementation PasswordToViewController

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
    
    title.text = @"再次输入提现密码";
    
    [self.view addSubview:title];
    
    [title mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.centerX.mas_equalTo(self.view);
         make.top.mas_equalTo(self.view).offset(85);
         make.width.mas_equalTo(150);
         make.height.mas_equalTo(30);
     }];
    
    

}






//第二次编辑的密码
- (void)password: (NSString *)num
{
//    for (UIViewController *controller in self.navigationController.viewControllers)
//    {
//        if ([controller isKindOfClass:[SetPasswordViewController class]])
//        {
//            
//            if ([self.firPass isEqualToString:num])
//            {
//                [SVProgressHUD showInfoWithStatus:@"密码设置成功"];
//                
//                
//                [self.navigationController popToViewController:controller animated:YES];
//            }
//            else
//            {
//                [SVProgressHUD showInfoWithStatus:@"两次密码输入不一致"];
//            }
//            
//            
//        }
//    }
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    
    if ([self.firPass isEqualToString:num])
    {
        if (self.odlpassword.length != 0)
        {
            
            //输入原密码修改密码走的路
            [self OldpostData:self.odlpassword newPass:num];
            
        }
        else if ([self.wangjimima isEqualToString:@"1"])
        {
            //不知道源密码修改密码走的路
            [self OldpostDataInfo:num];
        }
        else
        {
            [self postData:num];
        }
        
        
        
        
        
        
        
    }
    else
    {
        [SVProgressHUD showInfoWithStatus:@"两次密码输入不一致"];
    }
    
    
}




//设置提现密码
- (void)postData: (NSString *)password
{
    
    NSString *url = [NSString stringWithFormat:@"%@Users/setPassword", baseUrl];
    
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
             
             [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
             [SVProgressHUD showSuccessWithStatus:msg];
             
             [self performSelector:@selector(DatTime) withObject:self afterDelay:1.5];
             
             
             [[NSUserDefaults standardUserDefaults] setObject:@"1111111111" forKey:@"u_pass"];
             
             [[NSUserDefaults standardUserDefaults] synchronize];
             
             
             
             NSDictionary *dict = @{@"tongzhi": @"1"};
             
             [[NSNotificationCenter defaultCenter] postNotificationName:@"changePassword" object:@"zhangsan" userInfo:dict];
             
             //postNotificationName:之后的参数就是这个通知的名字，要和要和接收者中的名字一样，才能让接收者正确接收。
             //object：接收对象
             //userInfo: 携带的参数，在例子中我携带了一个字典，因为有时候我们要传递的参数不只是一个，所以把东西全部放在通知里面，在接收者中，根据字典里面的键来取出里面的值。
             //在字典中传递的color是一个已经实例化后的对象。

             [self.navigationController popToRootViewControllerAnimated:YES];
             
         }
         else
         {
             NSDictionary *dic = [dictionary objectForKey:@"data"];
             
             NSString *msg = [dic objectForKey:@"msg"];
             
             [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
             
             [SVProgressHUD showErrorWithStatus:msg];
             
             [self performSelector:@selector(DatTime) withObject:self afterDelay:1.5];
         }
         
     } failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         
     }];
    
}


- (void)DatTime
{
    [SVProgressHUD dismiss];
}







//输入元密码修改密码
- (void)OldpostData: (NSString *)password newPass:(NSString *)pass
{
    
    NSString *url = [NSString stringWithFormat:@"%@Users/passwordEdit", baseUrl];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSDictionary *dic = @{@"u_id" : user_ID,
                          @"u_pass" : password,
                          @"new_pass" : pass
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
             
             
             [[NSUserDefaults standardUserDefaults] setObject:@"1111111111" forKey:@"u_pass"];
             
             [self.navigationController popToRootViewControllerAnimated:YES];
             
         }
         else
         {
             NSDictionary *dic = [dictionary objectForKey:@"data"];
             
             NSString *msg = [dic objectForKey:@"msg"];
             
             [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
             
             [SVProgressHUD showErrorWithStatus:msg];
             
             [self performSelector:@selector(DatTime) withObject:self afterDelay:1.5];
         }
         
     } failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         
     }];
    
}



//不知道源密码修改密码
- (void)OldpostDataInfo: (NSString *)pass
{
    NSString *url = [NSString stringWithFormat:@"%@Users/passwordEdit", baseUrl];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSDictionary *dic = @{@"u_mobile" : user_phone,
                          @"verify_code" : self.yanzhengma,
                          @"new_pass" : pass,
                          @"u_idcard": self.card_ID
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
             
             [[NSUserDefaults standardUserDefaults] setObject:@"1111111111" forKey:@"u_pass"];
             
             [self.navigationController popToRootViewControllerAnimated:YES];
             
         }
         else
         {
             NSDictionary *dic = [dictionary objectForKey:@"data"];
             
             NSString *msg = [dic objectForKey:@"msg"];
             
             [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
             
             [SVProgressHUD showErrorWithStatus:msg];
             
             [self performSelector:@selector(DatTime) withObject:self afterDelay:1.5];
         }
         
     } failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         
     }];
    
}


@end
