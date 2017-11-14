//
//  MineMessViewController.m
//  worker
//
//  Created by 郭健 on 2017/8/3.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "MineMessViewController.h"
#import "MessTableViewCell.h"
#import "MainViewController.h"
#import "winView.h"

@interface MineMessViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *dataArray;
    
    NSInteger type;    //判断是工作邀约还是系统消息
    
    NSMutableArray *MessArrayWor;   //消息的数组
    NSMutableArray *MessArraySys;   //消息的数组
    
    winView *backview;  //弹窗view
    
    UIControl *cor;
}

@property (nonatomic, strong)UITableView *tableview;
@property (nonatomic, strong)UIWindow *window;

@end

@implementation MineMessViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.window = [[UIApplication sharedApplication] keyWindow];
    
    cor = [[UIControl alloc] init];
    cor.hidden = YES;
    
    cor.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [cor addTarget:self action:@selector(NOBtn) forControlEvents:UIControlEventTouchUpInside];
    
    cor.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    
    [_window addSubview:cor];
    
    

    
    backview = [[winView alloc] init];
    backview.layer.cornerRadius = 8;
    backview.backgroundColor = [UIColor whiteColor];
    backview.alpha = 0;
    [cor addSubview:backview];
    
    [backview mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.centerX.mas_equalTo(cor);
        make.centerY.mas_equalTo(cor);
        make.height.mas_equalTo(200);
        make.width.mas_equalTo(SCREEN_WIDTH - 60);
    }];
    

    type = 0;
    
    MessArrayWor = [NSMutableArray array];
    MessArraySys = [NSMutableArray array];
    
    
    [self addhead:@"我的消息"];
    
    [self getMessWor];
    
    self.view.backgroundColor = [myselfway stringTOColor:@"0xC4CED3"];
    
    [self tableview];
    
    
}


- (void)temp
{
    [super temp];
    
    [self.delegate tempVaalllllll];
    
}

//关闭窗口
- (void)NOBtn
{
    [UIView animateWithDuration:0.5 animations:^{
        
        backview.alpha = 0;
        
    } completion:^(BOOL finished) {
        cor.hidden = YES;
    }];
}


//加载弹窗view
- (void)initWindowsView : (MessDataDetail *)info
{
   
    backview.title.text = info.wm_title;
    backview.detail.text = info.wm_desc;
    
    NSString *time = [self timeWithTimeIntervalString:info.um_in_time];
    backview.time.text = time;
 
    
}



#pragma tableview

- (UITableView *)tableview
{
    if (!_tableview)
    {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 74, SCREEN_WIDTH, SCREEN_HEIGHT - 74) style:UITableViewStylePlain];
        
        _tableview.delegate = self;
        _tableview.dataSource = self;
        
        _tableview.backgroundColor = [myselfway stringTOColor:@"0xC4CED3"];
        
        [_tableview registerClass:[MessTableViewCell class] forCellReuseIdentifier:@"messcell"];
        
        [self.view addSubview:_tableview];
        
    }
    
    
    return _tableview;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (type == 0)
    {
        return MessArrayWor.count;
    }
    else
    {
        return MessArraySys.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MessDataDetail *data;
    
    if (type == 0)
    {
        data = [MessArrayWor objectAtIndex:indexPath.row];
    }
    else
    {
        data = [MessArraySys objectAtIndex:indexPath.row];
    }
    
    
    MessTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    
    
    if (!cell)
    {
        
        cell = [[MessTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"messcell"];
        
        cell.title.text = data.wm_title;
        cell.detail.text = data.wm_desc;
        
        if ([data.um_status isEqualToString:@"1"])
        {
            cell.svp.hidden = YES;
        }
        
        
        NSString *time = [self timeWithTimeIntervalString:data.um_in_time];
        
        cell.time.text = time;
        
    }
    
 
    return cell;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 62.5;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    MessDataDetail *data;
    
    if (type == 0)
    {
        data = [MessArrayWor objectAtIndex:indexPath.row];
        
        [self postMessWor:data.um_id type:@"0"];
        
    }
    else
    {
        data = [MessArraySys objectAtIndex:indexPath.row];
        
        [self postMessWor:data.um_id type:@"1"];
    }
    
    
    
    
    
   //调用弹窗
    
    [UIView animateWithDuration:0.5 animations:^{
        
        cor.hidden = NO;

        [self initWindowsView:data];
        
        backview.alpha = 1;
        
    } completion:^(BOOL finished)
    {
        
    }];
    
    
    
    
    
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    
    view.backgroundColor = [UIColor whiteColor];
    
    UIButton *left = [UIButton buttonWithType:UIButtonTypeCustom];
    
    left.frame = CGRectMake(0, 0, SCREEN_WIDTH / 2, 40);
    
    [left addTarget:self action:@selector(workerBtn) forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:left];
    
    UIButton *right = [UIButton buttonWithType:UIButtonTypeCustom];
    
    right.frame = CGRectMake(SCREEN_WIDTH / 2, 0, SCREEN_WIDTH / 2, 40);
    
    [right addTarget:self action:@selector(messBtn) forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:right];
    
    UILabel *leftlab = [[UILabel alloc] init];
    
    leftlab.text = @"工作邀约";
    
    leftlab.tag = 200;
    
    leftlab.textColor = [UIColor grayColor];
    
    leftlab.font = [UIFont systemFontOfSize:15];
    
    leftlab.textAlignment = NSTextAlignmentCenter;
    
    [view addSubview:leftlab];
    
    
    
    UILabel *rightlab = [[UILabel alloc] init];
    
    rightlab.text = @"系统消息";
    
    rightlab.textColor = [UIColor grayColor];
    
    rightlab.tag = 300;
    
    rightlab.font = [UIFont systemFontOfSize:15];
    
    rightlab.textAlignment = NSTextAlignmentCenter;
    
    [view addSubview:rightlab];
    
    
    if (type == 0)
    {
        leftlab.textColor = [UIColor redColor];
    }
    else
    {
        rightlab.textColor = [UIColor redColor];
    }
    
    
    [leftlab mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.centerX.mas_equalTo(left);
        make.top.mas_equalTo(left).offset(5);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
        
    }];
    
    
    
    [rightlab mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.centerX.mas_equalTo(right);
         make.top.mas_equalTo(right).offset(5);
         make.width.mas_equalTo(100);
         make.height.mas_equalTo(30);
         
     }];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(15, 39, SCREEN_WIDTH - 15, 1)];
    
    line.backgroundColor = [myselfway stringTOColor:@"0xE4E3E5"];
    
    [view addSubview:line];
    
    
    return view;
}




