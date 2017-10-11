//
//  DressingWorkerViewController.m
//  worker
//
//  Created by 郭健 on 2017/8/16.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "DressingWorkerViewController.h"
#import "DressworkerUITableViewCell.h"
#import "DressTableViewCell.h"

@interface DressWorkerData1 : NSObject

@property (nonatomic, strong)NSString *s_id;
@property (nonatomic, strong)NSString *s_name;
@property (nonatomic, strong)NSString *s_info;
@property (nonatomic, strong)NSString *s_desc;
@property (nonatomic, strong)NSString *s_status;


@property (nonatomic, strong)NSString *s_image;


@end

@implementation DressWorkerData1


@end


@interface DressingWorkerViewController ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
{
    NSMutableArray *dataArray;
    
    NSMutableArray *gongzhongArr;   //传给后台的工种名称数组
    
    NSMutableArray *nameArr;
    
    NSString *nameStr;    //编辑框内容
    
    NSString *range;     //搜索范围
    NSString *project;   //选择工期
    NSString *money;     //工资金额
    NSString *time;      //项目时间
    NSString *proType;   //项目类型
    NSString *worker;    //选择工种
    
    NSMutableArray *rangeArray;   //搜索范围的数组
    NSMutableArray *projectArray;  //选择工期的数组
    NSMutableArray *moneyArray;    //工资金额的数组
    NSMutableArray *timeArray;     //项目开始时间数组
    
    
    
    
    
    NSMutableArray *workerArray;   //工种数组
    NSMutableArray *projectTypeArray;    //项目类型数组
    
}


@property (nonatomic, strong)UITableView *tableview;

@end

@implementation DressingWorkerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    workerArray = [NSMutableArray array];
    projectArray = [NSMutableArray array];
    gongzhongArr = [NSMutableArray array];
    
    rangeArray = [NSMutableArray arrayWithObjects:@"2公里以内", @"5公里以内", @"10公里以内", @"10公里以上", nil];
    projectArray = [NSMutableArray arrayWithObjects:@"2日内",@"五日内",@"十日内",@"一个月内",@"一个月以上", nil];
    moneyArray = [NSMutableArray arrayWithObjects:@"500元以内",@"1000元以内",@"2000元以内",@"2000元以上", nil];
    timeArray = [NSMutableArray arrayWithObjects:@"1天内",@"3天内",@"一周内",@"两周内",@"两周以上", nil];
    
    
    dataArray = [NSMutableArray array];
    
    nameArr = [NSMutableArray arrayWithObjects:@"搜索范围:",@"选择工期",@"工资金额", @"项目时间", @"项目类型", @"选择工种", nil];
    
    
    [dataArray addObject:@"1"];
    [dataArray addObject:@"1"];
    [dataArray addObject:@"1"];
    
    
    
    [self addhead:@"工作信息筛选"];
    
    [self tableview];
    
    [self getWorkerdata];
    
    UIButton *Mess = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [Mess setBackgroundImage:[UIImage imageNamed:@"main_sousuo"] forState:UIControlStateNormal];
    
    [Mess addTarget:self action:@selector(MessBtn) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:Mess];
    
    [Mess mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.mas_equalTo(self.view).offset(30);
         make.right.mas_equalTo(self.view).offset(-15);
         make.height.mas_equalTo(22);
         make.width.mas_equalTo(22);
     }];
}



#pragma Tableview

