//
//  SelecdCityViewController.m
//  worker
//
//  Created by 郭健 on 2017/7/28.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "SelecdCityViewController.h"

@interface SelecdCityViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *dataArray;
}

@property (nonatomic, strong)UITableView *tableview;

@end

@implementation SelecdCityViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    
    dataArray = [NSMutableArray array];
    
    
    [self addhead:@"城市选择"];
    
    [self slitherBack:self.navigationController];
    
    [self getdata];

}





- (void)getdata
{
    
    NSString *url = [NSString stringWithFormat:@"%@%@", baseUrl, @"Regions/index?action=letter"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject)
    {
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        if ([[dictionary objectForKey:@"code"] integerValue] == 200)
        {
            NSMutableArray *tem = [dictionary objectForKey:@"data"];

            
            
            
            NSLog(@"%@", tem);
        }
        
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error)
     {
        
    }];
    
    
}




















- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
