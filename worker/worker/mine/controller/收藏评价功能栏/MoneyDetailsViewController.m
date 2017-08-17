//
//  MoneyDetailsViewController.m
//  worker
//
//  Created by 郭健 on 2017/8/15.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "MoneyDetailsViewController.h"
#import "MoneyDetailTableViewCell.h"

@interface MoneyDetailsViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *dataArray;
    
    NSMutableArray *toostArray;
    
    UIWindow *window;
    
    UIView *rightView;
    
    NSInteger type;          //判断右上角view是否弹出
    UIControl *contro;       //背景阴影
    UIButton *button;        //右上角全部字样
    
}

@property (nonatomic, strong)UITableView *tableview;



@end

@implementation MoneyDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    type = 0;
    
    window = [[UIApplication sharedApplication] keyWindow];
    
    dataArray = [NSMutableArray array];
    [dataArray addObject:@"1"];
    [dataArray addObject:@"1"];
    [dataArray addObject:@"1"];
    [dataArray addObject:@"1"];
    
    toostArray = [NSMutableArray arrayWithObjects:@"全部", @"支出", @"收入", nil];

    [self addhead:@"账户明细"];
    
    [self initDraft];
    
    [self slitherBack:self.navigationController];
    
    [self tableview];
    
    [self initRightView];
    
}


#pragma tableview 代理方法

- (UITableView *)tableview
{
    if (!_tableview)
    {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStyleGrouped];
        
        
        
        [_tableview registerClass:[MoneyDetailTableViewCell class] forCellReuseIdentifier:@"cell"];
        
        _tableview.backgroundColor = [myselfway stringTOColor:@"0xC4CED3"];
        
        _tableview.delegate = self;
        _tableview.dataSource = self;
        
        [self.view addSubview:_tableview];
    }
    
    return _tableview;
}


//右上角点击出现的


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isKindOfClass:[self.tableview class]])
    {
        
    }
    
    return dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MoneyDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}











#pragma 自己定义的方法

//加载全部按钮
- (void)initDraft
{
    
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button setTitle:@"全部" forState:0];
    
    [button addTarget:self action:@selector(Draft) forControlEvents:UIControlEventTouchUpInside];
    
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    [self.view addSubview:button];
    
    
    [button mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.mas_equalTo(self.view).offset(27.5);
         make.right.mas_equalTo(self.view).offset(-20);
         make.height.mas_equalTo(30);
         make.width.mas_equalTo(50);
     }];
    
    
    UIImageView *down = [[UIImageView alloc] init];
    
    down.image = [UIImage imageNamed:@"main_down"];
    
    [self.view addSubview:down];
    
    [down mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.mas_equalTo(button).offset(45);
        make.top.mas_equalTo(self.view).offset(35);
        make.width.mas_equalTo(13);
        make.height.mas_equalTo(13);
    }];
    
    
    
    
}


//全部按钮的点击事件
- (void)Draft
{
    if (type == 0)
    {
        [UIView animateWithDuration:0.5 animations:^{
            
            contro.hidden = NO;
            
            rightView.frame = CGRectMake(SCREEN_WIDTH - 70, 0, 65, 90);
            
        } completion:^(BOOL finished) {
            
        }];
        
        type = 1;
    }
    else
    {
        [UIView animateWithDuration:0.5 animations:^{
            
            rightView.frame = CGRectMake(SCREEN_WIDTH - 30, 0, 0, 0);
            
        } completion:^(BOOL finished) {
            
            contro.hidden = YES;
            
        }];
        
        type = 0;
        
    }
    
    
}



#pragma 自己的方法，加载自定义控件

//加载右上角全部点击的view
- (void)initRightView
{
    contro = [[UIControl alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    
    contro.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    
    [contro addTarget:self action:@selector(backbtn) forControlEvents:UIControlEventTouchUpInside];
    
    contro.hidden = YES;
    
    [window addSubview:contro];
    
    
    rightView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 30, 0, 0, 0)];
    
    rightView.backgroundColor = [UIColor whiteColor];
    
    rightView.layer.cornerRadius = 2;
    
    rightView.clipsToBounds = YES;
    
    for (int i = 0; i < toostArray.count; i++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        btn.frame = CGRectMake(0, i * 30, 65, 30);
        
        btn.tag = 800 + i;
        
        [btn addTarget:self action:@selector(selecedbtn:) forControlEvents:UIControlEventTouchUpInside];
        
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        
        [btn setTitle:[toostArray objectAtIndex:i] forState:UIControlStateNormal];
        
        [rightView addSubview:btn];
        
        
    }
    
    [contro addSubview:rightView];
    
}

//失去焦点消失阴影
- (void)backbtn
{
    [UIView animateWithDuration:0.5 animations:^{
        
        rightView.frame = CGRectMake(SCREEN_WIDTH - 30, 0, 0, 0);
        
    } completion:^(BOOL finished) {
        
        contro.hidden = YES;
        
    }];
    
    type = 0;
}


//点击事件
- (void)selecedbtn: (UIButton *)btn
{
    [UIView animateWithDuration:0.5 animations:^{
        
        rightView.frame = CGRectMake(SCREEN_WIDTH - 30, 0, 0, 0);
        
    } completion:^(BOOL finished) {
        
        contro.hidden = YES;
        
    }];
    
    type = 0;
    
    if (btn.tag == 800)
    {
        [button setTitle:@"全部" forState:0];
    }
    else if (btn.tag == 801)
    {
        [button setTitle:@"支出" forState:0];
    }
    else
    {
        [button setTitle:@"收入" forState:0];
    }
}


//返回按钮，需要重写
- (void)temp
{
    [super temp];
    
    [UIView animateWithDuration:0 animations:^{
        
        rightView.frame = CGRectMake(SCREEN_WIDTH - 30, 0, 0, 0);
        
    } completion:^(BOOL finished) {
        
        contro.hidden = YES;
        
    }];
    
    
    
}













- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
