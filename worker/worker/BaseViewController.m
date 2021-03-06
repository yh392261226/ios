//
//  BaseViewController.m
//  worker
//
//  Created by 郭健 on 2017/7/26.
//  Copyright © 2017年 郭健. All rights reserved.
//




#import "BaseViewController.h"



@interface BaseViewController ()
{
    CGRect rectOfNavigationbar;
}

@end

@implementation BaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
   
}


- (void)addhead:(NSString *)title
{
    self.view.backgroundColor = [myselfway stringTOColor:@"0xF3F3F3"];
    
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    UIView *view = [[UIView alloc] init];
    
    view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:view];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.top.mas_equalTo(self.view).offset(0);
        make.left.mas_equalTo(self.view).offset(0);
        make.right.mas_equalTo(self.view).offset(0);
        make.height.mas_equalTo(44 + StatusBarHeigh);
    }];
    
    NSLog(@"%lf", StatusBarHeigh);
    
    UILabel *headlabel = [[UILabel alloc] init];
    
    headlabel.text = title;
    
    [headlabel setTextColor:[myselfway stringTOColor:@"0x2E84F8"]];
    headlabel.textAlignment = NSTextAlignmentCenter;
    
    headlabel.font = [UIFont systemFontOfSize:17];
    
    [view addSubview:headlabel];
    
    [headlabel mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.centerX.equalTo(view);
         make.bottom.mas_equalTo(view).offset(-6);
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




- (void)temp
{
    [self.navigationController popViewControllerAnimated:YES];
}




- (void)slitherBack: (UINavigationController *)navi
{
    //1.获取系统interactivePopGestureRecognizer对象的target对象
    id target = navi.interactivePopGestureRecognizer.delegate;
    
    //2.创建滑动手势，taregt设置interactivePopGestureRecognizer的target，所以当界面滑动的时候就会自动调用target的action方法。
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] init];
    [pan addTarget:target action:NSSelectorFromString(@"handleNavigationTransition:")];
    pan.delegate = self;
    
    //3.添加到导航控制器的视图上
    [navi.view addGestureRecognizer:pan];
    
    //4.禁用系统的滑动手势
    navi.interactivePopGestureRecognizer.enabled = NO;
}


- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    //只有导航的根控制器不需要右滑的返回的功能。
    if (self.navigationController.viewControllers.count <= 1)
    {
        return NO;
    }
    
    return YES;
}





@end