- (UITableView *)tableview
{
    if (!_tableview)
    {
        
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 65, SCREEN_WIDTH, SCREEN_HEIGHT - 65) style:UITableViewStylePlain];
        
        [_tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        [_tableview registerClass:[DressworkerUITableViewCell class] forCellReuseIdentifier:@"allcell"];
        [_tableview registerClass:[DressTableViewCell class] forCellReuseIdentifier:@"historycell"];

        
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _tableview.scrollEnabled = NO;
        
        _tableview.backgroundColor = [myselfway stringTOColor:@"0xC4CED3"];
        
        _tableview.delegate = self;
        _tableview.dataSource = self;
        
        [self.view addSubview:_tableview];
        
    }
    
    return _tableview;
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 7;
    }
    else
    {
        return dataArray.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        if (indexPath.row == 0)
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
            
            UITextField *field = [[UITextField alloc] initWithFrame:CGRectMake(20, 5, SCREEN_WIDTH - 40, 30)];
            
            field.delegate = self;
            
            field.placeholder = @"请输入工人姓名";
            
            field.text = nameStr;
            
            [field addTarget:self action:@selector(textchange:) forControlEvents:UIControlEventEditingChanged];
            
            field.borderStyle = UITextBorderStyleRoundedRect;
            
            [cell addSubview:field];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
        }
        else
        {
            DressworkerUITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"allcell"];
            
            cell.name.text = [nameArr objectAtIndex:indexPath.row - 1];
        
            if (indexPath.row == 1)
            {
                cell.data.text = range;
            }
            else if (indexPath.row == 2)
            {
                cell.data.text = project;
            }
            else if (indexPath.row == 3)
            {
                cell.data.text = money;
            }
            else if (indexPath.row == 4)
            {
                cell.data.text = time;
            }
            else if (indexPath.row == 5)
            {
                cell.data.text = proType;
            }
            else
            {
                cell.data.text = worker;
            }
            
            return cell;
        }
        
        
    }
    else
    {
        DressTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        if (!cell)
        {
            cell = [[DressTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"historycell"];
            
            
            cell.close.tag = indexPath.row + 400;
            
            [cell.close addTarget:self action:@selector(closeBtn:) forControlEvents:UIControlEventTouchUpInside];
            
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1)
    {
        return 50;
    }
    else
    {
        return 0.1;
    }
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    
    view.backgroundColor = [myselfway stringTOColor:@"0xC4CED3"];
    
    if (section == 1)
    {
        UILabel *title = [[UILabel alloc] init];
        
        if (dataArray.count == 0)
        {
            title.text = nil;
        }
        else
        {
            title.text = @"搜索历史";
        }
        
        
        title.font = [UIFont systemFontOfSize:16];
        
        title.frame = CGRectMake(15, 20, 150, 30);
        
        [view addSubview:title];
    }
    
    return view;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0)
    {
        if (indexPath.row == 1)
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"搜索范围" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleCancel handler:nil];
            
            [alertController addAction:cancelAction];
            
            for (int i = 0; i < rangeArray.count; i++)
            {
                UIAlertAction *action = [UIAlertAction actionWithTitle:[rangeArray objectAtIndex:i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                                         {
                                             range = action.title;
                                             
                                             [self.tableview reloadData];
                                         }];
                
                [alertController addAction:action];
            }
            
            [self presentViewController:alertController animated:YES completion:nil];
            
        }
        else if (indexPath.row == 2)
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"选择工期" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleCancel handler:nil];
            
            [alertController addAction:cancelAction];
            
            for (int i = 0; i < projectArray.count; i++)
            {
                UIAlertAction *action = [UIAlertAction actionWithTitle:[projectArray objectAtIndex:i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                                         {
                                             project = action.title;
                                             
                                             [self.tableview reloadData];
                                         }];
                
                [alertController addAction:action];
            }
            
            [self presentViewController:alertController animated:YES completion:nil];
        }
        else if (indexPath.row == 3)
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"工资金额" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleCancel handler:nil];
            
            [alertController addAction:cancelAction];
            
            for (int i = 0; i < moneyArray.count; i++)
            {
                UIAlertAction *action = [UIAlertAction actionWithTitle:[moneyArray objectAtIndex:i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                                         {
                                             money = action.title;
                                             
                                             [self.tableview reloadData];
                                         }];
                
                [alertController addAction:action];
            }
            
            [self presentViewController:alertController animated:YES completion:nil];
        }
        else if (indexPath.row == 4)
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"项目时间" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleCancel handler:nil];
            
            [alertController addAction:cancelAction];
            
            for (int i = 0; i < timeArray.count; i++)
            {
                UIAlertAction *action = [UIAlertAction actionWithTitle:[timeArray objectAtIndex:i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                                         {
                                             time = action.title;
                                             
                                             [self.tableview reloadData];
                                         }];
                
                [alertController addAction:action];
            }
            
            [self presentViewController:alertController animated:YES completion:nil];
        }
        else if (indexPath.row == 6)
        {
            [gongzhongArr removeAllObjects];
            
            for (int i = 0; i < workerArray.count; i++)
            {
                DressWorkerData1 *data = [workerArray objectAtIndex:i];
                
                [gongzhongArr addObject:data.s_name];
            }
            
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"选择工种" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleCancel handler:nil];
            
            [alertController addAction:cancelAction];
            
            for (int i = 0; i < gongzhongArr.count; i++)
            {
                UIAlertAction *action = [UIAlertAction actionWithTitle:[gongzhongArr objectAtIndex:i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                                         {
                                             worker = action.title;
                                             
                                             [self.tableview reloadData];
                                         }];
                
                [alertController addAction:action];
            }
            
            [self presentViewController:alertController animated:YES completion:nil];
            
        }
        
    }
    
    
    
}



