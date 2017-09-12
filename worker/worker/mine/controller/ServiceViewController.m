//
//  ServiceViewController.m
//  worker
//
//  Created by 郭健 on 2017/8/15.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "ServiceViewController.h"

@interface ServiceViewController ()
{
    NSMutableArray *dataArray;
}

@end

@implementation ServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dataArray = [NSMutableArray array];
    
    [self addhead:@"服务条款"];
    
    webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://zy.persistence.net.cn/"]];
    
    [self.view addSubview:webview];
    
    [webview loadRequest:request];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
