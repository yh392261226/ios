//
//  ModifyMoneyViewController.m
//  worker
//
//  Created by ios_g on 2017/10/18.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "ModifyMoneyViewController.h"
#import "PreviewTableViewCell.h"
#import "elsepersonTableViewCell.h"
#import "elsetimeTableViewCell.h"

@interface ModifyModel : NSObject

@property (nonatomic, strong)NSString *type;
@property (nonatomic, strong)NSString *worker;
@property (nonatomic, strong)NSString *person;
@property (nonatomic, strong)NSString *money;
@property (nonatomic, strong)NSString *startTime;
@property (nonatomic, strong)NSString *endTime;

@end


@implementation ModifyModel



@end


@interface ModifyMoneyViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *dataArray;
    
    NSString *valMoney;  //修改后的价格
}

@property (nonatomic, strong)UITableView *tableview;

@end

@implementation ModifyMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    dataArray = [NSMutableArray array];
    
    [self addhead:@"修改工资"];
    
    [self initUIdata];
    
    [self tableview];
    
}


//制作页面数据
- (void)initUIdata
{
    NSMutableArray *arr = [NSMutableArray array];
    
    ModifyModel *model = [[ModifyModel alloc] init];
    
    model.type = @"1";
    
    model.worker = self.worName;
    
    [arr addObject:model];
    
    
    ModifyModel *model1 = [[ModifyModel alloc] init];
    
    model1.type = @"2";
    
    model1.person = self.person;
    model1.money = self.money;
    
    [arr addObject:model1];
    
    
    ModifyModel *model2 = [[ModifyModel alloc] init];
    
    model2.type = @"3";
    
    model2.startTime = self.startTime;
    model2.endTime = self.endTime;
    
    [arr addObject:model2];
    
    [dataArray addObject:arr];
    
    
}



#pragma tableview代理

- (UITableView *)tableview
{
    if (!_tableview)
    {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 65, SCREEN_WIDTH, SCREEN_HEIGHT - 65) style:UITableViewStyleGrouped];
        

        _tableview.backgroundColor = [myselfway stringTOColor:@"0xC4CED3"];
        
        [_tableview registerClass:[PreviewTableViewCell class] forCellReuseIdentifier:@"1111cell"];
        [_tableview registerClass:[elsepersonTableViewCell class] forCellReuseIdentifier:@"personcell"];
        [_tableview registerClass:[elsetimeTableViewCell class] forCellReuseIdentifier:@"cell"];
        
        _tableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.1)];
        _tableview.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.1)];
        
        _tableview.delegate = self;
        _tableview.dataSource = self;
        
        [self.view addSubview:_tableview];
    }
    
    return _tableview;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *arr = [dataArray objectAtIndex:section];
    
    return arr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *arr = [dataArray objectAtIndex:indexPath.section];
    
    ModifyModel *model = [arr objectAtIndex:indexPath.row];
    
    if ([model.type isEqualToString:@"1"])
    {
        PreviewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"1111cell"];
        
        cell.name.text = @"工种:";
        cell.data.text = model.worker;
        
        cell.name.font = [UIFont systemFontOfSize:15];
        
        return cell;
    }
    else if ([model.type isEqualToString:@"2"])
    {
        
        elsepersonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"personcell"];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.personfield.text = model.person;
        cell.moneyfield.text = model.money;
        
        
        [cell.moneyfield addTarget:self action:@selector(MoMoney:) forControlEvents:UIControlEventEditingChanged];
        
        cell.personfield.enabled = NO;
        
        
        return cell;
        
    }
    else
    {
        elsetimeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSString *sta = [myselfway timeWithTimeIntervalString:self.startTime];
        NSString *end = [myselfway timeWithTimeIntervalString:self.endTime];
        
        cell.startTime.text = sta;
        cell.endTime.text = end;
        
        return cell;
    }
    

}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    
    UIButton *save = [UIButton buttonWithType:UIButtonTypeSystem];
    
    [save setTitle:@"确认提交" forState:UIControlStateNormal];
    
    [save addTarget:self action:@selector(Escbtn) forControlEvents:UIControlEventTouchUpInside];
    
    save.backgroundColor = [myselfway stringTOColor:@"0x2E84F8"];
    
    save.layer.cornerRadius = 5;
    
    save.frame = CGRectMake(15, 20, SCREEN_WIDTH - 30, 40);
    
    save.tintColor = [UIColor whiteColor];
    
    [view addSubview:save];
    
    
    return view;
}




- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    
    UILabel *title = [[UILabel alloc] init];
    
    title.numberOfLines = 2;
    
    title.text = @"请于工人确认好工资、工期再进行修改\n以免对您造成不便";
    
    title.textAlignment = NSTextAlignmentCenter;
    
    title.font = [UIFont systemFontOfSize:15];
    
    [view addSubview:title];
    
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(view).offset(0);
        make.left.mas_equalTo(view).offset(50);
        make.right.mas_equalTo(view).offset(-50);
        make.height.mas_equalTo(60);
        
    }];
    
    return view;
}



- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 70;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}




//确认提交按钮
- (void)Escbtn
{
    [self Nomoney];
}


- (void)MoMoney: (UITextField *)textfield
{
    valMoney = textfield.text;
}





//修改价格
- (void)Nomoney
{
    NSString *sta = [myselfway timeWithTimeIntervalString:self.startTime];
    NSString *end = [myselfway timeWithTimeIntervalString:self.endTime];
    
    NSString *url = [NSString stringWithFormat:@"%@Orders/index?action=price&tew_id=%@&t_id=%@&t_author=%@&amount=%@&worker_num=%@&start_time=%@&end_time=%@&o_worker=%@", baseUrl, self.tew_id, self.t_id, user_ID, valMoney, self.person, sta, end, self.o_worker];

    NSLog(@"%@", url);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject)
     {
         NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         
         if ([[dictionary objectForKey:@"code"] integerValue] == 200)
         {
             
             NSDictionary *dic = [dictionary objectForKey:@"data"];
             
             NSLog(@"%@", dic);
             
             [self.navigationController popViewControllerAnimated:NO];
  
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
