//
//  EvaluateViewController.m
//  worker
//
//  Created by 郭健 on 2017/8/14.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "EvaluateViewController.h"
#import "TypeView.h"
#import "EvaluateTableViewCell.h"

@interface getMyEva : NSObject

@property (nonatomic, strong)NSString *tc_id;
@property (nonatomic, strong)NSString *u_id;
@property (nonatomic, strong)NSString *t_id;
@property (nonatomic, strong)NSString *tc_u_id;
@property (nonatomic, strong)NSString *tc_in_time;
@property (nonatomic, strong)NSString *tce_desc;
@property (nonatomic, strong)NSString *u_img;
@property (nonatomic, strong)NSString *tc_start;


@end

@implementation getMyEva


@end

@interface postOtherEva : NSObject

@property (nonatomic, strong)NSString *tc_id;
@property (nonatomic, strong)NSString *t_id;
@property (nonatomic, strong)NSString *tc_u_id;
@property (nonatomic, strong)NSString *tc_start;
@property (nonatomic, strong)NSString *tc_in_time;
@property (nonatomic, strong)NSString *tce_desc;
@property (nonatomic, strong)NSString *u_img;



@end

@implementation postOtherEva


@end

@interface EvaluateViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *dataArray;
    
    TypeView *typeView;  //上面选择类型的view
    
    NSMutableArray *nameArr;   //类型上的view名字数组,传给自定义view
    
    NSInteger typeI;     //判断点击的是我的评价还是别人对我的评价
    
    NSMutableArray *workerArray;    //收到的评价
    
}

@property (nonatomic, strong)UITableView *tableview;

@end

@implementation EvaluateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    typeI = 0;
    
    dataArray = [NSMutableArray array];
    
    workerArray = [NSMutableArray array];
    
    
    nameArr = [NSMutableArray arrayWithObjects:@"收到的评价", @"给别人的评价", nil];
    
    [self getMydata];

    [self addhead:@"我的评价"];
    
    [self slitherBack:self.navigationController];
    
    [self tableview];
    
    [self initTypeView];
    
}



#pragma tableview 代理方法