//工作邀约按钮
- (void)workerBtn
{
    type = 0;
  
    [self getMessWor];
}






//系统消息按钮
- (void)messBtn
{
    type = 1;
    
    
    [self getMessSys];
}



//获取消息数据的网络请求   系统
- (void)getMessSys
{
    NSString *url = [NSString stringWithFormat:@"%@Users/msgList?u_id=%@&wm_type=0", baseUrl, @"198"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject)
     {
         NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         
         if ([[dictionary objectForKey:@"code"] integerValue] == 1)
         {
             NSDictionary *dic = [dictionary objectForKey:@"data"];
             
             NSArray *arr = [dic objectForKey:@"data"];
             
             [MessArraySys removeAllObjects];
             
             for (int i = 0; i < arr.count; i++)
             {
                 
                 
                 NSDictionary *dic = [arr objectAtIndex:i];
                 
                 MessDataDetail *data = [[MessDataDetail alloc] init];
                 
                 data.wm_title = [dic objectForKey:@"wm_title"];
                 data.um_in_time = [dic objectForKey:@"um_in_time"];
                 data.wm_type = [dic objectForKey:@"wm_type"];
                 data.wm_id = [dic objectForKey:@"wm_id"];
                 data.um_id = [dic objectForKey:@"um_id"];
                 data.wm_desc = [dic objectForKey:@"wm_desc"];
                 data.um_status = [dic objectForKey:@"um_status"];
                 
                 [MessArraySys addObject:data];
                 
             }
             
             [self.tableview reloadData];
             
         }
         
         
     } failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         
     }];
    
    
}




//获取消息数据的网络请求   工作
- (void)getMessWor
{
    
    NSString *url = [NSString stringWithFormat:@"%@Users/msgList?u_id=%@&wm_type=1", baseUrl, @"198"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject)
     {
         NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         
         if ([[dictionary objectForKey:@"code"] integerValue] == 1)
         {
             NSDictionary *dic = [dictionary objectForKey:@"data"];
             
             NSArray *arr = [dic objectForKey:@"data"];
             
             [MessArrayWor removeAllObjects];
             
             for (int i = 0; i < arr.count; i++)
             {
                 NSDictionary *dic = [arr objectAtIndex:i];
                 
                 MessDataDetail *data = [[MessDataDetail alloc] init];
                 
                 data.wm_title = [dic objectForKey:@"wm_title"];
                 data.um_in_time = [dic objectForKey:@"um_in_time"];
                 data.wm_type = [dic objectForKey:@"wm_type"];
                 data.wm_id = [dic objectForKey:@"wm_id"];
                 data.um_id = [dic objectForKey:@"um_id"];
                 data.wm_desc = [dic objectForKey:@"wm_desc"];
                 data.um_status = [dic objectForKey:@"um_status"];
                 
                 [MessArrayWor addObject:data];
                 
             }
             
             [self.tableview reloadData];
             
         }
         
         
     } failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         
     }];
    
    
}

- (NSString *)timeWithTimeIntervalString:(NSString *)timeString
{
    //时间戳转化成时间
    NSDateFormatter *stampFormatter = [[NSDateFormatter alloc] init];
    [stampFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    NSInteger time = [timeString integerValue];
    
    //以 1970/01/01 GMT为基准，然后过了secs秒的时间
    NSDate *stampDate2 = [NSDate dateWithTimeIntervalSince1970:time];
    
    
    
    //  NSLog(@"时间戳转化时间 >>> %@",[stampFormatter stringFromDate:stampDate2]);
    
    return [stampFormatter stringFromDate:stampDate2];
}



- (void)postMessWor: (NSString *)um_id type:(NSString *)type_id
{
    
    NSString *url = [NSString stringWithFormat:@"%@Users/msgReadEdit?um_id=%@", baseUrl, um_id];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject)
     {
         NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         
         if ([[dictionary objectForKey:@"code"] integerValue] == 1)
         {
             NSDictionary *dic = [dictionary objectForKey:@"data"];
             
             if ([type_id isEqualToString:@"0"])
             {
                 [self getMessWor];
             }
             else
             {
                 [self getMessSys];
             }
             
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
