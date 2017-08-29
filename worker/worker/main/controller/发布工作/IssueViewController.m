//
//  IssueViewController.m
//  worker
//
//  Created by 郭健 on 2017/8/9.
//  Copyright © 2017年 郭健. All rights reserved.
//


@interface selecdType : NSObject

@property (nonatomic)NSInteger bigType;       //分辨哪个section

@end

@implementation selecdType


@end


@interface firstModel : selecdType

@property (nonatomic)NSInteger type;             //分辨那个cell

@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSString *data;


@end


@implementation firstModel


@end


@interface elseModel : selecdType

@property (nonatomic)NSInteger workerType;       //分辨那个cell

@property (nonatomic, strong)NSString *worker;
@property (nonatomic, strong)NSString *personNum;
@property (nonatomic, strong)NSString *money;


@property (nonatomic, strong)NSString *startTime;
@property (nonatomic, strong)NSString *endTime;

@end


@implementation elseModel


@end


#import "IssueViewController.h"
#import "lssueUserTableViewCell.h"
#import "BriefTableViewCell.h"
#import "elsepersonTableViewCell.h"
#import "elsetimeTableViewCell.h"
#import "elseDelegateTableViewCell.h"

@interface IssueViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *dataArray;        //支撑页面的大数组
    
    
    
}

@property (nonatomic, strong)UITableView *tableview;

@end

@implementation IssueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    dataArray = [NSMutableArray array];
    
    
    [self initData];
    
    [self addhead:@"发布工作"];
    
    [self slitherBack:self.navigationController];
    
    [self initDraft];
    
    [self tableview];
}


#pragma tableview代理

- (UITableView *)tableview
{
    if (!_tableview)
    {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 65, SCREEN_WIDTH, SCREEN_HEIGHT - 65) style:UITableViewStyleGrouped];
        
        [_tableview registerClass:[lssueUserTableViewCell class] forCellReuseIdentifier:@"usercell"];
        [_tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        [_tableview registerClass:[BriefTableViewCell class] forCellReuseIdentifier:@"briefcell"];
        
        
        [_tableview registerClass:[elsepersonTableViewCell class] forCellReuseIdentifier:@"elseperson"];
        [_tableview registerClass:[elsetimeTableViewCell class] forCellReuseIdentifier:@"elsetime"];
        [_tableview registerClass:[elseDelegateTableViewCell class] forCellReuseIdentifier:@"deletecell"];
        
        
        _tableview.backgroundColor = [myselfway stringTOColor:@"0xC4CED3"];
        
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
    
    NSArray *numCount = [dataArray objectAtIndex:section];
    
    
    return numCount.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *arr = [dataArray objectAtIndex:indexPath.section];
    
    selecdType *data = [arr objectAtIndex:indexPath.row];
    
    if (data.bigType == 1)
    {
        firstModel *info = (firstModel *)data;
        
        if (info.type == 0)
        {
            lssueUserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"usercell"];
            
            if(indexPath.row == 0)
            {
                cell.name.text = @"标题:";
                cell.data.placeholder = @"工程名称";
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            else if (indexPath.row == 2)
            {
                cell.name.text = @"工作类型:";
                cell.data.placeholder = @"选择项目类型";
                cell.data.enabled = NO;
            }
            else if (indexPath.row == 3)
            {
                cell.name.text = @"选择区域:";
                cell.data.enabled = NO;
                cell.data.placeholder = @"选择工作所在区域";
            }
            else
            {
                cell.name.text = @"详细地址:";
                cell.data.placeholder = @"请填写详细地址,不少于5个字";
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            
            return cell;
        }
        else
        {
            BriefTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"briefcell"];
            
            cell.name.font = [UIFont systemFontOfSize:16];
            cell.name.text = @"描述:";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
        }
        
    }
    else
    {
        elseModel *info = (elseModel *)data;
        
        if (info.workerType == 0)
        {
            lssueUserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"usercell"];
            
            cell.name.text = @"选择工种:";
            cell.data.placeholder = @"点击选择招聘工种";
            cell.data.enabled = NO;
            
            return cell;
            
        }
        else if (info.workerType == 1)
        {
            elsepersonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"elseperson"];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
        }
        else if(info.workerType == 2)
        {
            elsetimeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"elsetime"];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
        
        }
        else
        {
            elseDelegateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"deletecell"];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
        }
        
    }
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *arr = [dataArray objectAtIndex:indexPath.section];
    
    selecdType *data = [arr objectAtIndex:indexPath.row];
    
    if (data.bigType == 1)
    {
        firstModel *info = (firstModel *)data;
        
        if (info.type == 1)
        {
            return 120;
        }
        else
        {
            return 40;
        }
        
    }
    else
    {
        return 40;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1 && section == 0)
    {
        return 0.1;
    }
    else
    {
        return 15;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    NSInteger count = dataArray.count;
    
    if (count - 1 == section)
    {
        return 70;
    }
    else
    {
        return 0.1;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *arr = [dataArray objectAtIndex:indexPath.section];
    
    selecdType *data = [arr objectAtIndex:indexPath.row];
    
    if (data.bigType == 1)
    {
        
    }
    else
    {
        elseModel *info = (elseModel *)data;
        
        if (info.workerType == 3)
        {
            //删除工种cell
            
            [dataArray removeObjectAtIndex:indexPath.section];
            
            [self.tableview reloadData];
            
        }
    }
    
}





- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    NSInteger count = dataArray.count;
    
    UIView *footview = [[UIView alloc] init];
    
    if (count - 1 == section)
    {
        
        UIButton *save = [UIButton buttonWithType:UIButtonTypeSystem];
        
        [save setTitle:@"确认提交" forState:UIControlStateNormal];
        
        [save addTarget:self action:@selector(Escbtn) forControlEvents:UIControlEventTouchUpInside];
        
        save.backgroundColor = [myselfway stringTOColor:@"0x2E84F8"];
        
        save.layer.cornerRadius = 5;
        
        save.frame = CGRectMake(15, 20, SCREEN_WIDTH - 30, 40);
        
        save.tintColor = [UIColor whiteColor];
        
        [footview addSubview:save];
        
    }
    
    
    return footview;
    
}




