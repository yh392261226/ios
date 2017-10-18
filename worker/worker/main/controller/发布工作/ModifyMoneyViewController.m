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
    
    
}

@property (nonatomic, strong)UITableView *tableview;

@end

@implementation ModifyMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    dataArray = [NSMutableArray array];
    
}


//制作页面数据
- (void)initUIdata
{
    NSMutableArray *arr = [NSMutableArray array];
    
    ModifyModel *model = [[ModifyModel alloc] init];
    
    model.type = @"1";
    
    model.worker = @"瓦工";
    
    [arr addObject:model];
    
    
    ModifyModel *model1 = [[ModifyModel alloc] init];
    
    model1.type = @"2";
    
    [arr addObject:model1];
    
    
    ModifyModel *model2 = [[ModifyModel alloc] init];
    
    model2.type = @"3";
    
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
        
        
        
        return cell;
    }
    else if ([model.type isEqualToString:@"2"])
    {
        elsepersonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"personcell"];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        return cell;
    }
    else
    {
        elsetimeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    

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



- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 200;
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
