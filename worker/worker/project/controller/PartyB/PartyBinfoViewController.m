//
//  PartyBinfoViewController.m
//  worker
//
//  Created by 郭健 on 2017/9/8.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "PartyBinfoViewController.h"

#import "ImageTableViewCell.h"
#import "PersonInfoTableViewCell.h"
#import "PersonTextviewTableViewCell.h"

#import "PersonEvaTableViewCell.h"
#import "PersonWorTableViewCell.h"

@interface BallpersonData : NSObject

@property (nonatomic) NSInteger bigType;   //  0 代表第一个section   1代表第二个

@end


@implementation BallpersonData


@end


@interface BinitPersonData : BallpersonData

@property (nonatomic, strong)NSString *imageStr;

@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSString *data;



@property (nonatomic, strong)NSMutableArray *workerArray;

@property (nonatomic) NSInteger type;

@end



@implementation BinitPersonData


@end



@interface BinitPersonElseData : BallpersonData

@property (nonatomic, strong)NSString *imageStr;
@property (nonatomic, strong)NSString *detail;
@property (nonatomic, strong)NSString *time;


@end

@implementation BinitPersonElseData



@end





@interface PartyBinfoViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *dataArray;
    
    NSMutableArray *worArr;  //工种的数组
    
    
    NSString *PingNum;   //评价数
}



@property (nonatomic, strong)UITableView *tableview;

@end

@implementation PartyBinfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    dataArray = [NSMutableArray array];
    
    worArr = [NSMutableArray array];
    [worArr addObject:@"水泥工"];
    [worArr addObject:@"瓦工"];
    [worArr addObject:@"铺砖工"];
    [worArr addObject:@"水暖工"];
    [worArr addObject:@"打扫卫生"];
    
    
    
    [self addhead:@"张雄阿尼"];
    
    [self slitherBack:self.navigationController];
    
    [self initData];
    
    
    [self tableview];
    
    
}




- (UITableView *)tableview
{
    if (!_tableview)
    {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 65, SCREEN_WIDTH, SCREEN_HEIGHT - 65) style:UITableViewStyleGrouped];
        
        _tableview.delegate = self;
        _tableview.dataSource = self;
        
        [_tableview registerClass:[ImageTableViewCell class] forCellReuseIdentifier:@"imagecell"];
        [_tableview registerClass:[PersonInfoTableViewCell class] forCellReuseIdentifier:@"normalcell"];
        [_tableview registerClass:[PersonTextviewTableViewCell class] forCellReuseIdentifier:@"textcell"];
        
        [_tableview registerClass:[PersonEvaTableViewCell class] forCellReuseIdentifier:@"elsecell"];
        
        [_tableview registerClass:[PersonWorTableViewCell class] forCellReuseIdentifier:@"infocell"];
        
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
    NSMutableArray *arr = [dataArray objectAtIndex:section];
    
    
    return arr.count;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *arr = [dataArray objectAtIndex:indexPath.section];
    
    BallpersonData *data = [arr objectAtIndex:indexPath.row];
    
    if (data.bigType == 0)
    {
        BinitPersonData *info = (BinitPersonData *)data;
        
        if (info.type == 1)
        {
            ImageTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            
            if (!cell)
            {
                cell = [[ImageTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"imagecell"];
                
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                
                NSURL *url = [NSURL URLWithString:info.imageStr];
                
                [cell.image sd_setImageWithURL:url];
            }
            
            
            return cell;
            
        }
        else if(info.type == 2)
        {
            
            PersonTextviewTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            
            if (!cell)
            {
                cell = [[PersonTextviewTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"textcell"];
                
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                cell.name.text = info.name;
                cell.textview.text = info.data;
            }
           
            
            return cell;
        }
        else if(info.type == 0)
        {
            PersonInfoTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            
            if (!cell)
            {
                cell = [[PersonInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"normalcell"];
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                cell.name.text = info.name;
                cell.data.text = info.data;
                
            }
            
            
            return cell;
        }
        else
        {
            PersonWorTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            
            if (!cell)
            {
                cell = [[PersonWorTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"infocell"];
                
                cell.dataArray = worArr;
            }
            
           
            
            
            
            return cell;
        }
        
    }
    else
    {
        
        BinitPersonElseData *info = (BinitPersonElseData *)data;
        
        PersonEvaTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        if (!cell)
        {
            
            cell = [[PersonEvaTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"elsecell"];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            NSURL *url = [NSURL URLWithString:info.imageStr];
            
            [cell.imageView sd_setImageWithURL:url];
            
            cell.title.text = info.detail;
            cell.time.text = info.time;
            
            
        }
        
        
        return cell;
        
        
    }
    
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *arr = [dataArray objectAtIndex:indexPath.section];
    
    BallpersonData *data = [arr objectAtIndex:indexPath.row];
    
    if (data.bigType == 0)
    {
        BinitPersonData *info = (BinitPersonData *)data;
        
        if (info.type == 1)
        {
            return 100;
        }
        else if(info.type == 2)
        {
            return 120;
        }
        else if(info.type == 0)
        {
            return 40;
        }
        else
        {
            if (info.workerArray.count < 5)
            {
                return 40;
            }
            else if (info.workerArray.count < 9 && info.workerArray.count > 4)
            {
                return 80;
            }
            else
            {
                return 120;
            }
        }
        
        
    }
    else
    {
        return 70;
    }
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1)
    {
        return 40;
    }
    else
    {
        return 0.1;
    }
}



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    
    if (section == 1)
    {
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, 200, 30)];
        
        title.text = [NSString stringWithFormat:@"Ta收到的评价(%@)", PingNum];
        
        title.font = [UIFont systemFontOfSize:15];
        
        [view addSubview:title];
    }
    
    return view;
}





















