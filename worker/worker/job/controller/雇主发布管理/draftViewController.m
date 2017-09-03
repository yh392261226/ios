//
//  draftViewController.m
//  worker
//
//  Created by 郭健 on 2017/8/30.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "draftViewController.h"
#import "OneTableViewCell.h"

@interface draftViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *dataArray;
}

@property (nonatomic, strong)UITableView *tableview;

@end

@implementation draftViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    dataArray = [NSMutableArray array];
    
    [dataArray addObject:@"1"];
    [dataArray addObject:@"1"];
    [dataArray addObject:@"1"];
    
    [self addhead:@"草稿箱"];
    
    [self slitherBack:self.navigationController];
    
    [self tableview];
}



#pragma tableview 代理方法

- (UITableView *)tableview
{
    if (!_tableview)
    {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStyleGrouped];
        
        [_tableview registerClass:[OneTableViewCell class] forCellReuseIdentifier:@"cell"];
        
        _tableview.backgroundColor = [myselfway stringTOColor:@"0xC4CED3"];
        
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
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OneTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (!cell)
    {
        cell = [[OneTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.favoriteBtn.hidden = YES;
        cell.state.hidden = YES;
        cell.leftBtn.hidden = YES;
        
        [cell.centerBtn setTitle:@"删除信息" forState:UIControlStateNormal];
        [cell.rightBtn setTitle:@"修改" forState:UIControlStateNormal];
        
        [cell.centerBtn addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
        [cell.rightBtn addTarget:self action:@selector(write:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *state = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 80, 7.5, 50, 20)];
        
        state.text = @"未支付";
        state.textColor = [UIColor whiteColor];
        state.backgroundColor = [UIColor grayColor];
        state.textAlignment = NSTextAlignmentCenter;
        state.font = [UIFont systemFontOfSize:13];
        state.layer.cornerRadius = 5;
        state.layer.masksToBounds = YES;
        
        [cell addSubview:state];
        
    }
    
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 115;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}



//编辑草稿箱信息
- (void)close: (UIButton *)btn
{
    NSLog(@"1");
}

//修改草稿箱信息
- (void)write: (UIButton *)btn
{
    NSLog(@"2");
}











- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
