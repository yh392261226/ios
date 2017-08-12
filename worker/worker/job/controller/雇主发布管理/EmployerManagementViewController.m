//
//  EmployerManagementViewController.m
//  worker
//
//  Created by 郭健 on 2017/8/8.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "EmployerManagementViewController.h"
#import "TypeView.h"
#import "OneTableViewCell.h"

@interface EmployerManagementViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *dataArray;
    
    TypeView *typeView;  //上面选择类型的view
    
    NSMutableArray *nameArr;   //类型上的view名字数组,传给自定义view
}

@property (nonatomic, strong)UITableView *tableview;

@end

@implementation EmployerManagementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self addhead:@"雇主发布管理"];
    
    [self slitherBack:self.navigationController];
    
    dataArray = [NSMutableArray array];
    [dataArray addObject:@"1"];
    [dataArray addObject:@"1"];
    [dataArray addObject:@"1"];
    
    nameArr = [NSMutableArray arrayWithObjects:@"全部", @"待联系", @"洽谈中", @"进行中", @"已结束", nil];
    
    [self tableview];
    
    [self initTypeView];
    
    [self initDraft];
}



#pragma tableview 代理方法

- (UITableView *)tableview
{
    if (!_tableview)
    {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 104, SCREEN_WIDTH, SCREEN_HEIGHT - 104) style:UITableViewStyleGrouped];
        
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
    OneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    [cell.favoriteBtn addTarget:self action:@selector(favoriteBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.favoriteBtn.tag = 700 + indexPath.section;
    
    cell.leftBtn.tag = 100 + indexPath.section;
    cell.centerBtn.tag = 200 + indexPath.section;
    cell.rightBtn.tag = 300 + indexPath.section;
    
    
    [cell.leftBtn addTarget:self action:@selector(leftbtn:) forControlEvents:UIControlEventTouchUpInside];
    [cell.centerBtn addTarget:self action:@selector(centerbtn:) forControlEvents:UIControlEventTouchUpInside];
    [cell.rightBtn addTarget:self action:@selector(rightbtn:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
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


#pragma type的view
- (void)initTypeView
{
    self.view.backgroundColor = [myselfway stringTOColor:@"0xC4CED3"];
    
    typeView = [[TypeView alloc] initWithFrame:CGRectMake(0, 69, SCREEN_WIDTH, 40)];
    
    typeView.delegate = self;
    
    typeView.backgroundColor = [UIColor whiteColor];
    
    typeView.nameArray = nameArr;
    
    [self.view addSubview:typeView];
    
}


//上面选择栏点击事件的代理方法
- (void)tempVal: (NSInteger)type
{
    NSInteger i = type - 500;
    
    if (i == 0)
    {
        NSLog(@"0");
    }
    else if (i == 1)
    {
        NSLog(@"1");
    }
    else if (i == 2)
    {
        NSLog(@"2");
    }
    else if(i == 3)
    {
        NSLog(@"3");
    }
    else
    {
        NSLog(@"4");
    }
}


#pragma 自己的方法

//cell上按钮的点击
- (void)leftbtn: (UIButton *)btn
{
    NSLog(@"1");
}


- (void)centerbtn: (UIButton *)btn
{
    NSLog(@"2");
}



- (void)rightbtn: (UIButton *)btn
{
    NSLog(@"3");
}



//收藏按钮点击
- (void)favoriteBtn: (UIButton *)btn
{
    NSLog(@"%ld", btn.tag);
}


//加载草稿箱
- (void)initDraft
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    
    [button setTitle:@"草稿箱" forState:0];
    
    [button addTarget:self action:@selector(Draft) forControlEvents:UIControlEventTouchUpInside];
    
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    [self.view addSubview:button];
    

    [button mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.mas_equalTo(self.view).offset(27.5);
         make.right.mas_equalTo(self.view).offset(-15);
         make.height.mas_equalTo(30);
         make.width.mas_equalTo(60);
     }];
    
}


//草稿箱点击事件
- (void)Draft
{
    NSLog(@"1");
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