//确认提交按钮
- (void)Escbtn
{

    NSLog(@"提交");
}






//加载增加工种按钮
- (void)initDraft
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    
    [button setTitle:@"增加工种" forState:0];
    
    [button addTarget:self action:@selector(Draft) forControlEvents:UIControlEventTouchUpInside];
    
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    
    button.titleLabel.textAlignment = NSTextAlignmentRight;
    
    [button setTitleColor:[myselfway stringTOColor:@"0x2E84F8"] forState:UIControlStateNormal];
    
    [self.view addSubview:button];
    
    
    [button mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.mas_equalTo(self.view).offset(27.5);
         make.right.mas_equalTo(self.view).offset(-10);
         make.height.mas_equalTo(30);
         make.width.mas_equalTo(80);
     }];
    
}

//增加工种按钮
- (void)Draft
{
    NSMutableArray *elseArray = [NSMutableArray array];
    
    elseModel *data0 = [[elseModel alloc] init];
    
    data0.bigType = 0;
    
    data0.workerType = 0;
    
    [elseArray addObject:data0];
    
    
    
    elseModel *data1 = [[elseModel alloc] init];
    
    data1.bigType = 0;
    
    data1.workerType = 1;
    
    [elseArray addObject:data1];
    
    
    
    elseModel *data2 = [[elseModel alloc] init];
    
    data2.bigType = 0;
    
    data2.workerType = 2;
    
    [elseArray addObject:data2];
    

    elseModel *data3 = [[elseModel alloc] init];
    
    data3.bigType = 0;
    
    data3.workerType = 3;
    
    [elseArray addObject:data3];
    
    [dataArray addObject:elseArray];
    
    
    [self.tableview reloadData];

    NSIndexPath *dayOne = [NSIndexPath indexPathForRow:0 inSection:dataArray.count - 1];
    
    [self.tableview scrollToRowAtIndexPath:dayOne atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
}












//制作数据
- (void)initData           //bigtype  ==  0     添加工种的section        bigtype ==  1     第一个section
{
    //第一个section
    NSMutableArray *first = [NSMutableArray array];
    
    firstModel *info0 = [[firstModel alloc] init];
    
    info0.name = @"标题:";
    
    info0.type = 0;
    
    info0.bigType = 1;
    
    [first addObject:info0];
    
    
    firstModel *info1 = [[firstModel alloc] init];
    
    info1.name = @"描述:";
    
    info1.type = 1;
    
    info1.bigType = 1;
    
    [first addObject:info1];
    
    
    firstModel *info2 = [[firstModel alloc] init];
    
    info2.name = @"工程类型:";
    
    info2.type = 0;
    
    info2.bigType = 1;
    
    [first addObject:info2];
    
    
    firstModel *info3 = [[firstModel alloc] init];
    
    info3.name = @"所在区域:";
    
    info3.type = 0;
    
    info3.bigType = 1;
    
    [first addObject:info3];
    
    
    firstModel *info4 = [[firstModel alloc] init];
    
    info4.name = @"详细地址:";
    
    info4.type = 0;
    
    info4.bigType = 1;
    
    [first addObject:info4];
    
    [dataArray addObject:first];
    
    
    
    NSMutableArray *elseArray = [NSMutableArray array];
    
    elseModel *data0 = [[elseModel alloc] init];
    
    data0.bigType = 0;
    
    data0.workerType = 0;
    
    [elseArray addObject:data0];
    
    
    
    elseModel *data1 = [[elseModel alloc] init];
    
    data1.bigType = 0;
    
    data1.workerType = 1;
    
    [elseArray addObject:data1];
    
    
    
    elseModel *data2 = [[elseModel alloc] init];
    
    data2.bigType = 0;
    
    data2.workerType = 2;
    
    [elseArray addObject:data2];
    
    
    [dataArray addObject:elseArray];

}















- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}




@end
