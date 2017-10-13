//
//  IssueViewController.m
//  worker
//
//  Created by 郭健 on 2017/8/9.
//  Copyright © 2017年 郭健. All rights reserved.
//


//获取工人列表数据
@interface workerPeData : NSObject

@property (nonatomic, strong)NSString *s_id;
@property (nonatomic, strong)NSString *s_name;
@property (nonatomic, strong)NSString *s_info;
@property (nonatomic, strong)NSString *s_desc;
@property (nonatomic, strong)NSString *s_status;


@property (nonatomic, strong)NSString *s_image;


@end

@implementation workerPeData


@end













#import "IssueViewController.h"
#import "lssueUserTableViewCell.h"
#import "BriefTableViewCell.h"
#import "elsepersonTableViewCell.h"
#import "elsetimeTableViewCell.h"
#import "elseDelegateTableViewCell.h"
#import "NormalTableViewCell.h"
#import "ThreeCityViewController.h"
#import "IndentViewController.h"
#import "indent.h"


@interface IssueViewController ()<UITableViewDelegate, UITableViewDataSource, UITextViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource>
{
    NSMutableArray *dataArray;        //支撑页面的大数组
    
    
    NSString *workerName;     //工程名称数据
    NSString *workerAdree;    //工程地址数据
    
    NSMutableArray *workerArr;  //工种的列表
    NSString *workerStr;    //工种的选择
    
    NSString *adree;  //所在区域的字段
  //  NSString *adree_id;  //所在区域的ID， 传给后台
    
    NSMutableArray *newArr;
    
    NSMutableArray *infoA;    //更改格式，传给服务器的大数组
    
    
    NSMutableArray *numWorker;    //临时用， 装工种中文字样
    NSMutableArray *EnglishWor;   //  庄工种ID数组
    
    NSString *starttime; //开始时间
    NSString *endtime;   //结束时间
    
    
    
    
    bool oneT;   //判断工种数组只删除一次， 为了防止重复累加
    
}

@property (nonatomic, strong)UITableView *tableview;

@property (nonatomic, strong)UIDatePicker *startTime;   //项目开始时间的控件
@property (nonatomic, strong)UIDatePicker *endTime;     //项目结束时间的控件

@end

