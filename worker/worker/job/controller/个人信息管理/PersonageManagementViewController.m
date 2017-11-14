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
#import "EditCraftTableViewCell.h"
#import "EdirAddTableViewCell.h"
#import "ThreeCityViewController.h"


#define workerNum 4

//获取工人列表数据
@interface workerPerData : NSObject

@property (nonatomic, strong)NSString *s_id;
@property (nonatomic, strong)NSString *s_name;
@property (nonatomic, strong)NSString *s_info;
@property (nonatomic, strong)NSString *s_desc;
@property (nonatomic, strong)NSString *s_status;


@property (nonatomic, strong)NSString *s_image;


@end

@implementation workerPerData


@end

//信息和信息预览数据类
@interface PersonDataClass : NSObject

@property (nonatomic, strong)NSString *typeInf;   //判断cell类型

@property (nonatomic, strong)NSString *name;

@property (nonatomic, strong)NSString *data;

@property (nonatomic, strong)NSMutableArray *workerArray;  //工种的数组


//编辑信息数据需要属性
@property (nonatomic, strong)NSString *sex;
@property (nonatomic, strong)NSString *placehold;

@end


@implementation PersonDataClass

@end



@interface PersonageManagementViewController ()<UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate,UINavigationControllerDelegate, UITextFieldDelegate, UITextViewDelegate>
{
    NSMutableArray *dataArray;    //信息和信息预览的数组
    NSMutableArray *writeArray;   //编辑信息数组
    
    
    NSMutableArray *nameArr;     //信息预览，编辑信息的按钮名称数组
    
    NSInteger typeInfo;      //判断是信息预览还是编辑信息还是投递记录
    
    Headview *Hview;
    
    NSMutableArray *Warr;   //没啥用
    
    NSMutableArray *addworker;   //添加工种的数组
    

    UserInfoModel *model;   //用户信息数据模型
    UserAdreeData *addmodel;   //用户地址信息数据模型
    
    NSMutableArray *workerPer;   //获取工种列表的数据数组
    
    NSInteger xianzhiCount;    //限制编辑信息里，数组添加的次数， 只能添加一次
    
    NSString *selectWorker;    //alert所选择的工种
    
    NSMutableArray *chineseWorker;    //信息预览页面  工种添加的中文数组
    
    
    NSString *level1;  //省ID
    NSString *level2;  //市ID
    NSString *level3;  //区ID
    
    BOOL yeOrno;   //判断校验是否通过
    
}

@property (nonatomic, strong)UITableView *tableview;

@property (nonatomic, strong)UIDatePicker *dataPick;

@end

@implementation PersonageManagementViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    yeOrno = NO;
    
    Warr = [NSMutableArray array];

    
    typeInfo = 0;    //初始化为0，默认选择是信息预览
    
    chineseWorker = [NSMutableArray array];
    addworker = [NSMutableArray array];
    dataArray = [NSMutableArray array];       //信息预览数组
    writeArray = [NSMutableArray array];      //编辑信息数组
    workerPer = [NSMutableArray array];

    
    
    [self workerData];   //获取工种列表
    
 //   arr = [NSMutableArray arrayWithObjects:@"水泥工",@"水暖工",@"瓦工", @"壁纸工",@"张飞", nil];
    
    
    
    
    
    nameArr = [NSMutableArray arrayWithObjects:@"信息预览",@"编辑信息", nil];
    
    
    [self addhead:@"个人信息管理"];
    
    [self slitherBack:self.navigationController];

    [self initHeadView];
    
    [self tableview];
    
    
}



//加载headview
- (void)initHeadView
{
    
    Hview = [[Headview alloc] initWithFrame:CGRectMake(0, 65, SCREEN_WIDTH, 120)];
    
    Hview.dataArray = nameArr;
    
    [Hview.btnIcon addTarget:self action:@selector(ImageBtn) forControlEvents:UIControlEventTouchUpInside];
    
    Hview.delegate = self;
    
    if (user_imaData)
    {
        UIImage *image1 = [UIImage imageWithData:user_imaData];
        
        Hview.Icon.image = image1;
    }
    else
    {
        NSURL *url = [NSURL URLWithString:user_ima];
        
        [Hview.Icon sd_setImageWithURL:url];
    }
    
    
    
    Hview.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:Hview];
    
}




#pragma tableview代理

