//
//  SelecdCityViewController.m
//  worker
//
//  Created by 郭健 on 2017/7/28.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "SelecdCityViewController.h"
#import "MainViewController.h"




@interface SelecdCityViewController ()<UITableViewDelegate, UITableViewDataSource>
{
   
    
    
}

@property (nonatomic, strong)UITableView *tableview;

@end

@implementation SelecdCityViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.navigationController.navigationBarHidden = YES;
    
    
    
    
    [self addhead:@"城市选择"];
    
    [self slitherBack:self.navigationController];
    
    

    [self tableview];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSArray *arr = [_dataArray objectAtIndex:indexPath.section];
    
    cityData *data = [arr objectAtIndex:indexPath.row];
    
    [self.delegate cityNameT:data.r_name];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArray.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *arr = [_dataArray objectAtIndex:section];
    
    
    return arr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    NSArray *arr = [_dataArray objectAtIndex:indexPath.section];
    
    cityData *data = [arr objectAtIndex:indexPath.row];
    
    if (!cell)
    {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        
        UILabel *name = [[UILabel alloc] init];
        
        name.frame = CGRectMake(25, 10, 300, 30);
        name.font = [UIFont systemFontOfSize:15];
        name.text = data.r_name;
        
        [cell addSubview:name];
        
        
    }
    
    
    return cell;
    
}


- (UITableView *)tableview
{
    if (!_tableview)
    {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStyleGrouped];
        
        
        //索引
        _tableview.allowsSelection = YES;
        
        _tableview.showsHorizontalScrollIndicator = NO;
        _tableview.showsVerticalScrollIndicator = NO;
        _tableview.allowsSelection = YES;
        _tableview.sectionIndexColor = [myselfway stringTOColor:@"0x2E84F8"];
        
        
        
        
        _tableview.delegate = self;
        _tableview.dataSource = self;
        
        [_tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        
        
        [self.view addSubview:_tableview];
        
    }
    
    return _tableview;
    
}

//添加索引列
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView

{
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        return nil;
    }

    NSMutableArray *listArray = [NSMutableArray array];

    for (int i = 0; i < _EnglishArray.count; i++)
    {
        NSString *str = [_EnglishArray objectAtIndex:i];

        if (i == 0)
        {
            [listArray addObject:@"#"];
        }
        else
        {
            [listArray addObject:str];
        }
    }

    return listArray;
}

//索引列点击事件
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index

{
    //点击索引，列表跳转到对应索引的行
    
    [tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
    //弹出首字母提示
    
    //    [gangjTowst showWithText:title];
    
    return index;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 95;
    }
    else
    {
        return 30;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    
    if (section == 0)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        
        button.frame = CGRectMake(0, 15, SCREEN_WIDTH, 50);
        
        button.backgroundColor = [UIColor whiteColor];
        
        [button addTarget:self action:@selector(currentAdree) forControlEvents:UIControlEventTouchUpInside];
        
        [view addSubview:button];
        
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(23, 10, 200, 30);
        
        if (self.cityN == NULL)
        {
            label.text = [NSString stringWithFormat:@"当前定位城市: %@", @"未打开定位服务"];
        }
        else
        {
            label.text = [NSString stringWithFormat:@"当前定位城市: %@", self.cityN];
        }
        
        label.font = [UIFont systemFontOfSize:15];
        
        [button addSubview:label];
        
    }
    
    UILabel *name = [[UILabel alloc] init];
    name.textColor = [UIColor grayColor];
    name.font = [UIFont systemFontOfSize:15];
    name.text = [_EnglishArray objectAtIndex:section];
    
    [view addSubview:name];
    
    [name mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.bottom.mas_equalTo(view).offset(-5);
        make.left.mas_equalTo(view).offset(20);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(20);
    }];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    
    return view;
    
}













//当前位置按钮的点击
- (void)currentAdree
{
    [self.delegate cityNameT:self.cityN];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