//制作数据
- (void)initData
{
    NSMutableArray *firstArray = [NSMutableArray array];
    
    BinitPersonData *info = [[BinitPersonData alloc] init];   //type 1  为头像的cell ，   0 为正常的cell
    
    info.bigType = 0;
    info.imageStr = @"http://n.sinaimg.cn/default/1_img/uplaod/3933d981/20170907/gALk-fykuffc4212126.jpg";
    info.type = 1;
    
    [firstArray addObject:info];
    
    
    BinitPersonData * info1 = [[BinitPersonData alloc] init];
    
    info1.bigType = 0;
    info1.type = 0;
    info1.name = @"姓名:";
    info1.data = @"王二妮";
    
    [firstArray addObject:info1];
    
    
    BinitPersonData * info2 = [[BinitPersonData alloc] init];
    
    info2.bigType = 0;
    info2.type = 0;
    info2.name = @"性别:";
    info2.data = @"女";
    
    [firstArray addObject:info2];
    
    
    BinitPersonData * info3 = [[BinitPersonData alloc] init];
    
    info3.bigType = 0;
    info3.type = 0;
    info3.name = @"年龄:";
    info3.data = @"24";
    
    [firstArray addObject:info3];
    
    
    BinitPersonData * info4 = [[BinitPersonData alloc] init];
    
    info4.bigType = 0;
    info4.type = 0;
    info4.name = @"现居地:";
    info4.data = @"哈尔滨道里区";
    
    [firstArray addObject:info4];
    
    
    BinitPersonData * info5 = [[BinitPersonData alloc] init];
    
    info5.bigType = 0;
    info5.type = 0;
    info5.name = @"户口所在地:";
    info5.data = @"辽宁省沈阳市沈河区南京南街";
    
    [firstArray addObject:info5];
    
    
    BinitPersonData * info6 = [[BinitPersonData alloc] init];
    
    info6.bigType = 0;
    info6.type = 2;
    info6.name = @"个人简介:";
    info6.data = @"普通上班族，热爱生活，大神就客户打款； 啥来电话";
    
    [firstArray addObject:info6];
    
    
    
    BinitPersonData * info7 = [[BinitPersonData alloc] init];
    
    info7.bigType = 0;
    info7.type = 0;
    info7.name = @"角色选择:";
    info7.data = @"雇主";
    
    [firstArray addObject:info7];
    
    
    BinitPersonData * info8 = [[BinitPersonData alloc] init];
    
    info8.bigType = 0;
    info8.type = 3;
    info8.workerArray = worArr;
    
    [firstArray addObject:info8];

    
    
    
    [dataArray addObject:firstArray];
    
    
    
    
    
    
    
    NSMutableArray *elseArray = [NSMutableArray array];
    
    
    BinitPersonElseData * data = [[BinitPersonElseData alloc] init];
    
    data.bigType = 1;
    data.imageStr = @"http://n.sinaimg.cn/default/1_img/uplaod/3933d981/20170907/gALk-fykuffc4212126.jpg";
    data.time = @"2015年11月12哈 13：12";
    data.detail = @"人美心更美，天热还给我们水果吃，谢谢老板，以后记得有活找我们";
    
    [elseArray addObject:data];
    
    
    BinitPersonElseData * data1 = [[BinitPersonElseData alloc] init];
    
    data1.bigType = 1;
    data1.imageStr = @"http://n.sinaimg.cn/default/1_img/uplaod/3933d981/20170907/gALk-fykuffc4212126.jpg";
    data1.time = @"2015年1";
    data1.detail = @"人美心更";
    
    [elseArray addObject:data1];
    
    
    
    [dataArray addObject:elseArray];
    
    
    
    [self.tableview reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