- (UITableView *)tableview
{
    if (!_tableview)
    {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 186, SCREEN_WIDTH, SCREEN_HEIGHT - 186) style:UITableViewStyleGrouped];
        
        _tableview.delegate = self;
        _tableview.dataSource = self;
        
        _tableview.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.1)];
        _tableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.1)];
        
        [_tableview registerClass:[PreviewTableViewCell class] forCellReuseIdentifier:@"typecell"];
        [_tableview registerClass:[BriefTableViewCell class] forCellReuseIdentifier:@"briefcell"];
        [_tableview registerClass:[CraftTableViewCell class] forCellReuseIdentifier:@"craftcell"];
        
        [_tableview registerClass:[WorkerMessTableViewCell class] forCellReuseIdentifier:@"workercell"];
        
        [_tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        
        [_tableview registerClass:[EditTextTableViewCell class] forCellReuseIdentifier:@"cell0"];
        [_tableview registerClass:[EditSetTableViewCell class] forCellReuseIdentifier:@"cell1"];
        [_tableview registerClass:[EditSelecedTableViewCell class] forCellReuseIdentifier:@"cell3"];
        [_tableview registerClass:[EditCraftTableViewCell class] forCellReuseIdentifier:@"cell5"];
        [_tableview registerClass:[EdirAddTableViewCell class] forCellReuseIdentifier:@"endcell"];
        
        [self.view addSubview:_tableview];
    }
    
    return _tableview;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if(typeInfo == 0)
    {
       return dataArray.count;
    }
    else
    {
       return writeArray.count;
    }
    
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
            
            if (indexPath.row == 6)
            {
                //隐藏
                if (data.data.length > 10)
                {
                    cell.name.text = data.name;
                    
                    NSString *info = [data.data stringByReplacingCharactersInRange:NSMakeRange(3, 4)  withString:@"****"];

                    cell.data.text = info;
                }

            }
            else if (indexPath.row == 2)
            {
                if (data.data.length > 17)
                {
                    cell.name.text = data.name;
                    
                    NSString *info = [data.data stringByReplacingCharactersInRange:NSMakeRange(6, 8)  withString:@"****"];

                    cell.data.text = info;
                }

            }
            else
            {
                cell.name.text = data.name;
                cell.data.text = data.data;
            }
            
            
            
            return cell;
            
        }
        else if([data.typeInf isEqualToString:@"1"])
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
            
            cell.dataArray = data.workerArray;
            
            return cell;
        }
        
    }
    else                      //信息编辑
    {
        
        PersonDataClass *data = [writeArray objectAtIndex:indexPath.row];
        
        if (data.typeInf == 0)
        {
            EditTextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell0"];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.name.text = data.name;
            cell.field.text = data.data;
            
            if (indexPath.row == 6)
            {
                cell.field.userInteractionEnabled = NO;
            }
            
            
            cell.field.tag = indexPath.row + 700;
            cell.field.delegate = self;
            [cell.field addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
            
            cell.field.placeholder = data.placehold;
            
            return cell;
        }
        else if ([data.typeInf isEqualToString:@"1"])
        {
            EditSetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
            
            [cell.manBtn addTarget:self action:@selector(manBtn:) forControlEvents:UIControlEventTouchUpInside];
            [cell.womanBtn addTarget:self action:@selector(womanBtn:) forControlEvents:UIControlEventTouchUpInside];
            
            cell.manBtn.tag = 300;
            cell.womanBtn.tag = 400;
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.name.text = data.name;
            cell.manBtn.backgroundColor = [UIColor grayColor];
            cell.womanBtn.backgroundColor = [UIColor grayColor];
            cell.man.text = @"男";
            cell.woman.text = @"女";
            
            if ([data.data isEqualToString:@"男"])
            {
                cell.manBtn.backgroundColor = [UIColor redColor];
                
                
            }
            else
            {
                cell.womanBtn.backgroundColor = [UIColor redColor];
            }
            
            return cell;
        }
        else if ([data.typeInf isEqualToString:@"2"])
        {
            PreviewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"typecell"];
            
            cell.name.text = data.name;
            cell.data.text = data.data;
            
            return cell;
            
        }
        else if ([data.typeInf isEqualToString:@"3"])
        {
            
            BriefTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"briefcell"];
            
            cell.name.text = data.name;
            
            cell.data.text = data.data;
            
            cell.data.delegate = self;
            
            cell.data.userInteractionEnabled = YES;
            
            
            return cell;
            
        }
        else if ([data.typeInf isEqualToString:@"4"])
        {
            
            EditSelecedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell3"];
            
            [cell.manBtn addTarget:self action:@selector(yesWorker:) forControlEvents:UIControlEventTouchUpInside];
            [cell.womanBtn addTarget:self action:@selector(noWorker:) forControlEvents:UIControlEventTouchUpInside];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.manBtn.backgroundColor = [UIColor grayColor];
            cell.womanBtn.backgroundColor = [UIColor grayColor];
            
            cell.name.text = data.name;
            
            cell.man.text = @"我不是工人";
            cell.woman.text = @"我是工人";
            
            if ([data.data isEqualToString:@"我不是工人"])
            {
                cell.manBtn.backgroundColor = [UIColor redColor];
            }
            else
            {
                cell.womanBtn.backgroundColor = [UIColor redColor];
            }
            
            return cell;
            
        }
        else if([data.typeInf isEqualToString:@"5"])
        {
            
            EditCraftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell5"];
            
            cell.clipsToBounds = YES;
            
            cell.delegate = self;
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.dataArray = data.workerArray;
            
            return cell;
            
        }
        else
        {
            EdirAddTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            
            if (!cell)
            {
                cell = [[EdirAddTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"endcell"];
                
                
               // cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
            }
            
            return cell;
        }
        
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
        else if([data.typeInf isEqualToString:@"1"])
        {
            return 120;
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
    else
    {
        PersonDataClass *data = [writeArray objectAtIndex:indexPath.row];
        
        if ([data.typeInf isEqualToString:@"3"])
        {
            return 120;
        }
        else if([data.typeInf isEqualToString:@"5"])
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
        else if([data.typeInf isEqualToString:@"6"])
        {
            return 50;
        }
        else
        {
            return 40;
        }
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


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (typeInfo == 1)
    {
        return 60;
    }
    else
    {
        return 0.1;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (typeInfo == 1)
    {
        if (indexPath.row == 3)
        {
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            
            ThreeCityViewController *temp = [[ThreeCityViewController alloc] init];
            
            temp.delegate = self;
            
            [self presentViewController:temp animated:YES completion:nil];
            
        }
        else if (indexPath.row == 9)
        {
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            
            UIAlertController *alertcontroller = [UIAlertController alertControllerWithTitle:@"工种列表" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            
            UIAlertAction *returnAlert = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            
            [alertcontroller addAction:returnAlert];
            
            
            for (int i = 0; i < workerPer.count; i++)
            {
                workerPerData *data = [workerPer objectAtIndex:i];
                
                UIAlertAction *action = [UIAlertAction actionWithTitle:data.s_name style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                {
                    selectWorker = action.title;
                    
                   
                    [chineseWorker addObject:selectWorker];
                    
                    PersonDataClass *data = [writeArray objectAtIndex:7];
                    
                    data.workerArray = chineseWorker;
                    
                    [self.tableview reloadData];
                    
                }];
                
                
                
                
                
                [alertcontroller addAction:action];
            }
            
            
            [self presentViewController:alertcontroller animated:YES completion:nil];
            
        }
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    UIView *footview = [[UIView alloc] init];
    
    if (typeInfo == 1)
    {
        UIButton *save = [UIButton buttonWithType:UIButtonTypeSystem];
        
        [save setTitle:@"提交信息" forState:UIControlStateNormal];
        
        [save addTarget:self action:@selector(savebtn) forControlEvents:UIControlEventTouchUpInside];
        
        save.backgroundColor = [myselfway stringTOColor:@"0xFC4154"];
        
        save.layer.cornerRadius = 5;
        
        save.frame = CGRectMake(15, 10, SCREEN_WIDTH - 30, 40);
        
        save.tintColor = [UIColor whiteColor];
        
        [footview addSubview:save];
    }

    
    return footview;
    
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
    _dataPick.hidden = YES;
}


//获取textfield的数据
- (void)textFieldDidChange:(UITextField *)textField
{
    NSInteger row = textField.tag - 700;
    
    PersonDataClass *info = [writeArray objectAtIndex:row];
    
    info.data = textField.text;
   
}


//textview的代理方法， 获取textview 的数据
- (void)textViewDidChangeSelection:(UITextView *)textView
{
    PersonDataClass *data = [writeArray objectAtIndex:5];
    
    data.data = textView.text;
    
}




#pragma 自己的方法

//工种的点击事件代理方法，点击后删除该工种
- (void)tempValNum: (NSInteger)info
{
    PersonDataClass *data = [dataArray objectAtIndex:8];
    
    [data.workerArray removeObjectAtIndex:info];
    
    [self.tableview reloadData];
}


//选择性别男的按钮
- (void)manBtn: (UIButton *)btn
{
    PersonDataClass *data = [writeArray objectAtIndex:1];
    data.data = @"男";
    [self.tableview reloadData];
}

//选择性别女的按钮
- (void)womanBtn: (UIButton *)btn
{
    PersonDataClass *data = [writeArray objectAtIndex:1];
    data.data = @"女";
    [self.tableview reloadData];
}


//我不是工人按钮
- (void)yesWorker: (UIButton *)btn
{
    PersonDataClass *data = [writeArray objectAtIndex:7];
    data.data = @"我不是工人";
    
    if (xianzhiCount == 1)
    {
        [writeArray removeObjectAtIndex:9];
        [writeArray removeObjectAtIndex:8];
        
        [self.tableview reloadData];
        
        //只可删除一次， 然后不可删除
        xianzhiCount = 0;
    }
    
    
    
    
    
    
}


//我是工人按钮
- (void)noWorker: (UIButton *)btn
{
    PersonDataClass *data = [writeArray objectAtIndex:7];
    data.data = @"我是工人";
    
    if (xianzhiCount == 0)
    {
        PersonDataClass *info8 = [[PersonDataClass alloc] init];
        info8.workerArray = chineseWorker;
        info8.typeInf = @"5";
        
        [writeArray addObject:info8];
        
        
        PersonDataClass *info9 = [[PersonDataClass alloc] init];
        
        info9.typeInf = @"6";
        
        [writeArray addObject:info9];
        
        [self.tableview reloadData];
        
        //只可添加一次， 然后不可添加
        xianzhiCount = 1;
    }

    
}




//提交信息按钮
- (void)savebtn
{
    
    PersonDataClass *infn0 = [writeArray objectAtIndex:0];
 //   PersonDataClass *infn1 = [writeArray objectAtIndex:1];
    PersonDataClass *infn2 = [writeArray objectAtIndex:2];
    PersonDataClass *infn3 = [writeArray objectAtIndex:3];
    PersonDataClass *infn4 = [writeArray objectAtIndex:4];
    PersonDataClass *infn5 = [writeArray objectAtIndex:5];
    PersonDataClass *infn6 = [writeArray objectAtIndex:6];
 //   PersonDataClass *infn7 = [writeArray objectAtIndex:7];

    if (writeArray.count == 10)
    {
        PersonDataClass *infn8 = [writeArray objectAtIndex:8];
        
        if (infn8.workerArray.count == 0)
        {
            [SVProgressHUD showErrorWithStatus:@"请添加工种"];
            [self performSelector:@selector(NoDiss) withObject:self afterDelay:1.5];
        }
        else if (infn0.data.length == 0)
        {
            [SVProgressHUD showErrorWithStatus:@"请输入姓名"];
            [self performSelector:@selector(NoDiss) withObject:self afterDelay:1.5];
        }
        else if (infn2.data.length == 0)
        {
            [SVProgressHUD showErrorWithStatus:@"请输入身份证号"];
            [self performSelector:@selector(NoDiss) withObject:self afterDelay:1.5];
        }
        else if (infn2.data.length != 18)
        {
            [SVProgressHUD showErrorWithStatus:@"身份证号不正确"];
            [self performSelector:@selector(NoDiss) withObject:self afterDelay:1.5];
        }
        else if (infn3.data.length == 0)
        {
            [SVProgressHUD showErrorWithStatus:@"请选择先居住地"];
            [self performSelector:@selector(NoDiss) withObject:self afterDelay:1.5];
        }
        else if (infn4.data.length == 0)
        {
            [SVProgressHUD showErrorWithStatus:@"请编辑详细地址"];
            [self performSelector:@selector(NoDiss) withObject:self afterDelay:1.5];
        }
        else if (infn5.data.length == 0)
        {
            [SVProgressHUD showErrorWithStatus:@"请输入个人简介"];
            [self performSelector:@selector(NoDiss) withObject:self afterDelay:1.5];
        }
        else if (infn5.data.length == 0)
        {
            [SVProgressHUD showErrorWithStatus:@"请输入个人简介"];
            [self performSelector:@selector(NoDiss) withObject:self afterDelay:1.5];
        }
        else if (infn6.data.length == 0)
        {
            [SVProgressHUD showErrorWithStatus:@"后台未传手机号"];
            [self performSelector:@selector(NoDiss) withObject:self afterDelay:1.5];
        }
        else
        {
            //我是工人校验判断
            [self postUrl];
        }
    }
    else
    {
        if (infn0.data.length == 0)
        {
            [SVProgressHUD showErrorWithStatus:@"请输入姓名"];
            [self performSelector:@selector(NoDiss) withObject:self afterDelay:1.5];
        }
        else if (infn2.data.length == 0)
        {
            [SVProgressHUD showErrorWithStatus:@"请输入身份证号"];
            [self performSelector:@selector(NoDiss) withObject:self afterDelay:1.5];
        }
        else if (infn3.data.length == 0)
        {
            [SVProgressHUD showErrorWithStatus:@"请选择先居住地"];
            [self performSelector:@selector(NoDiss) withObject:self afterDelay:1.5];
        }
        else if (infn4.data.length == 0)
        {
            [SVProgressHUD showErrorWithStatus:@"请编辑详细地址"];
            [self performSelector:@selector(NoDiss) withObject:self afterDelay:1.5];
        }
        else if (infn5.data.length == 0)
        {
            [SVProgressHUD showErrorWithStatus:@"请输入个人简介"];
            [self performSelector:@selector(NoDiss) withObject:self afterDelay:1.5];
        }
        else if (infn5.data.length == 0)
        {
            [SVProgressHUD showErrorWithStatus:@"请输入个人简介"];
            [self performSelector:@selector(NoDiss) withObject:self afterDelay:1.5];
        }
        else if (infn6.data.length == 0)
        {
            [SVProgressHUD showErrorWithStatus:@"后台未传手机号"];
            [self performSelector:@selector(NoDiss) withObject:self afterDelay:1.5];
        }
        else
        {
            //我不是工人编辑校验
            [self postUrl];
        }
    }

}


//网络请求
- (void)postUrl
{
    NSMutableArray *postArray = [NSMutableArray array];
    
    for (int i = 0; i < writeArray.count; i++)
    {
        PersonDataClass *data = [writeArray objectAtIndex:i];
        
        NSDictionary *dic = [myselfway entityToDictionary:data];
        
        if (i == 8)
        {
            NSArray *arr = data.workerArray;
            
            [postArray addObject:arr];
        }
        
        [postArray addObject:dic];
    }
    
    
    [self postInfoData];
    
}





- (void)NoDiss
{
    [SVProgressHUD dismiss];
}

//更换头像的点击事件
- (void)ImageBtn
{
    [self addimage];
}




//信息预览等点击事件的代理方法
- (void)tempval: (NSInteger)type
{
    //通过tag改变字体的颜色
    UILabel *label1 = [self.view viewWithTag:600];
    UILabel *label2 = [self.view viewWithTag:601];
    UILabel *label3 = [self.view viewWithTag:602];
    
        if (type == 500)
        {
            label1.textColor = [UIColor redColor];
            label2.textColor = [UIColor grayColor];
            label3.textColor = [UIColor grayColor];
            
            [dataArray removeAllObjects];
            
            typeInfo = 0;
            
            [self initUiData];
            
            [self.tableview reloadData];
        }
        else
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否修改您的个人信息" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            UIAlertAction *okaction = [UIAlertAction actionWithTitle:@"确认修改" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                                       {
                                           label1.textColor = [UIColor grayColor];
                                           label2.textColor = [UIColor redColor];
                                           label3.textColor = [UIColor grayColor];
                                           
                                           [writeArray removeAllObjects];
                                           
                                           typeInfo = 1;
                                           
                                           [self initEditData];
                                           
                                           [self.tableview reloadData];
                                           
                                       }];
            
            
            
            [alertController addAction:cancelAction];
            [alertController addAction:okaction];
            
            
            [self presentViewController:alertController animated:YES completion:nil];
        }
    
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
    info0.data = model.u_true_name;
    [dataArray addObject:info0];
    
    PersonDataClass *info1 = [[PersonDataClass alloc] init];
    info1.typeInf = 0;
    info1.name = @"性别:";
    
    if ([model.u_sex isEqualToString:@"0"])
    {
        info1.data = @"女";
    }
    else if([model.u_sex isEqualToString:@"1"])
    {
        info1.data = @"男";
    }
    else
    {
        info1.data = @"";
    }
    
    [dataArray addObject:info1];

    
    PersonDataClass *info3 = [[PersonDataClass alloc] init];
    info3.typeInf = 0;
    info3.name = @"身份证号:";
    info3.data = model.u_idcard;
    [dataArray addObject:info3];
    
    PersonDataClass *info4 = [[PersonDataClass alloc] init];
    info4.typeInf = 0;
    info4.name = @"现居住地:";
    info4.data = addmodel.user_area_name;
    [dataArray addObject:info4];
    
    
    PersonDataClass *info99 = [[PersonDataClass alloc] init];
    info99.typeInf = 0;
    info99.name = @"详细地址:";
    info99.data = addmodel.uei_address;
    [dataArray addObject:info99];
    
    
    
    PersonDataClass *info5 = [[PersonDataClass alloc] init];
    info5.typeInf = @"1";
    info5.name = @"个人简介:";
    info5.data = model.u_info;
    [dataArray addObject:info5];
    
    
    
    PersonDataClass *info6 = [[PersonDataClass alloc] init];
    info6.typeInf = 0;
    info6.name = @"电话号:";
    info6.data = model.u_mobile;
    [dataArray addObject:info6];
    
    
    PersonDataClass *info7 = [[PersonDataClass alloc] init];
    info7.typeInf = 0;
    info7.name = @"角色选择:";
    
    
    
    if ([model.u_skills isEqualToString:@",,"] || [model.u_skills isEqualToString:@""] || [model.u_skills isEqualToString:@"0"])
    {
        info7.data = @"我不是工人";
    }
    else
    {
        info7.data = @"我是工人";
    }
    
    [dataArray addObject:info7];
    
    

    PersonDataClass *info8 = [[PersonDataClass alloc] init];
    
    if ([model.u_skills isEqualToString:@",,"] || [model.u_skills isEqualToString:@""])
    {
        //我不是工人
        info8.workerArray = Warr;
        
    }
    else
    {
        //我是工人
        NSArray *array = [model.u_skills componentsSeparatedByString:@","];
        
        [chineseWorker removeAllObjects];
        
        for (int i = 0; i < workerPer.count; i++)
        {
            workerPerData *data = [workerPer objectAtIndex:i];
            
            for (int j = 0; j < array.count; j++)
            {
                NSString *str = [array objectAtIndex:j];
                
                if ([str isEqualToString:data.s_id])
                {
                    [chineseWorker addObject:data.s_name];
                }
            }
            
        }
        
        info8.workerArray = chineseWorker;
        
    }
    
    
    info8.typeInf = @"2";
    
    
    [dataArray addObject:info8];
    
    [self.tableview reloadData];
    
}


//制作编辑信息的数据
- (void)initEditData
{
    
    level1 = addmodel.uei_province;
    level2 = addmodel.uei_city;
    level3 = addmodel.uei_area;
    
    
    
    PersonDataClass *info0 = [[PersonDataClass alloc] init];
    info0.typeInf = 0;
    info0.name = @"姓名:";
    info0.placehold = @"请输入姓名";
    info0.data = model.u_true_name;
    [writeArray addObject:info0];
    
    PersonDataClass *info1 = [[PersonDataClass alloc] init];
    info1.typeInf = @"1";
    info1.name = @"性别:";
    
    if ([model.u_sex isEqualToString:@"0"])
    {
        info1.data = @"女";
    }
    else
    {
        info1.data = @"男";
    }
    
    [writeArray addObject:info1];
    
    
    PersonDataClass *info3 = [[PersonDataClass alloc] init];
    info3.typeInf = 0;
    info3.name = @"身份证号:";
    info3.data = model.u_idcard;
    info3.placehold = @"输入身份证号";
    [writeArray addObject:info3];
    
    PersonDataClass *info4 = [[PersonDataClass alloc] init];
    info4.typeInf = @"2";
    info4.name = @"现居住地:";
    info4.data = addmodel.user_area_name;
    info4.placehold = @"点击选择";
    [writeArray addObject:info4];
    
    
    PersonDataClass *info99 = [[PersonDataClass alloc] init];
    info99.typeInf = 0;
    info99.name = @"详细地址:";
    info99.data = addmodel.uei_address;
    [writeArray addObject:info99];
    
    
    PersonDataClass *info5 = [[PersonDataClass alloc] init];
    info5.typeInf = @"3";
    info5.name = @"个人简介:";
    info5.data = model.u_info;
    info5.placehold = @"请简要描述自己";
    [writeArray addObject:info5];
    
    
    PersonDataClass *info6 = [[PersonDataClass alloc] init];
    info6.typeInf = 0;
    info6.name = @"电话号:";
    info6.data = model.u_mobile;
    info6.placehold = @"请填写绑定手机号";
    [writeArray addObject:info6];
    
    
    PersonDataClass *info7 = [[PersonDataClass alloc] init];
    info7.typeInf = @"4";
    info7.name = @"角色选择:";
    if ([model.u_skills isEqualToString:@",,"] || [model.u_skills isEqualToString:@""] || [model.u_skills isEqualToString:@"0"])
    {
        info7.data = @"我不是工人";
        
        xianzhiCount = 0;
    }
    else
    {
        info7.data = @"我是工人";
        
        xianzhiCount = 1;
    }
    
    [writeArray addObject:info7];
    
    
    if ([info7.data isEqualToString:@"我是工人"])
    {

            PersonDataClass *info8 = [[PersonDataClass alloc] init];
            info8.workerArray = chineseWorker;
            info8.typeInf = @"5";
            
            [writeArray addObject:info8];
            
            
            PersonDataClass *info9 = [[PersonDataClass alloc] init];
            
            info9.typeInf = @"6";
            
            [writeArray addObject:info9];
            
            [self.tableview reloadData];
            

    }
    
    
}


//添更换头像按钮
- (void)addimage
{
    
    UIAlertController *Alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [Alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action)
                      {
                          
                      }]];
    [Alert addAction:[UIAlertAction actionWithTitle:@"从相册选择图片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                      {
                          UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
                          imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                          imagePicker.delegate = self;
                          imagePicker.allowsEditing = YES;
                          [imagePicker.navigationBar setBackgroundImage:[UIImage imageNamed:@"NavBar1"] forBarMetrics:UIBarMetricsDefault];
                          
                          [self presentViewController:imagePicker animated:YES completion:nil];
                      }]];
    
    [Alert addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                      {
                          if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
                          {
                              UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
                              imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                              imagePicker.delegate = self;
                              imagePicker.allowsEditing = YES;
                              [self presentViewController:imagePicker animated:YES completion:nil];
                          }
                          else
                          {
                              UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"未检测到摄像头" delegate:nil cancelButtonTitle:nil                                                 otherButtonTitles:@"确定", nil];
                              [alert show];
                          }
                      }]];
    
    [self presentViewController:Alert animated:YES completion:nil];
    
}

