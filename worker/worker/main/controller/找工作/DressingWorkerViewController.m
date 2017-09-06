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
    
    NSString *nameStr;    //编辑框内容
    
    
    
    
    
    NSString *range;     //搜索范围
    NSString *project;   //选择工期
    NSString *money;     //工资金额
    NSString *time;      //项目时间
    NSString *proType;   //项目类型
    NSString *worker;    //选择工种
    
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
    
    
    
    UIButton *Mess = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [Mess setBackgroundImage:[UIImage imageNamed:@"main_mess"] forState:UIControlStateNormal];
    
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
        [self initAlert:dataArray title:[nameArr objectAtIndex:indexPath.row - 1] type:indexPath.row];
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
    NSLog(@"搜索");
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