@implementation IssueViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    oneT = YES;
    
    newArr = [NSMutableArray array];
    
    dataArray = [NSMutableArray array];
    
    workerArr = [NSMutableArray array];
    
    numWorker = [NSMutableArray array];
    
    EnglishWor = [NSMutableArray array];
    
    [self initData];
    
    
    
    [self addhead:@"发布工作"];
    
    [self slitherBack:self.navigationController];
    
    [self initDraft];
    
    [self tableview];
    
     [self workerData];   //获取工种列表
    
    
    
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
        
        
        [_tableview registerClass:[NormalTableViewCell class] forCellReuseIdentifier:@"normalcell"];
        
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
    
    if ([data.bigType isEqualToString:@"1"])
    {
        firstModel *info = (firstModel *)data;
        
        if (info.type == 0)
        {
            lssueUserTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            
            if (!cell)
            {
                
                cell = [[lssueUserTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"usercell"];
                
                cell.name.text = info.name;
                if (indexPath.row == 0)
                {
                    cell.data.placeholder = @"工程名称";
                }
                else if(indexPath.row == 4)
                {
                   cell.data.placeholder = @"请输入详细地址，不少于5个字";
                }
                
                
                cell.data.text = info.data;
                
                
                cell.data.restorationIdentifier = [NSString stringWithFormat:@"%ld%ld%@", indexPath.section, indexPath.row , @"0"];
                
                [cell.data addTarget:self action:@selector(textFiled:) forControlEvents:UIControlEventEditingChanged];
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
            }
            
            
            return cell;
        }
        else if ([info.type isEqualToString:@"10"])
        {
            
            NormalTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            
            if (!cell)
            {
                cell = [[NormalTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"normalcell"];
                
                cell.title.text = info.name;
                cell.data.text = info.data;
                
               
                
                
            }
            
            return cell;
        }
        else
        {
            BriefTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            
            if (!cell)
            {
                
                cell = [[BriefTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"briefcell"];
                
                cell.name.font = [UIFont systemFontOfSize:16];
                cell.name.text = @"描述:";
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                cell.data.text = info.data;
                cell.data.delegate = self;
                
                
            }
            
            
            
            return cell;
        }
        
    }
    else
    {
        elseModel *info = (elseModel *)data;
        
        if ([info.workerType isEqualToString:@"0"])
        {
            NormalTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            
            if (!cell)
            {
                cell = [[NormalTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"normalcell"];
                
                cell.title.text = info.workerName;
                
                cell.data.text = info.placeData;
                
                cell.data.restorationIdentifier = [NSString stringWithFormat:@"%ld", indexPath.section];
                
            }
            
            
            
            return cell;
            
        }
        else if ([info.workerType isEqualToString:@"1"])
        {
            elsepersonTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            
            if (!cell)
            {
                cell = [[elsepersonTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"elseperson"];
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                cell.personfield.text = info.personNum;
                
                cell.moneyfield.text = info.money;
                
                [cell.personfield addTarget:self action:@selector(textFiled:) forControlEvents:UIControlEventEditingChanged];
                [cell.moneyfield addTarget:self action:@selector(textFiled:) forControlEvents:UIControlEventEditingChanged];
                
                cell.personfield.restorationIdentifier = [NSString stringWithFormat:@"%ld%ld%@", indexPath.section, indexPath.row, @"1"];
                cell.moneyfield.restorationIdentifier = [NSString stringWithFormat:@"%ld%ld%@", indexPath.section, indexPath.row, @"2"];
                
            }
            
            return cell;
            
        }
        else if([info.workerType isEqualToString:@"2"])
        {
            
            elsetimeTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            
            if (!cell)
            {
                cell = [[elsetimeTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"elsetime"];
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                
                [cell.start addTarget:self action:@selector(startBtn:) forControlEvents:UIControlEventTouchUpInside];
                [cell.end addTarget:self action:@selector(endBtn:) forControlEvents:UIControlEventTouchUpInside];
                
                
                
                cell.start.tag = indexPath.section * 100 + indexPath.row * 10 + 1;
                cell.end.tag = indexPath.section * 100 + indexPath.row * 10 + 1;
                
                cell.startTime.text = info.startTime;
                cell.endTime.text = info.endTime;
                
                cell.startTime.enabled = YES;
                cell.end.enabled = YES;
                
//                [cell.startTime addTarget:self action:@selector(textFiled:) forControlEvents:UIControlEventEditingChanged];
//                [cell.endTime addTarget:self action:@selector(textFiled:) forControlEvents:UIControlEventEditingChanged];
//
//                cell.startTime.restorationIdentifier = [NSString stringWithFormat:@"%ld%ld%@", indexPath.section, indexPath.row, @"3"];
//                cell.endTime.restorationIdentifier = [NSString stringWithFormat:@"%ld%ld%@", indexPath.section, indexPath.row, @"4"];
            }
            
            return cell;
        
        }
        else
        {
            elseDelegateTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            
            if (!cell)
            {
                cell = [[elseDelegateTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"deletecell"];
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            
            
            
            return cell;
        }
        
    }
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *arr = [dataArray objectAtIndex:indexPath.section];
    
    selecdType *data = [arr objectAtIndex:indexPath.row];
    
    if ([data.bigType isEqualToString:@"1"])
    {
        firstModel *info = (firstModel *)data;
        
        if ([info.type isEqualToString:@"1"])
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


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    
    return view;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 15;
    }
    else
    {
        return 0.1;
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
        return 15;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *arr = [dataArray objectAtIndex:indexPath.section];
    
    selecdType *data = [arr objectAtIndex:indexPath.row];
    
    if ([data.bigType isEqualToString:@"1"])
    {
        firstModel *model = (firstModel *)data;
        
        if ([model.type isEqualToString:@"10"])
        {
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            
            if (indexPath.row == 2)
            {
                NSArray *arr = [dataArray objectAtIndex:0];
                
                selecdType *data = [arr objectAtIndex:2];
                
                firstModel *model = (firstModel *)data;
                
                //工程类型点击
                UIAlertController *AlertController = [UIAlertController alertControllerWithTitle:@"工程类型" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
                
                UIAlertAction *Return = [UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleCancel handler:nil];
                
                [AlertController addAction:Return];
                
                for (int i = 0; i < workerArr.count; i++)
                {
                    UIAlertAction *action = [UIAlertAction actionWithTitle:[workerArr objectAtIndex:i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                                             {
                                                 
                                                 model.data = action.title;
                                                 
                                                 [self.tableview reloadData];
                                                 
                                             }];
                    
                    
                    [AlertController addAction:action];
                }
                
                [self presentViewController:AlertController animated:YES completion:nil];
                
                
            }
            else
            {
                //所在区域点击
                ThreeCityViewController *temp = [[ThreeCityViewController alloc] init];
                temp.delegate = self;
                [self presentViewController:temp animated:YES completion:nil];
                
            }
        }
        
    }
    else
    {
        elseModel *info = (elseModel *)data;
        
        if ([info.workerType isEqualToString:@"3"])
        {
            //删除工种cell
            
            [dataArray removeObjectAtIndex:indexPath.section];
            
            [self.tableview reloadData];
            
        }
        else if ([info.workerType isEqualToString:@"0"])
        {
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            
            [self addWorker:indexPath];
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
    [newArr removeAllObjects];
    
    for (int i = 0; i < dataArray.count; i++)
    {
        NSArray *arr = [dataArray objectAtIndex:i];
        
        NSMutableArray *infoArr = [NSMutableArray array];
        
        for (int j = 0; j < arr.count; j++)
        {
            
            selecdType *data = [arr objectAtIndex:j];
            
            NSDictionary *dic = [myselfway entityToDictionary:data];
            
            [infoArr addObject:dic];
        }
        
        [newArr addObject:infoArr];
    
    }
    
    
    
    //修改数据格式， 上传服务器
    infoA = [NSMutableArray array];

    NSMutableArray *arra = [NSMutableArray array];
    
    for (int i = 0; i < newArr.count; i++)
    {
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        
        NSArray *arr = [newArr objectAtIndex:i];
        
        if (i == 0)
        {
            [dic setValue:arr forKey:@"basic"];
            
            [infoA addObject:dic];
        }
        else
        {
            [arra addObject:arr];
        }
    
    }
    
    
    NSMutableDictionary *workerDic = [NSMutableDictionary dictionary];
    
    [workerDic setValue:arra forKey:@"worker"];
    
    [infoA addObject:workerDic];
    
    
    self.hidesBottomBarWhenPushed = YES;
    
    IndentViewController *temp = [[IndentViewController alloc] init];
    
    temp.postArray = infoA;
    temp.modelArray = dataArray;
    
    temp.longitudeWor = self.longitudeWor;
    temp.latitudeWor = self.latitudeWor;
    
    [self.navigationController pushViewController:temp animated:YES];
    
    
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
    
    data0.workerType = @"0";
    
    data0.workerName = @"选择工种";
    
    data0.placeData = @"点击选择招聘工种";
    
    [elseArray addObject:data0];
    
    
    
    elseModel *data1 = [[elseModel alloc] init];
    
    data1.bigType = 0;
    
    data1.workerType = @"1";
    
    [elseArray addObject:data1];
    
    
    
    elseModel *data2 = [[elseModel alloc] init];
    
    data2.bigType = 0;
    
    data2.workerType = @"2";
    
    [elseArray addObject:data2];
    

    elseModel *data3 = [[elseModel alloc] init];
    
    data3.bigType = 0;
    
    data3.workerType = @"3";
    
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
    
   // info0.data = @"工程名称";
    
    info0.type = 0;
    
    info0.bigType = @"1";
    
    [first addObject:info0];
    
    
    firstModel *info1 = [[firstModel alloc] init];
    
    info1.name = @"描述:";
    
    info1.type = @"1";
    
    info1.bigType = @"1";
    
    [first addObject:info1];
    
    
    firstModel *info2 = [[firstModel alloc] init];
    
    info2.name = @"工程类型:";
    
    info2.data = @"选择项目类型";
    
    info2.type = @"10";            //type = 10   左右都是label类型的cell
    
    info2.bigType = @"1";
    
    [first addObject:info2];
    
    
    firstModel *info3 = [[firstModel alloc] init];
    
    info3.name = @"所在区域:";
    
    info3.data = @"选择工作所在区域";
    
    info3.type = @"10";
    
    info3.bigType = @"1";
    
    [first addObject:info3];
    
    
    
    
    firstModel *info4 = [[firstModel alloc] init];
    
    info4.name = @"详细地址:";
    
//    info4.data = @"请输入详细地址，不少于5个字";
    
    info4.type = 0;
    
    info4.bigType = @"1";
    
    [first addObject:info4];
    
    [dataArray addObject:first];
    
    
    
    NSMutableArray *elseArray = [NSMutableArray array];
    
    elseModel *data0 = [[elseModel alloc] init];
    
    data0.bigType = 0;
    
    data0.workerType = @"0";
    
    data0.workerName = @"选择工种";
    
    data0.placeData = @"点击选择招聘工种";
    
    [elseArray addObject:data0];
    
    
    
    elseModel *data1 = [[elseModel alloc] init];
    
    data1.bigType = 0;
    
    data1.workerType = @"1";
    
    
    
    [elseArray addObject:data1];
    
    
    
    elseModel *data2 = [[elseModel alloc] init];
    
    data2.bigType = 0;
    
    data2.workerType = @"2";
    
    [elseArray addObject:data2];
    
    
    [dataArray addObject:elseArray];

}







//获取编辑框的内容
- (void)textFiled: (UITextField *)textfield
{
    NSString *str = textfield.restorationIdentifier;
    
    NSString *sectionStr = [str substringToIndex:1];//section
    
    NSString *rowStr = [str substringWithRange:NSMakeRange(1, 1)]; //row
    
    NSString *numStr = [str substringFromIndex:str.length - 1];  //最后一位
    
    NSInteger section = [sectionStr integerValue];
    NSInteger row = [rowStr integerValue];
    NSInteger end = [numStr integerValue];
    
   // NSLog(@"%ld%ld%ld", section, row, end);
    
    NSArray *arr = [dataArray objectAtIndex:section];
    
    selecdType *data = [arr objectAtIndex:row];

    if ([data.bigType isEqualToString:@"1"])
    {
        firstModel *model = (firstModel *)data;
        
        model.data = textfield.text;
        
    }
    else
    {
        elseModel *model = (elseModel *)data;
        
        if (end == 1)
        {
            model.personNum = textfield.text;
        }
        else if (end == 2)
        {
            model.money = textfield.text;
        }
//        else if (end == 3)
//        {
//            model.startTime = textfield.text;
//        }
//        else
//        {
//            model.endTime = textfield.text;
//        }
    }

}



- (void)textViewDidChange:(UITextView *)textView
{
    NSArray *arr = [dataArray objectAtIndex:0];
    
    selecdType *data = [arr objectAtIndex:1];
    
    firstModel *info = (firstModel *)data;
    
    info.data = textView.text;
}



//调出工种列表
- (void)addWorker: (NSIndexPath *)index
{
 
    
    NSArray *arr = [dataArray objectAtIndex:index.section];
    
    selecdType *data = [arr objectAtIndex:0];
    
    elseModel *info = (elseModel *)data;
    
    UIAlertController *AlertController = [UIAlertController alertControllerWithTitle:@"工种选择" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *Return = [UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleCancel handler:nil];
    
    [AlertController addAction:Return];
    
    
    if (oneT == YES)
    {
        oneT = NO;
    }
    else
    {
        [workerArr removeAllObjects];
    }
    
    
    
    for (int i = 0; i < workerArr.count; i++)
    {
        workerPeData *data = [workerArr objectAtIndex:i];
        
        [numWorker addObject:data.s_name];
        
        [EnglishWor addObject:data.s_id];
    }
    
    
    
    
    
    for (int i = 0; i < numWorker.count; i++)
    {
        UIAlertAction *action = [UIAlertAction actionWithTitle:[numWorker objectAtIndex:i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
        {
            
            info.placeData = action.title;
            
            info.skill = [EnglishWor objectAtIndex:i];
            
            [self.tableview reloadData];
        }];
        
        
        [AlertController addAction:action];
    }
    
    [self presentViewController:AlertController animated:YES completion:nil];
    
}


//所在区域的代理方法， 获取r_id
- (void)post3Level: (NSString *)city_id1 city_name1:(NSString *)name city_id2:(NSString *)city_id city_name2:(NSString *)city_name2 city_id2:(NSString *)city_id2 city_name3:(NSString *)city_name3
{
   // NSLog(@"省=%@， 市=%@， 区=%@， 省ID=%@， 市ID=%@， 区ID=%@", name, city_name2, city_name3, city_id1, city_id, city_id2);
    adree = city_name3;
    
    NSArray *arr = [dataArray objectAtIndex:0];
    selecdType *data = [arr objectAtIndex:3];
    firstModel *model = (firstModel *)data;
    
    
    model.data = adree;
    model.province_id = city_id1;
    model.city_id = city_id;
    model.district_id = city_id2;

    [self.tableview reloadData];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
    _startTime.hidden = YES;
    _endTime.hidden = YES;
}




- (void)Postdata
{
    NSString *url = [NSString stringWithFormat:@"%@%@", baseUrl, @"Index/task"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:url parameters:infoA success:^(NSURLSessionDataTask *task, id responseObject)
     {
         NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         
         if ([[dictionary objectForKey:@"code"] integerValue] == 200)
         {
             
         }
         else
         {
             
         }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
    
}



//项目开始时间调用datapick
- (void)startBtn: (UIButton *)btn
{
    
    
    if (_startTime.hidden == YES)
    {
        _startTime.hidden = NO;
    }
    else
    {
        [self startTime];
    }
    
    
    _startTime.tag = btn.tag;
    
}

//项目结束时间调用datapick
- (void)endBtn: (UIButton *)btn
{
    if (_endTime.hidden == YES)
    {
        _endTime.hidden = NO;
    }
    else
    {
        [self endTime];
    }
    
    
    _endTime.tag = btn.tag;
}




- (UIDatePicker *)startTime
{
    if (!_startTime)
    {
        _startTime = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 216, SCREEN_WIDTH, 216)];
        _startTime.date = [NSDate date]; // 设置初始时间
        _startTime.timeZone = [NSTimeZone timeZoneWithName:@"GTM+8"];
        _startTime.datePickerMode = UIDatePickerModeDate;
        _startTime.backgroundColor = [myselfway stringTOColor:@"0xF3F3F3"];
        [_startTime addTarget:self action:@selector(seletedBirthyDate:) forControlEvents:UIControlEventValueChanged];
        
        [self.view addSubview:_startTime];
    }
    
    return _startTime;
    
}



- (void)seletedBirthyDate: (UIDatePicker *)data
{
    
    NSDate *select = [data date]; // 获取被选中的时间
    
    NSDateFormatter *selectDateFormatter = [[NSDateFormatter alloc] init];
    
    selectDateFormatter.dateFormat = @"yyyy-MM-dd"; // 设置时间和日期的格式
    
//    starttime = [selectDateFormatter stringFromDate:select]; // 把date类型转为设置好格式的string类型
    
    
    
    NSString *str = [NSString stringWithFormat:@"%ld", data.tag];
    
    NSString *sectionStr = [str substringToIndex:1];//section
    
    NSString *rowStr = [str substringWithRange:NSMakeRange(1, 1)]; //row
    
    //  NSString *numStr = [str substringFromIndex:str.length - 1];  //最后一位
    
    NSInteger section = [sectionStr integerValue];
    NSInteger row = [rowStr integerValue];
    // NSInteger end = [numStr integerValue];
    
    NSArray *arr = [dataArray objectAtIndex:section];
    
    selecdType *info = [arr objectAtIndex:row];
    
    
    elseModel *model = (elseModel *)info;
        
    
    
    
    
    //比较时间大小
    if ([model.workerType isEqualToString:@"2"])
    {
        NSString *staT = [[selectDateFormatter stringFromDate:select] stringByReplacingOccurrencesOfString:@"-" withString:@""];
        NSString *endT = [model.endTime stringByReplacingOccurrencesOfString:@"-" withString:@""];
        
        if (endT == nil)
        {
            endT = @"1111111110";
        }
        
        if ([staT integerValue] > [endT integerValue])
        {
            [SVProgressHUD showInfoWithStatus:@"开始时间不应大于结束时间"];
        }
        else
        {
            model.startTime = [selectDateFormatter stringFromDate:select];
        
            [self.tableview reloadData];
        }
    }
    
    
    
    
    
    
   
    
}


- (UIDatePicker *)endTime
{
    if (!_endTime)
    {
        _endTime = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 216, SCREEN_WIDTH, 216)];
        _endTime.date = [NSDate date]; // 设置初始时间
        _endTime.timeZone = [NSTimeZone timeZoneWithName:@"GTM+8"];
        _endTime.datePickerMode = UIDatePickerModeDate;
        _endTime.backgroundColor = [myselfway stringTOColor:@"0xF3F3F3"];
        [_endTime addTarget:self action:@selector(seletedBirthyDatetO:) forControlEvents:UIControlEventValueChanged];
        
        [self.view addSubview:_endTime];
    }
    
    return _endTime;
    
}



- (void)seletedBirthyDatetO: (UIDatePicker *)data
{
    
    NSDate *select = [data date]; // 获取被选中的时间
    
    NSDateFormatter *selectDateFormatter = [[NSDateFormatter alloc] init];
    
    selectDateFormatter.dateFormat = @"yyyy-MM-dd"; // 设置时间和日期的格式
    
 //   starttime = [selectDateFormatter stringFromDate:select]; // 把date类型转为设置好格式的string类型
    
    
    NSString *str = [NSString stringWithFormat:@"%ld", data.tag];
    
    NSString *sectionStr = [str substringToIndex:1];//section
    
    NSString *rowStr = [str substringWithRange:NSMakeRange(1, 1)]; //row
    
    //  NSString *numStr = [str substringFromIndex:str.length - 1];  //最后一位
    
    NSInteger section = [sectionStr integerValue];
    NSInteger row = [rowStr integerValue];
    // NSInteger end = [numStr integerValue];
    
    NSArray *arr = [dataArray objectAtIndex:section];
    
    selecdType *info = [arr objectAtIndex:row];
    
    
    elseModel *model = (elseModel *)info;
    

    
    //比较时间大小
    if ([model.workerType isEqualToString:@"2"])
    {
        NSString *staT = [model.startTime stringByReplacingOccurrencesOfString:@"-" withString:@""];
        NSString *endT = [[selectDateFormatter stringFromDate:select] stringByReplacingOccurrencesOfString:@"-" withString:@""];
        
        if (staT == nil)
        {
            staT = @"0";
        }
        
        if ([staT integerValue] > [endT integerValue])
        {
            [SVProgressHUD showInfoWithStatus:@"开始时间不应大于结束时间"];
        }
        else
        {
            model.endTime = [selectDateFormatter stringFromDate:select];
            
            [self.tableview reloadData];
        }
    }
    
    
}







//获取工种列表数据
- (void)workerData
{
    
    NSString *url = [NSString stringWithFormat:@"%@%@", baseUrl, @"Skills/index"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject)
     {
         NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         
         if ([[dictionary objectForKey:@"code"] integerValue] == 200)
         {
             NSArray *arr = [dictionary objectForKey:@"data"];
             
             for (int i = 0; i < arr.count; i++)
             {
                 NSDictionary *dic = [arr objectAtIndex:i];
                 
                 workerPeData *data = [[workerPeData alloc] init];
                 
                 data.s_id = [dic objectForKey:@"s_id"];
                 data.s_desc = [dic objectForKey:@"s_desc"];
                 data.s_info = [dic objectForKey:@"s_info"];
                 data.s_name = [dic objectForKey:@"s_name"];
                 data.s_status = [dic objectForKey:@"s_status"];
                 
                 
                 [workerArr addObject:data];
                 
             }
             
         }
         
     } failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         
     }];
    
    
}



//省事三级联动返回代理







@end
