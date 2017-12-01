//
//  ServiceViewController.m
//  worker
//
//  Created by 郭健 on 2017/8/15.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "ServiceViewController.h"
#import "ReadDetailViewController.h"

@interface ServiceViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *dataArray;
    
    NSString *titleText;
    
    CGFloat height;
}



@property (nonatomic, strong)UITableView *tableview;



@end


@implementation ServiceData


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



- (void)temp
{
    if ([_type isEqualToString:@"1"])
    {
        [self dismissViewControllerAnimated:NO completion:nil];
    }
    else
    {
        [super temp];
    }
}







- (UITableView *)tableview
{
    if (!_tableview)
    {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 44 + StatusBarHeigh, SCREEN_WIDTH, SCREEN_HEIGHT - 44 - StatusBarHeigh) style:UITableViewStylePlain];

        [_tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];

        _tableview.backgroundColor = [myselfway stringTOColor:@"0xC4CED3"];

        _tableview.delegate = self;
        _tableview.dataSource = self;

        [self.view addSubview:_tableview];

   
    }

    return _tableview;
    
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (dataArray.count > 1)
    {
        return dataArray.count;
    }
    else
    {
        return 1;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (dataArray.count > 1)
    {

        ServiceData *data = [dataArray objectAtIndex:indexPath.row];
        
        if (!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
            
            UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 300, 30)];
            
            name.textAlignment = NSTextAlignmentLeft;
            name.font = [UIFont systemFontOfSize:15];
            name.text = data.a_title;
            
            
            [cell addSubview:name];
            
        }
        
        
    }
    else
    {
        
        if (!cell)
        {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            UITextView *view = [[UITextView alloc] init];
            
            view.userInteractionEnabled = NO;
   
            view.text = [NSString stringWithFormat:@"%@", titleText];
            
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            
            paragraphStyle.lineSpacing = 1; //行距
            
            NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:15], NSParagraphStyleAttributeName:paragraphStyle};
            
            view.attributedText = [[NSAttributedString alloc]initWithString:view.text attributes:attributes];
            
            [cell addSubview:view];
            
            [view mas_makeConstraints:^(MASConstraintMaker *make)
             {
                 make.top.mas_equalTo(cell).offset(10);
                 make.left.mas_equalTo(cell).offset(25);
                 make.right.mas_equalTo(cell).offset(-25);
                 make.bottom.mas_equalTo(cell).offset(-10);
            }];
            
        }
    }
    
    return cell;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (dataArray.count > 1)
    {
        return 50;
    }
    else
    {
        return height + 170;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (dataArray.count > 1)
    {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        ServiceData *data = [dataArray objectAtIndex:indexPath.row];
        
        self.hidesBottomBarWhenPushed = YES;
        
        ReadDetailViewController *temp = [[ReadDetailViewController alloc] init];
        
        temp.a_id = data.a_id;
        
        [self.navigationController pushViewController:temp animated:YES];
    }
    else
    {
        
    }
    
    
    
}



//服务条款页
- (void)logindata
{
    
    NSString *url = [NSString stringWithFormat:@"%@Articles/articlesList?ac_id=29&son=1", baseUrl];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject)
     {
         NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         
         if ([[dictionary objectForKey:@"code"] integerValue] == 1)
         {
             
             NSArray *dic = [dictionary objectForKey:@"data"];
             
             for (int i = 0; i < dic.count; i++)
             {
                 NSDictionary *data = [dic objectAtIndex:i];
                 
                 ServiceData *info = [[ServiceData alloc] init];
                 
                 info.a_id = [data objectForKey:@"a_id"];
                 info.a_title = [data objectForKey:@"a_title"];
                 info.a_in_time = [data objectForKey:@"a_in_time"];
                 info.a_link = [data objectForKey:@"a_link"];
                 info.a_img = [data objectForKey:@"a_img"];
                 info.a_top = [data objectForKey:@"a_top"];
                 info.a_recommend = [data objectForKey:@"a_recommend"];
                 info.a_desc = [data objectForKey:@"a_desc"];
                 
                 
                 titleText = info.a_desc;
                 
                 [dataArray addObject:info];
             }

         }
         
       
        CGSize mas = [self sizeWithFont:[UIFont systemFontOfSize:15] maxSize:CGSizeMake(SCREEN_WIDTH - 50, 3000) string:titleText];
         
        height = mas.height;
         
         
        [self tableview];
      
         
         
         
     }
         failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         
     }];
    
    
}







- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize string:(NSString *)string
{
    
    NSDictionary *attrs = @{NSFontAttributeName:font};
    
    return [string boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
