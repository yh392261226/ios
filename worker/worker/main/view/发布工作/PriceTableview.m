//
//  PriceTableview.m
//  worker
//
//  Created by sd on 2017/10/14.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "PriceTableview.h"
#import "PriceTableViewCell.h"



@implementation RedPrice


@end



@implementation PriceTableview

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    
    if (self)
    {
        dataArray = [NSMutableArray array];
        
        
        [self getData];
        
        
        
        self.delegate = self;
        self.dataSource = self;
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self registerClass:[PriceTableViewCell class] forCellReuseIdentifier:@"cell"];
        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:@"elsecell"];
        
    }
    
    
    
    return self;
    
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
    RedPrice *info = [dataArray objectAtIndex:indexPath.section];
    
    if ([info.type isEqualToString:@"0"])
    {
        PriceTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        if (!cell)
        {
            cell = [[PriceTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
            
            cell.seleced.tag = indexPath.section + 900;
            
            cell.seleced.backgroundColor = [UIColor grayColor];
            
            
            cell.money.text = info.b_info;
            cell.text.text = info.bt_info;
            cell.time.text = [NSString stringWithFormat:@"最终使用日期截止 %@", info.b_end_time];
            
            if (index == indexPath)
            {
                cell.seleced.image = [UIImage imageNamed:@"job_dd"];
            }
            
    
        }
        
        return cell;
    }
    else
    {
        
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        if (!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"elsecell"];

            UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(30, 35, 200, 30)];

            name.font = [UIFont systemFontOfSize:16];
            
            name.text = @"没有更多的优惠券";
            
            [cell addSubview:name];
            
        }
        
        return cell;
        
    }
    
    
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}




- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    
    return view;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    
    return view;
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
        return 0.1;
    }
    else
    {
        return 10;
    }
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    RedPrice *data = [dataArray objectAtIndex:indexPath.section];
    
    if ([data.type isEqualToString:@"0"])
    {
        index = indexPath;
        
        [self reloadData];
    }
    
    
}






- (void)getData
{
    NSString *url = [NSString stringWithFormat:@"%@Bouns/index?bt_withdraw=0", baseUrl];
    
    NSLog(@"%@", url);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject)
     {
         NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         
         if ([[dictionary objectForKey:@"code"] integerValue] == 200)
         {
             NSArray *arrData = [dictionary objectForKey:@"data"];
             
             for (int i = 0; i < arrData.count; i++)
             {
                 NSDictionary *dicData = [arrData objectAtIndex:i];
                 
                 RedPrice *data = [[RedPrice alloc] init];
                 
                 data.b_id = [dicData objectForKey:@"b_id"];
                 data.bd_id = [dicData objectForKey:@"bd_id"];
                 data.bt_id = [dicData objectForKey:@"bd_id"];
                 data.b_start_time = [dicData objectForKey:@"b_start_time"];
                 data.b_end_time = [dicData objectForKey:@"b_end_time"];
                 data.b_total = [dicData objectForKey:@"b_total"];
                 data.b_offset = [dicData objectForKey:@"b_offset"];
                 data.b_status = [dicData objectForKey:@"b_status"];
                 data.b_type = [dicData objectForKey:@"b_type"];
                 data.b_author = [dicData objectForKey:@"b_author"];
                 data.b_in_time = [dicData objectForKey:@"b_in_time"];
                 data.b_last_editor = [dicData objectForKey:@"b_last_editor"];
                 data.b_last_edit_time = [dicData objectForKey:@"b_last_edit_time"];
                 data.b_info = [dicData objectForKey:@"b_info"];
                 data.b_amount = [dicData objectForKey:@"b_amount"];
                 data.bd_serial = [dicData objectForKey:@"bd_serial"];
                 data.bd_author = [dicData objectForKey:@"bd_author"];
                 data.bd_use_time = [dicData objectForKey:@"bd_use_time"];
                 data.bt_name = [dicData objectForKey:@"bt_name"];
                 data.bt_info = [dicData objectForKey:@"bt_info"];
                 data.bt_withdraw = [dicData objectForKey:@"bt_withdraw"];
                 data.type = @"0";
                 
                 [dataArray addObject:data];
             }
             
             RedPrice *info = [[RedPrice alloc] init];
             
             info.type = @"1";
             
             [dataArray addObject:info];
             
             [self reloadData];
             
             
         }
         
     } failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         
     }];
    
    
}



@end
