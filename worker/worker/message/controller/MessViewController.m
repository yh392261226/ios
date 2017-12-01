//
//  MessViewController.m
//  worker
//
//  Created by 郭健 on 2017/8/1.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "MessViewController.h"
#import "MainTableViewCell.h"

@interface MessViewController ()<UITableViewDelegate, UITableViewDataSource, UIWebViewDelegate>
{
    NSMutableArray *dataArray;
}


@property (nonatomic, strong)UIWebView *webview;

@property (nonatomic, strong)UITableView *tableview;

@end

@implementation MessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBarHidden = YES;
    
    dataArray = [NSMutableArray array];
    [dataArray addObject:@"1"];
    [dataArray addObject:@"1"];
    [dataArray addObject:@"1"];
    
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 44 + StatusBarHeigh, SCREEN_WIDTH, 1)];
    
    line.backgroundColor = [myselfway stringTOColor:@"0xB2B2B2"];
    
    [self.view addSubview:line];
    
    
    _webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 45 + StatusBarHeigh, SCREEN_WIDTH, SCREEN_HEIGHT - 93 - StatusBarHeigh)];
    
    _webview.delegate = self;
    
    NSURL *url = [NSURL URLWithString:@"http://api.gangjianwang.com/activities.php"];
    // 3.创建Request
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    // 4.加载网页
    [_webview loadRequest:request];
    // 5.最后将webView添加到界面
    [self.view addSubview:_webview];
    
   
    
    
    
    http://api.gangjianwang.com/activities.php
    
    [self initHeadView];
    //[self tableview];
    
//    UILabel *msg = [[UILabel alloc] init];
//
//    msg.text = @"此功能正在开发, 敬请期待!";
//
//    msg.textAlignment = NSTextAlignmentCenter;
//
//    msg.font = [UIFont systemFontOfSize:16];
//
//    msg.textColor = [myselfway stringTOColor:@"0x2E84F8"];
//
//    [self.view addSubview:msg];
//
//    [msg mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.mas_equalTo(self.view);
//        make.left.mas_equalTo(self.view).offset(40);
//        make.right.mas_equalTo(self.view).offset(-40);
//        make.height.mas_equalTo(30);
//    }];
    
}


//网页开始加载的时候调用
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"加载");
    
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    
    [SVProgressHUD showWithStatus:@"加载中..."];
    
    
    [self performSelector:@selector(noDis) withObject:self afterDelay:15];

}


- (void)noDis
{
    [SVProgressHUD dismiss];
}


//网页加载完成的时候调用
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [SVProgressHUD dismiss];
}


//网页加载错误的时候调用
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"错误");
    
    
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    
    [SVProgressHUD showWithStatus:@"网络请求失败，请检查网络"];
    
    
    [self performSelector:@selector(noDis) withObject:self afterDelay:1.5];
    
}



#pragma tableview代理

- (UITableView *)tableview
{
    if (!_tableview)
    {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 113) style:UITableViewStyleGrouped];
        
        [_tableview registerClass:[MainTableViewCell class] forCellReuseIdentifier:@"messCell"];
        
        _tableview.backgroundColor = [myselfway stringTOColor:@"0xC4CED3"];
        
        _tableview.delegate = self;
        _tableview.dataSource = self;
        
        [self.view addSubview:_tableview];
        
        [_tableview mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.top.mas_equalTo(self.view).offset(44 + StatusBarHeigh);
             make.left.mas_equalTo(self.view).offset(0);
             make.right.mas_equalTo(self.view).offset(0);
             make.bottom.mas_equalTo(self.view).offset(SCREEN_HEIGHT - 44 - StatusBarHeigh);
         }];
    }
    
    return _tableview;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"messCell"];
    
    cell.backgroundColor = [myselfway stringTOColor:@"0xC4CED3"];
    
    cell.worker.layer.cornerRadius = 5;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 170;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 10;
    }
    else
    {
       return 0.1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == dataArray.count - 1)
    {
        return 30;
    }
    else
    {
        return 0.1;
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    
    return view;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    
    if (section == dataArray.count - 1)
    {
        view.backgroundColor = [myselfway stringTOColor:@"0xC4CED3"];
        
        UILabel *title = [[UILabel alloc] init];
        
        title.text = @"- 更多优惠,敬请期待 -";
        
        title.textAlignment = NSTextAlignmentCenter;
        
        title.textColor = [UIColor whiteColor];
        
        title.font = [UIFont systemFontOfSize:15];
        
        [view addSubview:title];
        
        [title mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.centerX.mas_equalTo(view);
             make.top.mas_equalTo(view).offset(5);
             make.width.mas_equalTo(300);
             make.height.mas_equalTo(20);
         }];

    }
    
    return view;
}


#pragma 自定义的方法

//加载头部view
- (void)initHeadView
{
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
    
    UILabel *headlabel = [[UILabel alloc] init];
    
    headlabel.text = @"优惠信息";
    
    [headlabel setTextColor:[myselfway stringTOColor:@"0x2E84F8"]];
    
    headlabel.textAlignment = NSTextAlignmentCenter;
    
    headlabel.font = [UIFont boldSystemFontOfSize:17];
    
    [view addSubview:headlabel];
    
    [headlabel mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.centerX.equalTo(view);
         make.bottom.mas_equalTo(view).offset(-6);
         make.height.mas_equalTo(30);
         make.width.mas_equalTo(200);
     }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}












@end
