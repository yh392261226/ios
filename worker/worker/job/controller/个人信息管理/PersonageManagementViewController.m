//
//  PersonageManagementViewController.m
//  worker
//
//  Created by 郭健 on 2017/8/8.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "PersonageManagementViewController.h"
#import "Headview.h"
#import "PreviewTableViewCell.h"
#import "BriefTableViewCell.h"
#import "CraftTableViewCell.h"

#import "WorkerMessTableViewCell.h"




#import "EditSelecedTableViewCell.h"
#import "EditSetTableViewCell.h"
#import "EditTextTableViewCell.h"

#define workerNum 4



//数据类
@interface PersonDataClass : NSObject

@property (nonatomic)NSInteger typeInf;   //判断cell类型

@property (nonatomic, strong)NSString *name;

@property (nonatomic, strong)NSString *data;

@property (nonatomic, strong)NSMutableArray *workerArray;  //工种的数组


//编辑信息数据需要属性
@property (nonatomic, strong)NSString *sex;
@property (nonatomic, strong)NSString *placehold;



@end


@implementation PersonDataClass



@end














@interface PersonageManagementViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *dataArray;
    
    
    
    NSMutableArray *nameArr;     //信息预览，编辑信息的按钮名称数组
    
    NSInteger typeInfo;      //判断是信息预览还是编辑信息还是投递记录
    
    Headview *Hview;
    
    NSMutableArray *arr;    //预览页面最下放工种的数组
}

@property (nonatomic, strong)UITableView *tableview;

@end

@implementation PersonageManagementViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    typeInfo = 0;    //初始化为0，默认选择是信息预览
    
    dataArray = [NSMutableArray array];
    
    arr = [NSMutableArray arrayWithObjects:@"水泥工",@"水暖工",@"瓦工", @"壁纸工",@"张飞", nil];
    
    [self initUiData];
   
    
    
    nameArr = [NSMutableArray arrayWithObjects:@"信息预览",@"编辑信息", @"投递记录", nil];
    
    
    
    [self addhead:@"个人信息管理"];
    
    [self slitherBack:self.navigationController];

    [self initHeadView];
    
    [self tableview];
    
}



//加载headview
- (void)initHeadView
{
    Hview = [[Headview alloc] initWithFrame:CGRectMake(0, 65, SCREEN_WIDTH, 110)];
    
    Hview.dataArray = nameArr;
    
    [Hview.btnIcon addTarget:self action:@selector(ImageBtn) forControlEvents:UIControlEventTouchUpInside];
    
    Hview.delegate = self;
    
    Hview.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:Hview];
}



#pragma tableview代理

- (UITableView *)tableview
{
    if (!_tableview)
    {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 176, SCREEN_WIDTH, SCREEN_HEIGHT - 176) style:UITableViewStyleGrouped];
        
        _tableview.delegate = self;
        _tableview.dataSource = self;
        
        _tableview.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.1)];
        _tableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.1)];
        
        [_tableview registerClass:[PreviewTableViewCell class] forCellReuseIdentifier:@"typecell"];
        [_tableview registerClass:[BriefTableViewCell class] forCellReuseIdentifier:@"briefcell"];
        [_tableview registerClass:[CraftTableViewCell class] forCellReuseIdentifier:@"craftcell"];
        
        
        [_tableview registerClass:[WorkerMessTableViewCell class] forCellReuseIdentifier:@"workercell"];
        
        [_tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        
        [self.view addSubview:_tableview];
    }
    
    return _tableview;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (typeInfo == 0)    //信息预览
    {
        PersonDataClass *data = [dataArray objectAtIndex:indexPath.row];
        
        if (data.typeInf == 0)
        {
            PreviewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"typecell"];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.name.text = data.name;
            cell.data.text = data.data;
            
            return cell;
        }
        else if(data.typeInf == 1)
        {
            BriefTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"briefcell"];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.name.text = data.name;
            
            cell.data.userInteractionEnabled = NO;
            
            cell.data.text = data.data;
            
            return cell;
        }
        else
        {
            CraftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"craftcell"];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.dataArray = arr;
            
            return cell;
        }
        
    }
    else if(typeInfo == 2)
    {
        WorkerMessTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"workercell"];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    else
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        
        
        
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (typeInfo == 0)    //信息预览
    {
        PersonDataClass *data = [dataArray objectAtIndex:indexPath.row];
        
        if (data.typeInf == 0)
        {
            return 40;
        }
        else if(data.typeInf == 1)
        {
            return 140;
        }
        else
        {
            NSInteger num = data.workerArray.count;
            
            NSInteger i = 0;
            
            if (num % workerNum == 0)
            {
                i = num / workerNum;
            }
            else
            {
                i = num / workerNum + 1;
            }
            
            return 40 * i;
        }
        
    }
    else if(typeInfo == 2)
    {
        return 100;
    }
    else
    {
        return 40;
    }
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (typeInfo == 2)
    {
        _tableview.backgroundColor = [myselfway stringTOColor:@"0xC4CED3"];
        
        return 10;
    }
    else
    {
        return 0.1;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


#pragma 自己的方法

//更换头像的点击事件
- (void)ImageBtn
{
    NSLog(@"1");
}


//信息预览等点击事件的代理方法
- (void)tempVal: (NSInteger)type
{
    [dataArray removeAllObjects];
    
    if (type == 500)
    {
        typeInfo = 0;
        
        [self initUiData];
    }
    else if (type == 501)
    {
        typeInfo = 1;
        
        
    }
    else
    {
        typeInfo = 2;
    }
    
    [self.tableview reloadData];
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



//制作数据类
- (void)initUiData
{

    PersonDataClass *info0 = [[PersonDataClass alloc] init];
    info0.typeInf = 0;
    info0.name = @"姓名:";
    info0.data = @"郭健";
    [dataArray addObject:info0];
    
    PersonDataClass *info1 = [[PersonDataClass alloc] init];
    info1.typeInf = 0;
    info1.name = @"性别:";
    info1.data = @"男";
    [dataArray addObject:info1];
    
    PersonDataClass *info2 = [[PersonDataClass alloc] init];
    info2.typeInf = 0;
    info2.name = @"出生日期:";
    info2.data = @"1995-03-23";
    [dataArray addObject:info2];
    
    PersonDataClass *info3 = [[PersonDataClass alloc] init];
    info3.typeInf = 0;
    info3.name = @"身份证号:";
    info3.data = @"210911199503230536";
    [dataArray addObject:info3];
    
    PersonDataClass *info4 = [[PersonDataClass alloc] init];
    info4.typeInf = 0;
    info4.name = @"现居住地:";
    info4.data = @"沈阳市和平区";
    [dataArray addObject:info4];
    
    PersonDataClass *info5 = [[PersonDataClass alloc] init];
    info5.typeInf = 1;
    info5.name = @"个人简介:";
    info5.data = @"专业水泥工、精通水暖,刮大白";
    [dataArray addObject:info5];
    
    
    
    PersonDataClass *info6 = [[PersonDataClass alloc] init];
    info6.typeInf = 0;
    info6.name = @"电话号:";
    info6.data = @"15840344241";
    [dataArray addObject:info6];
    
    
    PersonDataClass *info7 = [[PersonDataClass alloc] init];
    info7.typeInf = 0;
    info7.name = @"角色选择:";
    info7.data = @"我不是工人";
    [dataArray addObject:info7];
    
    

    PersonDataClass *info8 = [[PersonDataClass alloc] init];
    info8.workerArray = arr;
    info8.typeInf = 2;
    
    
    [dataArray addObject:info8];
    
}


//制作编辑信息的数据
- (void)initEditData
{
    
}





@end
