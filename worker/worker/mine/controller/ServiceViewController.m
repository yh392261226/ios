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
    
    NSString *titleText;
}

@end

@implementation ServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dataArray = [NSMutableArray array];
    
    [self addhead:@"服务条款"];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
//    webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
//
//    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://zy.persistence.net.cn/"]];
//
//    [self.view addSubview:webview];
//
//    [webview loadRequest:request];
    
    [self logindata];


    
}



- (void)logindata
{
    
    NSString *url = [NSString stringWithFormat:@"%@Articles/articlesInfo?a_id=13", baseUrl];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject)
     {
         NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         
         if ([[dictionary objectForKey:@"code"] integerValue] == 1)
         {
             
             NSDictionary *dic = [dictionary objectForKey:@"data"];
             
             titleText = [dic objectForKey:@"a_desc"];
             
             UITextView *view = [[UITextView alloc] initWithFrame:CGRectMake(25, 74, SCREEN_WIDTH - 50, SCREEN_HEIGHT - 74)];
             
             view.userInteractionEnabled = NO;
             
             view.text = [NSString stringWithFormat:@"        %@", titleText];
             
             NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
             
             paragraphStyle.lineSpacing = 1; //行距
             
             NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:15], NSParagraphStyleAttributeName:paragraphStyle};
             
             view.attributedText = [[NSAttributedString alloc]initWithString:view.text attributes:attributes];
             
             [self.view addSubview:view];
             
         }
         
         
         
     }
         failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         
     }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
