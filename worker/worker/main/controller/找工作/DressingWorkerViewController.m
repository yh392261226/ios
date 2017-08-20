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

@interface DressingWorkerViewController ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
{
    NSMutableArray *dataArray;
    
    NSMutableArray *nameArr;
}


@property (nonatomic, strong)UITableView *tableview;

@end

@implementation DressingWorkerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dataArray = [NSMutableArray array];
    
    nameArr = [NSMutableArray arrayWithObjects:@"搜索范围:",@"选择工期",@"工资金额", @"项目时间", @"项目类型", @"选择工种", nil];
    
    [dataArray addObject:@"1"];
    [dataArray addObject:@"1"];
    [dataArray addObject:@"1"];
    
    [self addhead:@"工作信息筛选"];
    
    [self tableview];
    
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
            
            field.borderStyle = UITextBorderStyleRoundedRect;
            
            [cell addSubview:field];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
        }
        else
        {
            DressworkerUITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"allcell"];
            
            cell.name.text = [nameArr objectAtIndex:indexPath.row - 1];
            
            
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







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
