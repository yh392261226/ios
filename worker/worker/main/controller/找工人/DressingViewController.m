//
//  DressingViewController.m
//  worker
//
//  Created by 郭健 on 2017/8/16.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "DressingViewController.h"
#import "DressTableViewCell.h"
#import "listTableView.h"


#define num 3

@interface DressingViewController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
{
    NSMutableArray *dataArray;
    
    NSMutableArray *typeArr;     //状态的名字数组
    
    NSInteger pyte;      //判断选择是那种状态
    
    NSString *nameStr;    //搜索框的编辑内容
    
    listTableView *listTab;
    
    NSMutableArray *listArray;      //列表tableview的数组
    
    
}


@property (nonatomic, strong)UITableView *tableview;

@end

@implementation DressingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.window = [[UIApplication sharedApplication] keyWindow];
    
    listTab = [[listTableView alloc] init];
    
    listArray = [NSMutableArray arrayWithObjects:@"afafadf",@"asadf", @"dfgsgf", nil];
    
    pyte = 0;
    
    typeArr = [NSMutableArray arrayWithObjects:@"空闲", @"洽谈中", @"工作中", nil];
    
    dataArray = [NSMutableArray array];
    [dataArray addObject:@"1"];
    [dataArray addObject:@"1"];
    [dataArray addObject:@"1"];
    
    [self addhead:@"工人信息筛选"];
    
    [self tableview];
    
    
}


#pragma Tableview

- (UITableView *)tableview
{
    if (!_tableview)
    {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 65, SCREEN_WIDTH, SCREEN_HEIGHT - 65) style:UITableViewStylePlain];
        
        [_tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
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
        return 4;
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
            
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            
            if (!cell)
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
                
                UITextField *field = [[UITextField alloc] initWithFrame:CGRectMake(20, 5, SCREEN_WIDTH - 40, 30)];
                
                field.text = nameStr;
                
                field.delegate = self;
                
                field.placeholder = @"请输入工人姓名";
                
                field.borderStyle = UITextBorderStyleRoundedRect;
                
                [cell addSubview:field];
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            
            
            
            return cell;
        }
        else if (indexPath.row == 1)
        {
      
            
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            
            
            
            if (!cell)
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
                
                UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, 80, 30)];
                
                name.text = @"工人状态:";
                
                name.font = [UIFont systemFontOfSize:16];
                
                [cell addSubview:name];
                
                for (int i = 0; i < num; i++)
                {
                    UIView *backview = [[UIView alloc] initWithFrame:CGRectMake(90 + i * ((SCREEN_WIDTH - 90) / 3), 5, SCREEN_WIDTH - 90, 30)];
                    
                    backview.backgroundColor = [UIColor whiteColor];
                    
                    [cell addSubview:backview];
                    
                    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                    
                    button.tag = i + 800;
                    
                    button.layer.cornerRadius = 5;
                    
                    [button addTarget:self action:@selector(typeBtn:) forControlEvents:UIControlEventTouchUpInside];
                    
                    [button setTitle:[typeArr objectAtIndex:i] forState:UIControlStateNormal];
                    
                    button.titleLabel.font = [UIFont systemFontOfSize:14];

                    if (pyte == 0)
                    {
                        if (i == 0)
                        {
                            button.backgroundColor = [myselfway stringTOColor:@"0x23D22B"];
                        }
                        else
                        {
                            button.backgroundColor = [UIColor grayColor];
                        }
                    }
                    else if (pyte == 1)
                    {
                        if (i == 1)
                        {
                            button.backgroundColor = [UIColor orangeColor];
                        }
                        else
                        {
                            button.backgroundColor = [UIColor grayColor];
                        }
                    }
                    else
                    {
                        if (i == 2)
                        {
                            button.backgroundColor = [UIColor redColor];
                        }
                        else
                        {
                            button.backgroundColor = [UIColor grayColor];
                        }
                    }
                    
                    
                    
                    
                    [backview addSubview:button];
                    
                    [button mas_makeConstraints:^(MASConstraintMaker *make)
                     {
                         make.top.mas_equalTo(backview).offset(2.5);
                         make.left.mas_equalTo(backview).offset(10);
                         make.width.mas_equalTo(60);
                         make.height.mas_equalTo(25);
                     }];
                    
                    
                }

                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            
            
             return cell;
        }
        else if(indexPath.row == 2)
        {
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            
            if (!cell)
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
                
                UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, 80, 30)];
                
                name.text = @"搜索范围:";
                
                name.font = [UIFont systemFontOfSize:16];
                
                [cell addSubview:name];
                
                UITextField *data = [[UITextField alloc] initWithFrame:CGRectMake(100, 5, 200, 30)];
                
                data.font = [UIFont systemFontOfSize:16];
                
                data.enabled = NO;
                
                data.text = @"张飞喜欢上曹操";
                
                [cell addSubview:data];
                
            }
            
            return cell;
        }
        else
        {
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            
            if (!cell)
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
                
                UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, 80, 30)];
                
                name.text = @"选择工种:";
                
                name.font = [UIFont systemFontOfSize:16];
                
                [cell addSubview:name];
                
                UITextField *data = [[UITextField alloc] initWithFrame:CGRectMake(100, 5, 200, 30)];
                
                data.font = [UIFont systemFontOfSize:16];

                data.enabled = NO;
                
                data.placeholder = @"点击选择";
                
                [cell addSubview:data];
                
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
        if (indexPath.row == 2)
        {
            [self initlistView];
        }
    }
    
    
    
}


#pragma textfield的代理
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    nameStr = textField.text;

}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
   
    
    return YES;

}


//状态类型按钮
- (void)typeBtn: (UIButton *)btn
{

    if (btn.tag == 800)
    {
        pyte = 0;
    }
    else if (btn.tag == 801)
    {
        pyte = 1;
    }
    else
    {
        pyte = 2;
    }
    
    [self.tableview reloadData];
}



//加载listtableveiw   列表的tableview。  点击显示
- (void)initlistView
{
    
    CGFloat height = listArray.count * 40;
    
    listTab.frame = CGRectMake(100, 185, 200, height);
    
    
    listTab.arr = listArray;
    
    [self.window addSubview:listTab];
    
    [listTab mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.top.mas_equalTo(self.view).offset(185);
        make.left.mas_equalTo(self.view).offset(100);
        make.right.mas_equalTo(self.view).offset(-15);
        make.height.mas_equalTo(height);
    }];
    
}







//删除
- (void)closeBtn: (UIButton *)btn
{
    NSInteger CellNum = btn.tag - 400;
    
    [dataArray removeObjectAtIndex:CellNum];
    
    [self.tableview reloadData];
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];

}



//重写返回的方法
- (void)temp
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
