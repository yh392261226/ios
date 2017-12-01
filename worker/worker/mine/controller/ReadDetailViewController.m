//
//  ReadDetailViewController.m
//  worker
//
//  Created by ios_g on 2017/11/14.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "ReadDetailViewController.h"

@interface ReadDetailViewController ()
{
    NSString *titleText;
}

@end

@implementation ReadDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addhead:@"文章详情"];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self logindataDetail];
    
}


//文章详情
- (void)logindataDetail
{
    
    NSString *url = [NSString stringWithFormat:@"%@Articles/articlesInfo?a_id=%@", baseUrl, self.a_id];
    
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