//照相完，使用相片所走的方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    [self imageData:image];
    
}


//点击取消所走的方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}




- (void)imageData:(UIImage *)ima
{
    NSData *data = UIImageJPEGRepresentation(ima, 1.0);
    
    NSString *pictureDataString = [data base64EncodedStringWithOptions:0];   //data转base64
    
    NSString *houzhui = [self contentTypeForImageData:data];

    NSString *geshi = [houzhui substringFromIndex:6];//截取掉下标7之前的字符串

    NSString *end = [NSString stringWithFormat:@"123.%@", geshi];
    
    NSString *url = [NSString stringWithFormat:@"%@Users/usersHeadEidt?u_id=%@&img_name=%@", baseUrl, user_ID, end];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSDictionary *dic = @{@"base64": pictureDataString};
    
    [manager POST:url parameters:dic success:^(NSURLSessionDataTask *task, id responseObject)
    {
        
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        if ([[dictionary objectForKey:@"code"] integerValue] == 1)
        {
            Hview.Icon.image = ima;
            
            //将头像转成data存到本地，我的页面显示
            NSData *imageData = UIImagePNGRepresentation(ima);
            
            [[NSUserDefaults standardUserDefaults] setObject:imageData forKey:@"imaData"];
            
        }
        else
        {
            NSDictionary *dic = [dictionary objectForKey:@"data"];
            
            [SVProgressHUD showInfoWithStatus:[dic objectForKey:@"msg"]];
        }
        
    }
    failure:^(NSURLSessionDataTask *task, NSError *error)
    {
        [SVProgressHUD showInfoWithStatus:@"头像上传失败，请检查网络"];
    }];
     
    [self dismissViewControllerAnimated:YES completion:nil];
    
}





