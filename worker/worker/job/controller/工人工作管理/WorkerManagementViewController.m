//
//  WorkerManagementViewController.m
//  worker
//
//  Created by 郭健 on 2017/8/8.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "WorkerManagementViewController.h"
#import "TypeView.h"
#import "OneTableViewCell.h"

@interface WorPerDataModel : NSObject

@property (nonatomic, strong)NSString *t_id;
@property (nonatomic, strong)NSString *t_title;
@property (nonatomic, strong)NSString *t_info;
@property (nonatomic, strong)NSString *t_amount;
@property (nonatomic, strong)NSString *t_duration;
@property (nonatomic, strong)NSString *t_edit_amount;
@property (nonatomic, strong)NSString *t_amount_edit_times;
@property (nonatomic, strong)NSString *t_posit_x;
@property (nonatomic, strong)NSString *t_posit_y;
@property (nonatomic, strong)NSString *t_author;
@property (nonatomic, strong)NSString *t_in_time;
@property (nonatomic, strong)NSString *t_last_edit_time;
@property (nonatomic, strong)NSString *t_last_editor;
@property (nonatomic, strong)NSString *t_status;
@property (nonatomic, strong)NSString *t_phone;
@property (nonatomic, strong)NSString *t_phone_status;
@property (nonatomic, strong)NSString *t_type;
@property (nonatomic, strong)NSString *t_storage;
@property (nonatomic, strong)NSString *bd_id;


@end


@implementation WorPerDataModel


@end

@interface WorkerManagementViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *dataArray;
    
    TypeView *typeView;  //上面选择类型的view
    
    NSMutableArray *nameArr;   //类型上的view名字数组,传给自定义view
}


@property (nonatomic, strong)UITableView *tableview;

@end

@implementation WorkerManagementViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    dataArray = [NSMutableArray array];
    
    
    nameArr = [NSMutableArray arrayWithObjects:@"全部", @"进行中", @"已结束", nil];
    
    
    [self addhead:@"工人工作管理"];
    
    [self slitherBack:self.navigationController];
    
    [self tableview];
    
    [self initTypeView];
    
    
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
        
        [_tableview mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.top.mas_equalTo(self.view).offset(84 + StatusBarHeigh);
             make.left.mas_equalTo(self.view).offset(0);
             make.right.mas_equalTo(self.view).offset(0);
             make.bottom.mas_equalTo(self.view).offset(SCREEN_HEIGHT - 84 - StatusBarHeigh);
         }];
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
    WorPerDataModel *model = [dataArray objectAtIndex:indexPath.section];
    
    OneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    [cell.favoriteBtn addTarget:self action:@selector(favoriteBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.favoriteBtn.hidden = YES;
    
    cell.details.hidden = YES;
    
    cell.title.text = model.t_title;
    cell.introduce.text = model.t_info;
    
    
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
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    
    return view;
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
    else
    {
        NSLog(@"3");
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






//任务数据网络请求
- (void)getdata: (NSString *)t_status
{
    NSString *url;
    
    //工人工作管理
    
    url = [NSString stringWithFormat:@"%@Tasks/index?t_author=%@&t_status=%@", baseUrl, @"2", t_status];
    
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject)
     {
         NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         
         if ([[dictionary objectForKey:@"code"] integerValue] == 200)
         {
             NSArray *tem = [dictionary objectForKey:@"data"];
             
             [dataArray removeAllObjects];
             
             for (int i = 0; i < tem.count; i++)
             {
                 NSDictionary *dic = [tem objectAtIndex:i];
                 
                 WorPerDataModel *model = [[WorPerDataModel alloc] init];
                 
                 model.t_id = [dic objectForKey:@"t_id"];
                 model.t_title = [dic objectForKey:@"t_title"];
                 model.t_info = [dic objectForKey:@"t_info"];
                 model.t_amount = [dic objectForKey:@"t_amount"];
                 model.t_duration = [dic objectForKey:@"t_duration"];
                 model.t_edit_amount = [dic objectForKey:@"t_edit_amount"];
                 model.t_amount_edit_times = [dic objectForKey:@"t_amount_edit_times"];
                 model.t_posit_x = [dic objectForKey:@"t_posit_x"];
                 model.t_posit_y = [dic objectForKey:@"t_posit_y"];
                 model.t_author = [dic objectForKey:@"t_author"];
                 model.t_in_time = [dic objectForKey:@"t_in_time"];
                 model.t_last_edit_time = [dic objectForKey:@"t_last_edit_time"];
                 model.t_last_editor = [dic objectForKey:@"t_last_editor"];
                 model.t_status = [dic objectForKey:@"t_status"];
                 model.t_phone = [dic objectForKey:@"t_phone"];
                 model.t_phone_status = [dic objectForKey:@"t_phone_status"];
                 model.t_type = [dic objectForKey:@"t_type"];
                 model.bd_id = [dic objectForKey:@"bd_id"];
                 
                 [dataArray addObject:model];
                 
             }
             
             
             [self.tableview reloadData];
         }
         
         
         
     } failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         
     }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
