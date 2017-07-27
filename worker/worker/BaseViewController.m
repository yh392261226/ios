//
//  BaseViewController.m
//  worker
//
//  Created by 郭健 on 2017/7/26.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

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
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    
    view.backgroundColor = [myselfway stringTOColor:@"0x3E9FEA"];
    
    [self.view addSubview:view];
    
    UILabel *headlabel = [[UILabel alloc] init];
    
    headlabel.text = title;
    
    [headlabel setTextColor:[UIColor whiteColor]];
    
    headlabel.textAlignment = NSTextAlignmentCenter;
    
    headlabel.font = [UIFont systemFontOfSize:17];
    
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
    [button setImage:[UIImage imageNamed:@"gangj_return"] forState:UIControlStateNormal];
    [view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.bottom.mas_equalTo(view).offset(-12);
         make.left.mas_equalTo(view).offset(10);
         make.height.mas_equalTo(18);
         make.width.mas_equalTo(20);
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