//图片转二进制，获取图片格式
- (NSString *)contentTypeForImageData:(NSData *)data
{
    uint8_t c;
    [data getBytes:&c length:1];
    
    switch (c) {
        case 0xFF:
            return @"image/jpeg";
        case 0x89:
            return @"image/png";
        case 0x47:
            return @"image/gif";
        case 0x49:
            break;
        case 0x42:
            return @"image/bmp";
        case 0x4D:
            return @"image/tiff";
    }
    return nil;
}



//用户信息网络请求
- (void)getinfoData
{
    NSString *url = [NSString stringWithFormat:@"%@Users/usersInfo?u_id=%@", baseUrl, user_ID];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject)
    {
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        if ([[dictionary objectForKey:@"code"] integerValue] == 1)
        {
            NSDictionary *dic = [dictionary objectForKey:@"data"];
            
            NSDictionary *dicData = [dic objectForKey:@"data"];
            
            model = [[UserInfoModel alloc] init];
            
            model.u_id = [dicData objectForKey:@"u_id"];
            model.u_name = [dicData objectForKey:@"u_name"];
            model.u_mobile = [dicData objectForKey:@"u_mobile"];
            model.u_phone = [dicData objectForKey:@"u_phone"];
            model.u_sex = [dicData objectForKey:@"u_sex"];
            model.u_in_time = [dicData objectForKey:@"u_in_time"];
            model.u_online = [dicData objectForKey:@"u_online"];
            model.u_status = [dicData objectForKey:@"u_status"];
            model.u_type = [dicData objectForKey:@"u_type"];
            model.u_task_status = [dicData objectForKey:@"u_task_status"];
            model.u_skills = [dicData objectForKey:@"u_skills"];
            model.u_start = [dicData objectForKey:@"u_start"];
            model.u_credit = [dicData objectForKey:@"u_credit"];
            model.u_top = [dicData objectForKey:@"u_top"];
            model.u_recommend = [dicData objectForKey:@"u_recommend"];
            model.u_jobs_num = [dicData objectForKey:@"u_jobs_num"];
            model.u_worked_num = [dicData objectForKey:@"u_worked_num"];
            model.u_high_opinions = [dicData objectForKey:@"u_high_opinions"];
            model.u_low_opinions = [dicData objectForKey:@"u_low_opinions"];
            model.u_middle_opinions = [dicData objectForKey:@"u_middle_opinions"];
            model.u_dissensions = [dicData objectForKey:@"u_dissensions"];
            model.u_true_name = [dicData objectForKey:@"u_true_name"];
            model.u_idcard = [dicData objectForKey:@"u_idcard"];
            model.u_info = [dicData objectForKey:@"u_info"];
            model.u_img = [dicData objectForKey:@"u_img"];
            model.uei_province = [dicData objectForKey:@"uei_province"];
            model.uei_city = [dicData objectForKey:@"uei_city"];
            model.uei_area = [dicData objectForKey:@"uei_area"];
            model.uei_address = [dicData objectForKey:@"uei_address"];
            
            
            
            model.area = [dicData objectForKey:@"area"];
            
            addmodel = [[UserAdreeData alloc] init];
            
            addmodel.uei_info = [model.area objectForKey:@"uei_info"];
            addmodel.uei_province = [model.area objectForKey:@"uei_province"];
            addmodel.uei_city = [model.area objectForKey:@"uei_city"];
            addmodel.uei_area = [model.area objectForKey:@"uei_area"];
            addmodel.uei_address = [model.area objectForKey:@"uei_address"];
            addmodel.user_area_name = [model.area objectForKey:@"user_area_name"];
            
            
            [self initUiData];
            
        }
        
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error)
    {
        
    }];
    
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
                 
                 workerPerData *data = [[workerPerData alloc] init];
                 
                 data.s_id = [dic objectForKey:@"s_id"];
                 data.s_desc = [dic objectForKey:@"s_desc"];
                 data.s_info = [dic objectForKey:@"s_info"];
                 data.s_name = [dic objectForKey:@"s_name"];
                 data.s_status = [dic objectForKey:@"s_status"];
                 
                 [workerPer addObject:data];
                 
                 
             }
             
             
             [self getinfoData];   //网络请求用户信息
             
         }
         
         
         
     } failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         
     }];
    
    
}




