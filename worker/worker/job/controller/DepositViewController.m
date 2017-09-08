//
//  DepositViewController.m
//  worker
//
//  Created by 郭健 on 2017/9/5.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "DepositViewController.h"
#import "lssueUserTableViewCell.h"
#import "DepositTableViewCell.h"

@interface DepositViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *dataArray;
    
    
    
    NSString *name;       //姓名
    NSString *number;     //卡号
    NSString *money;      //银行
    
    NSString *bank;       //金额
    
    
}

@property (nonatomic, strong)UITableView *tableview;

@end

@implementation DepositViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    bank = @"请选择银行";
    
    dataArray = [NSMutableArray arrayWithObjects:@"招商银行",@"中国建设银行",@"中国农业银行", nil];
    
    [self addhead:@"转到银行卡"];
    
    [self tableview];
}

- (UITableView *)tableview
{
    if (!_tableview)
    {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 65, SCREEN_WIDTH, SCREEN_HEIGHT - 65) style:UITableViewStyleGrouped];
        
        _tableview.delegate = self;
        _tableview.dataSource = self;
        
        _tableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.1)];
        _tableview.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.1)];
        
        [_tableview registerClass:[lssueUserTableViewCell class] forCellReuseIdentifier:@"cell"];
        
        [_tableview registerClass:[DepositTableViewCell class] forCellReuseIdentifier:@"elsecell"];
        
        [self.view addSubview:_tableview];
        
    }
    
    return _tableview;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2)
    {
        DepositTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"elsecell"];
        
        cell.name.text = @"银行:";
        
        cell.data.text = bank;
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        
        return cell;
    }
    else
    {
        lssueUserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        
        [cell.data addTarget:self action:@selector(changeText:) forControlEvents:UIControlEventEditingChanged];
        
        cell.name.textAlignment = NSTextAlignmentCenter;
        
        cell.data.tag = indexPath.row + 900;
        
        if (indexPath.row == 0)
        {
            cell.name.text = @"姓名:";
            cell.data.placeholder = @"收款人姓名";
        }
        else if (indexPath.row == 1)
        {
            cell.name.text = @"卡号:";
            cell.data.placeholder = @"收款人储蓄卡号";
        }
        else if (indexPath.row == 3)
        {
            cell.name.text = @"金额:";
            cell.data.placeholder = @"";
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
    return 15;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 2)
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"请选择银行" preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *returnAlert = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        
        [alertController addAction:returnAlert];
        
        for (int i = 0; i < dataArray.count; i++)
        {
            UIAlertAction *action = [UIAlertAction actionWithTitle:[dataArray objectAtIndex:i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                                     {
                                         bank = action.title;
                                         
                                         
                                         [self.tableview reloadData];
                                     }];
            
            [alertController addAction:action];
            
            
        }
        
        [self presentViewController:alertController animated:YES completion:nil];
        
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 70;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footview = [[UIView alloc] init];
    
   
        
        UIButton *save = [UIButton buttonWithType:UIButtonTypeSystem];
        
        [save setTitle:@"下一步" forState:UIControlStateNormal];
        
        [save addTarget:self action:@selector(Escbtn) forControlEvents:UIControlEventTouchUpInside];
        
        save.backgroundColor = [myselfway stringTOColor:@"0x2E84F8"];
        
        save.layer.cornerRadius = 5;
        
        save.frame = CGRectMake(20, 25, SCREEN_WIDTH - 40, 40);
        
        save.tintColor = [UIColor whiteColor];
        
        [footview addSubview:save];
        
   
    
    
    return footview;
}



//下一步按钮
- (void)Escbtn
{
    NSLog(@"xiayibu");
}


//获取textfield字段
- (void)changeText: (UITextField *)textfield
{
    if (textfield.tag == 900)
    {
        name = textfield.text;
    }
    else if (textfield.tag == 901)
    {
        number = textfield.text;
    }
    else
    {
        money = textfield.text;
    }
}







- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