//删除
- (void)closeBtn: (UIButton *)btn
{
    NSInteger CellNum = btn.tag - 400;
    
    [dataArray removeObjectAtIndex:CellNum];
    
    [self.tableview reloadData];
}


//重写返回的方法
- (void)temp
{
    [self dismissViewControllerAnimated:YES completion:nil];
}



//获取编辑框内容
- (void)textchange: (UITextField *)textfield
{
    nameStr = textfield.text;
}















//重写alert
- (void)initAlert: (NSMutableArray *)dataArrayAlert title: (NSString *)name type:(NSInteger)typpp
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:name preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleCancel handler:nil];
    
    [alertController addAction:cancelAction];
    
    
    for (int i = 0; i < dataArrayAlert.count; i++)
    {
        UIAlertAction *action = [UIAlertAction actionWithTitle:[dataArrayAlert objectAtIndex:i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                                 {
                                     if (typpp == 1)
                                     {
                                         range = action.title;
                                     }
                                     else if (typpp == 2)
                                     {
                                         project = action.title;
                                     }
                                     else if (typpp == 3)
                                     {
                                         money = action.title;
                                     }
                                     else if (typpp == 4)
                                     {
                                         time = action.title;
                                     }
                                     else if (typpp == 5)
                                     {
                                         proType = action.title;
                                     }
                                     else
                                     {
                                         worker = action.title;
                                     }
                                     
                                     
                                     [self.tableview reloadData];
                                     
                                 }];
        
        [alertController addAction:action];
    }
    
    
    
    [self presentViewController:alertController animated:YES completion:nil];
    
    
}





//搜索按钮
- (void)MessBtn
{
    
}



//获取工种列表网络请求
- (void)getWorkerdata
{
    
    NSString *url = [NSString stringWithFormat:@"%@%@", baseUrl, @"Skills/index"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject)
     {
         NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         
         if ([[dictionary objectForKey:@"code"] integerValue] == 200)
         {
             NSArray *arr = [dictionary objectForKey:@"data"];
             
             for (int i = 0; i < arr.count; i++)
             {
                 NSDictionary *dic = [arr objectAtIndex:i];
                 
                 DressWorkerData1 *data = [[DressWorkerData1 alloc] init];
                 
                 data.s_id = [dic objectForKey:@"s_id"];
                 data.s_desc = [dic objectForKey:@"s_desc"];
                 data.s_info = [dic objectForKey:@"s_info"];
                 data.s_name = [dic objectForKey:@"s_name"];
                 data.s_status = [dic objectForKey:@"s_status"];
                 
                 [workerArray addObject:data];
                 
                 
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