//用户信息修改上传接口
- (void)postInfoData
{
    PersonDataClass *data = [writeArray objectAtIndex:0];
    NSString *name = data.data;

    NSString *sex;
    PersonDataClass *data1 = [writeArray objectAtIndex:1];
    if ([data1.data isEqualToString:@"男"])
    {
        sex = @"1";
    }
    else
    {
        sex = @"0";
    }
    

    PersonDataClass *data2 = [writeArray objectAtIndex:2];
    NSString *card = data2.data;


    PersonDataClass *data3 = [writeArray objectAtIndex:3];
    NSString *adree = data3.data;

    
    PersonDataClass *data99 = [writeArray objectAtIndex:4];
    NSString *hukou = data99.data;

    PersonDataClass *data4 = [writeArray objectAtIndex:5];
    NSString *text = data4.data;

    PersonDataClass *data5 = [writeArray objectAtIndex:6];
    NSString *iphone = data5.data;

    
    
    NSString *worker_Di = @"";   //工种ID   字符串
    
    if (writeArray.count == 10)
    {
        PersonDataClass *data6 = [writeArray objectAtIndex:7];
        NSString *isWorker = data6.data;
        
        
        PersonDataClass *data7 = [writeArray objectAtIndex:8];
        NSArray *workerArr = data7.workerArray;
        
        NSMutableArray *numArr = [NSMutableArray array];
        
        for (int i = 0; i < workerPer.count; i++)
        {
            workerPerData *data = [workerPer objectAtIndex:i];
            
            for (int j = 0; j < workerArr.count; j++)
            {
                NSString *str = [workerArr objectAtIndex:j];
                
                if ([str isEqualToString:data.s_name])
                {
                    [numArr addObject:data.s_id];
                }
                
            }
            
        }
        
        //获取工种ID
        worker_Di = [numArr componentsJoinedByString:@","];
        
    }

    
    
    //省市区ID为空的判断
    if (level1 == nil)
    {
        level1 = @"0";
    }
    
    if (level2 == nil)
    {
        level2 = @"0";
    }
    
    if (level3 == nil)
    {
        level3 = @"0";
    }
    
    NSString *url = [NSString stringWithFormat:@"%@%@", baseUrl, @"Users/usersInfoEdit"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSDictionary *infoData = @{@"u_id": user_ID,
                               @"u_true_name": name,
                               @"u_sex": sex,
                               @"u_idcard": card,
                               @"uei_info": text,
                               @"u_phone": iphone,
                               @"u_skills": worker_Di,
                               @"uei_address": hukou,
                               @"uei_province": level1,
                               @"uei_city": level2,
                               @"uei_area": level3
                               };
    
    
    [manager POST:url parameters:infoData success:^(NSURLSessionDataTask *task, id responseObject)
     {
         NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         
         if ([[dictionary objectForKey:@"code"] integerValue] == 1)
         {
             
             NSDictionary *dic = [dictionary objectForKey:@"data"];
             
         
             [[NSUserDefaults standardUserDefaults] setObject:name forKey:@"u_name"];
             [[NSUserDefaults standardUserDefaults] setObject:sex forKey:@"u_sex"];
             
             [[NSUserDefaults standardUserDefaults] setObject:card forKey:@"u_idcard"];
             
             [SVProgressHUD showInfoWithStatus:[dic objectForKey:@"msg"]];
             
             
             
             
             
    
             [self.navigationController popViewControllerAnimated:YES];
             
             [self performSelector:@selector(deleteBtn) withObject:self afterDelay:1.5];
             
         }
             
             
             
    } failure:^(NSURLSessionDataTask *task, NSError *error)
     {
        
    }];
    
    
}


- (void)deleteBtn
{
    [SVProgressHUD dismiss];
}



//没用的代理方法
- (void)tempCityNum: (NSString *)city_id city_name:(NSString *)name
{
    
}


//获取省市区ID 代理
- (void)post3Level: (NSString *)city_id1 city_name1:(NSString *)name city_id2:(NSString *)city_id city_name2:(NSString *)city_name2 city_id2:(NSString *)city_id2 city_name3:(NSString *)city_name3
{
    
    level1 = city_id1;
    level2 = city_id;
    level3 = city_id2;
    
    NSString *cityName = [NSString stringWithFormat:@"%@-%@-%@", name, city_name2, city_name3];
    
    
    PersonDataClass *data = [writeArray objectAtIndex:3];
    
    data.data = cityName;
    
    [self.tableview reloadData];
    
}


- (void)viewWillAppear:(BOOL)animated
{
    //获取缓存图片的大小(字节)
    NSUInteger bytesCache = [[SDImageCache sharedImageCache] getSize];
    
    //换算成 MB (注意iOS中的字节之间的换算是1000不是1024)
    float MBCache = bytesCache/1000/1000;
    
    //异步清除图片缓存 （磁盘中的）
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        [[SDImageCache sharedImageCache] clearDisk];
    });
}


@end
