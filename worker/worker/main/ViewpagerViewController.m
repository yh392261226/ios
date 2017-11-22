//
//  ViewpagerViewController.m
//  worker
//
//  Created by 郭健 on 2017/8/20.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "ViewpagerViewController.h"
#import "WorkerViewController.h"


#define num 3

@interface ViewpagerViewController ()<UIScrollViewDelegate>
{
    
    // 创建页码控制器
    UIPageControl *pageControl;
    
    
    NSString *password;  //密码
    
    NSString *mima;
    
    
    UITextField *field;
    
    UIButton *button;
   
}

@property (nonatomic, strong)UIWindow *window;

@end

@implementation ViewpagerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //获取加载密码
    [self getDataNum];
    
    
    
    
}

- (void)initUI
{
    self.window = [[UIApplication sharedApplication] keyWindow];
    
    
    
    
    UIScrollView *myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    
    for (int i = 0; i < num; i++)
    {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"Y%d.jpg",i + 1]];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * i, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        // 在最后一页创建按钮
        if (i == 2)
        {
            // 必须设置用户交互 否则按键无法操作
            imageView.userInteractionEnabled = YES;
            UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
            button.frame = CGRectMake(SCREEN_WIDTH / num, SCREEN_HEIGHT * 7 / 8 - 20, SCREEN_WIDTH / num, SCREEN_HEIGHT / 16);
            [button setTitle:@"点击进入" forState:UIControlStateNormal];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            button.layer.borderWidth = 2;
            button.layer.cornerRadius = 5;
            button.clipsToBounds = YES;
            button.layer.borderColor = [UIColor whiteColor].CGColor;
            [button addTarget:self action:@selector(go:) forControlEvents:UIControlEventTouchUpInside];
            [imageView addSubview:button];
        }
        
        imageView.image = image;
        [myScrollView addSubview:imageView];
    }
    myScrollView.bounces = NO;
    myScrollView.pagingEnabled = YES;
    myScrollView.showsHorizontalScrollIndicator = NO;
    myScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * num, SCREEN_HEIGHT);
    myScrollView.delegate = self;
    
    [self.view addSubview:myScrollView];
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / num, SCREEN_HEIGHT * 15 / 16, SCREEN_WIDTH / num, SCREEN_HEIGHT / 16)];
    // 设置页数
    pageControl.numberOfPages = num;
    // 设置页码的点的颜色
    pageControl.pageIndicatorTintColor = [UIColor yellowColor];
    // 设置当前页码的点颜色
    pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    
    [self.view addSubview:pageControl];
    
}
#pragma mark - UIScrollViewDelegate 
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 计算当前在第几页
    pageControl.currentPage = (NSInteger)(scrollView.contentOffset.x / [UIScreen mainScreen].bounds.size.width);
}





// 点击按钮保存数据并切换根视图控制器

- (void)go: (UIButton *)sender
{
    // 切换根视图控制器
    self.view.window.rootViewController = [[WorkerViewController alloc] init];
}



//获取编辑框密码
- (void)password: (UITextField *)textfield
{
    
    mima = textfield.text;
}



//加锁校验
- (void)dianjiBttn
{
    if (![mima isEqualToString:password])
    {
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD showErrorWithStatus:@"密码错误"];
        
        [self performSelector:@selector(disBtn) withObject:self afterDelay:1.5];
        
    }
    else
    {
        
        button.hidden = YES;
        field.hidden = YES;
        [self.view endEditing:YES];
        
        [self initUI];

    }
    
}


//引导页加锁验证
- (void)postData
{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD showWithStatus:@"请等待..."];
    
    NSString *url = [NSString stringWithFormat:@"%@Tools/lock", baseUrl];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject)
     {
         NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         
         if ([[dictionary objectForKey:@"code"] integerValue] == 200)
         {
             NSNumber *number = [dictionary objectForKey:@"data"];
             
             NSInteger i = [number integerValue];
 
             if (i < 0)
             {
                   [self initUI];
             }
             else if (i == 2)
             {
                 
                 field = [[UITextField alloc] init];
                 
                 field.placeholder = @"密码";
                 field.secureTextEntry = YES;
                 
                 field.borderStyle = UITextBorderStyleLine;
                 
                 [field addTarget:self action:@selector(password:) forControlEvents:UIControlEventEditingChanged];
                 
                 [self.view addSubview:field];
                 
                 [field mas_makeConstraints:^(MASConstraintMaker *make) {
                     
                     make.centerX.mas_equalTo(self.view);
                     make.centerY.mas_equalTo(self.view);
                     make.height.mas_equalTo(35);
                     make.width.mas_equalTo(200);
                     
                 }];
                 
                 
                 button = [[UIButton alloc] init];
                 
                 [button setTitle:@"确认" forState:0];
                 
                 [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                 
                 button.titleLabel.textAlignment = NSTextAlignmentCenter;
                 
                 [button addTarget:self action:@selector(dianjiBttn) forControlEvents:UIControlEventTouchUpInside];
                 
                 [self.view addSubview:button];
                 
                 [button mas_makeConstraints:^(MASConstraintMaker *make) {
                     
                     make.top.mas_equalTo(field).offset(40);
                     make.centerX.mas_equalTo(self.view);
                     make.height.mas_equalTo(35);
                     make.width.mas_equalTo(200);
                     
                 }];
   
             }
             else if (i == 1)
             {
                [self initUI];
                 
             }
             
         }
         
         
         
         
     } failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         [SVProgressHUD dismiss];
     }];
    
}


//获取验证码
- (void)getDataNum
{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD showWithStatus:@"请等待..."];
    
    NSString *url = [NSString stringWithFormat:@"%@tools/internal", baseUrl];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject)
     {
         NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         
         if ([[dictionary objectForKey:@"code"] integerValue] == 200)
         {
             password = [dictionary objectForKey:@"data"];
             
             [self postData];
             
         }
         
         [SVProgressHUD dismiss];
         
         
     } failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         [SVProgressHUD dismiss];
     }];
    
}


- (void)disBtn
{
    [SVProgressHUD dismiss];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