- (UITableView *)tableview
{
    if (!_tableview)
    {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 104, SCREEN_WIDTH, SCREEN_HEIGHT - 104) style:UITableViewStyleGrouped];
        
        [_tableview registerClass:[EvaluateTableViewCell class] forCellReuseIdentifier:@"cell"];
        
        _tableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.1)];
        _tableview.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.1)];
        
        
        _tableview.backgroundColor = [myselfway stringTOColor:@"0xC4CED3"];
        
        _tableview.delegate = self;
        _tableview.dataSource = self;
        
        [self.view addSubview:_tableview];
    }
    
    return _tableview;
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (typeI == 0)
    {
        return workerArray.count;
    }
    else
    {
        return dataArray.count;
    }
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (typeI == 0)
    {
        //给我的评价
        
        getMyEva *data = [workerArray objectAtIndex:indexPath.section];
        
        EvaluateTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        if (!cell)
        {
            cell = [[EvaluateTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            NSString *str = [myselfway timeWithTimeIntervalString:data.tc_in_time];
            
            cell.timer.text = str;
            
            cell.title.text = data.tce_desc;
            
            NSURL *url = [NSURL URLWithString:data.u_img];
            
            [cell.logoimage sd_setImageWithURL:url];
            
            if ([data.tc_start isEqualToString:@"1"])
            {
                cell.evaluate.image = [UIImage imageNamed:@"evalu_1"];
            }
            else if ([data.tc_start isEqualToString:@"2"])
            {
                cell.evaluate.image = [UIImage imageNamed:@"evalu_2"];
            }
            else if([data.tc_start isEqualToString:@"0"])
            {
                cell.evaluate.image = [UIImage imageNamed:@"evalu_0"];
            }
            else
            {
                cell.evaluate.image = [UIImage imageNamed:@"evalu_3"];
            }
            
        }
       
        return cell;
    }
    else
    {
        //我给别人的评价
        
        postOtherEva *data = [dataArray objectAtIndex:indexPath.section];
        
        EvaluateTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        if (!cell)
        {
            cell = [[EvaluateTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
            if ([data.tc_start isEqualToString:@"1"])
            {
                cell.evaluate.image = [UIImage imageNamed:@"evalu_1"];
            }
            else if ([data.tc_start isEqualToString:@"2"])
            {
                cell.evaluate.image = [UIImage imageNamed:@"evalu_2"];
            }
            else if([data.tc_start isEqualToString:@"0"])
            {
                cell.evaluate.image = [UIImage imageNamed:@"evalu_0"];
            }
            else
            {
                cell.evaluate.image = [UIImage imageNamed:@"evalu_3"];
            }
            
            
            NSURL *url = [NSURL URLWithString:data.u_img];
            
            [cell.logoimage sd_setImageWithURL:url];
            
            
            NSString *str = [myselfway timeWithTimeIntervalString:data.tc_in_time];
            
            cell.timer.text = str;
            
            cell.title.text = data.tce_desc;
            
        }
        
        return cell;
        
    }
    

    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 40;
    }
    else
    {
        return 10;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    
    return view;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    
    
    
    if (section == 0)
    {
        UIView *back = [[UIView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 30)];
        
        back.backgroundColor = [UIColor whiteColor];
        
        [view addSubview:back];
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 300, 20)];
        
        if (typeI == 0)
        {
            title.text = [NSString stringWithFormat:@"我收到的评价(%ld)", workerArray.count];
        }
        else
        {
           title.text = [NSString stringWithFormat:@"给别人的评价(%ld)", dataArray.count];
        }
        
        title.textColor = [UIColor grayColor];
        
        title.font = [UIFont systemFontOfSize:13];
        
        [back addSubview:title];
        
        
    }

    return view;
}






#pragma type的view
- (void)initTypeView
{
    self.view.backgroundColor = [myselfway stringTOColor:@"0xC4CED3"];
    
    typeView = [[TypeView alloc] initWithFrame:CGRectMake(0, 69, SCREEN_WIDTH, 40)];
    
    typeView.delegate = self;
    
    typeView.backgroundColor = [UIColor whiteColor];
    
    typeView.nameArray = nameArr;
    
    [self.view addSubview:typeView];
    
}


//上面选择栏点击事件的代理方法
- (void)tempVal: (NSInteger)type
{
    NSInteger i = type - 500;
    
    if (i == 0)
    {
        typeI = 0;
        
        [self getMydata];
    }
    else
    {
        typeI = 1;
        
        [self postMydata];
    }
    
   // [self.tableview reloadData];
}





//别人给我的评价
- (void)getMydata
{
    NSString *url = [NSString stringWithFormat:@"%@Users/otherCommentUser?tc_u_id=%@", baseUrl, user_ID];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject)
     {
         NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         
         if ([[dictionary objectForKey:@"code"] integerValue] == 1)
         {
             
             [workerArray removeAllObjects];
             
             NSDictionary *dic = [dictionary objectForKey:@"data"];
             
             NSArray *arr = [dic objectForKey:@"data"];
             
             for (int i = 0; i < arr.count; i++)
             {
                 NSDictionary *dic = [arr objectAtIndex:i];
                 
                 getMyEva *data = [[getMyEva alloc] init];
                 
                 data.tc_id = [dic objectForKey:@"tc_id"];
                 data.u_id = [dic objectForKey:@"u_id"];
                 data.t_id = [dic objectForKey:@"t_id"];
                 data.tc_u_id = [dic objectForKey:@"tc_u_id"];
                 data.tc_in_time = [dic objectForKey:@"tc_in_time"];
                 data.tce_desc = [dic objectForKey:@"tce_desc"];
                 data.u_img = [dic objectForKey:@"u_img"];
                 data.tc_start = [dic objectForKey:@"tc_start"];
                 
                 [workerArray addObject:data];
                 
             }
             
             
             
             [self.tableview reloadData];
             
             
             
         }
         
         
         
     } failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         
     }];
    
    
}




//我给别人的评价
- (void)postMydata
{
    NSString *url = [NSString stringWithFormat:@"%@Users/userCommentOther?u_id=%@", baseUrl, user_ID];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject)
     {
         NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         
         if ([[dictionary objectForKey:@"code"] integerValue] == 1)
         {
             
             [dataArray removeAllObjects];
             
             NSDictionary *dic = [dictionary objectForKey:@"data"];
             
             NSArray *arr = [dic objectForKey:@"data"];
             
             for (int i = 0; i < arr.count; i++)
             {
                 NSDictionary *dic = [arr objectAtIndex:i];
                 
                 postOtherEva *data = [[postOtherEva alloc] init];
                 
                 data.tc_id = [dic objectForKey:@"tc_id"];
                 data.t_id = [dic objectForKey:@"t_id"];
                 data.tc_u_id = [dic objectForKey:@"tc_u_id"];
                 data.tc_start = [dic objectForKey:@"tc_start"];
                 data.tc_in_time = [dic objectForKey:@"tc_in_time"];
                 data.tce_desc = [dic objectForKey:@"tce_desc"];
                 data.u_img = [dic objectForKey:@"u_img"];
             
                 
                 [dataArray addObject:data];
                 
             }
             
             
             
             [self.tableview reloadData];
             
             
             
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
