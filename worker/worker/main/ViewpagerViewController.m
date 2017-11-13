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
   
}

@property (nonatomic, strong)UIWindow *window;

@end

@implementation ViewpagerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
            button.frame = CGRectMake(SCREEN_WIDTH / num, SCREEN_HEIGHT * 7 / 8, SCREEN_WIDTH / num, SCREEN_HEIGHT / 16);
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









- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
