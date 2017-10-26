//
//  IndentViewController.m
//  worker
//
//  Created by sd on 2017/10/13.
//  Copyright © 2017年 郭健. All rights reserved.
//


#import "IndentViewController.h"
#import "lssueUserTableViewCell.h"
#import "BriefTableViewCell.h"
#import "elsepersonTableViewCell.h"
#import "elsetimeTableViewCell.h"
#import "elseDelegateTableViewCell.h"
#import "NormalTableViewCell.h"
#import "ThreeCityViewController.h"
#import "indent.h"
#import "PreviewTableViewCell.h"
#import "PriceTableview.h"
#import "SYPasswordView.h"

@interface threModel : selecdType

@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSString *data;

@end


@implementation threModel


@end



@interface fouModel : selecdType

@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSString *nameNum;

@property (nonatomic, strong)NSString *mongey;
@property (nonatomic, strong)NSString *moneyNum;

@end


@implementation fouModel


@end




@interface IndentViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSString *password;    //提现密码
    
    UIView *Passwordview;   //支付密码的view
    UIControl *cor;   //背景
    
    
    
    NSMutableArray *dataArray;
    
    UIControl *backControl;
    
    UIWindow *window;
    
    NSMutableArray *new;
    
    NSDictionary *dicAll;
}

@property (nonatomic, strong)PriceTableview *priceTable;

@property (nonatomic, strong)UITableView *tableview;

@property (nonatomic, strong)UIWindow *window;

@property (nonatomic, strong)SYPasswordView *pasView;

@end

@implementation IndentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view
    
    window = [[UIApplication sharedApplication] keyWindow];
    
    dataArray = [NSMutableArray arrayWithArray:self.modelArray];
    
 //   [self initMoney];
    [self passworkPost];
    
    [self initData];
    
    [self addhead:@"任务确认"];
    
    [self tableview];
    
    [self initbackCon];
    
    [self priceTable];
    

    [self postData];
    
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
        [_tableview registerClass:[PreviewTableViewCell class] forCellReuseIdentifier:@"1111cell"];
        
        [_tableview registerClass:[elsepersonTableViewCell class] forCellReuseIdentifier:@"elseperson"];
        [_tableview registerClass:[elsetimeTableViewCell class] forCellReuseIdentifier:@"elsetime"];
        [_tableview registerClass:[elseDelegateTableViewCell class] forCellReuseIdentifier:@"deletecell"];
        [_tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"2cell"];
        
        
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
    
    if([data.bigType isEqualToString:@"1"])
    {
        firstModel *model = (firstModel *)data;
        
        if ([model.type isEqualToString:@"1"])
        {
            //简介的cell
            BriefTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"briefcell"];
            
            cell.name.font = [UIFont systemFontOfSize:15];
            cell.data.font = [UIFont systemFontOfSize:15];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.name.text = model.name;
            cell.data.text = model.data;
            
            cell.data.editable = NO;
            
            return cell;
        }
        else
        {
            //正常的cell
            PreviewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"1111cell"];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.name.font = [UIFont systemFontOfSize:15];
            cell.data.font = [UIFont systemFontOfSize:15];
            
            cell.name.text = model.name;
            cell.data.text = model.data;
            
            cell.data.textColor = [UIColor blackColor];
            
            return cell;
        }
        
    }
    else if ([data.bigType isEqualToString:@"10"])
    {
        threModel *info = (threModel *)data;
        
        PreviewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"1111cell"];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        cell.name.font = [UIFont systemFontOfSize:15];
        cell.data.font = [UIFont systemFontOfSize:15];
        
        cell.name.text = info.name;
        
        cell.data.textAlignment = NSTextAlignmentLeft;
        
        cell.data.text = info.data;
        
        return cell;
    }
    
    else if([data.bigType isEqualToString:@"11"])
    {
        
        fouModel *model = (fouModel *)data;
        
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        if (!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"2cell"];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            UILabel *top = [[UILabel alloc] init];
            top.textAlignment = NSTextAlignmentRight;
            top.text = model.name;
            top.font = [UIFont systemFontOfSize:15];
            [cell addSubview:top];
            
            [top mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(cell).offset(-20);
                make.top.mas_equalTo(cell).offset(5);
                make.width.mas_equalTo(200);
                make.height.mas_equalTo(20);
            }];
            
            UILabel *bootm = [[UILabel alloc] init];
            bootm.textAlignment = NSTextAlignmentRight;
            bootm.text = model.mongey;
            bootm.textColor = [UIColor redColor];
            bootm.font = [UIFont systemFontOfSize:16];
            [cell addSubview:bootm];
            
            [bootm mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(cell).offset(-20);
                make.top.mas_equalTo(top).offset(25);
                make.width.mas_equalTo(200);
                make.height.mas_equalTo(20);
            }];
            
            
        }
        
        return cell;
    }
    else
    {
        elseModel *info = (elseModel *)data;

        if ([info.workerType isEqualToString:@"0"])     //招聘工种cell
        {
            //正常的cell
            PreviewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"1111cell"];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.name.text = @"招聘工种:";
            
            cell.name.font = [UIFont systemFontOfSize:15];
            cell.data.font = [UIFont systemFontOfSize:15];
            
            
            cell.data.text = info.placeData;
            
            cell.data.textColor = [UIColor blackColor];
            
            return cell;
            
        }
        else if ([info.workerType isEqualToString:@"1"])   //工人数量cell
        {
            elsepersonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"elseperson"];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.personfield.text = info.personNum;
            cell.moneyfield.text = info.money;
            
            cell.personfield.enabled = NO;
            cell.moneyfield.enabled = NO;
          
            return cell;
        }
        else if ([info.workerType isEqualToString:@"3"])
        {
            PreviewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"1111cell"];
            
            
            
            cell.clipsToBounds = YES;
            
            
            return cell;
        }
        else    //工期的cell
        {
            elsetimeTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            
            if (!cell)
            {
                cell = [[elsetimeTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"elsetime"];
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                
                cell.startTime.text = info.startTime;
                cell.endTime.text = info.endTime;
                
                cell.startTime.enabled = NO;
                cell.endTime.enabled = NO;
                
            }
            
            return cell;
        }
       
    
    }
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *arr = [dataArray objectAtIndex:indexPath.section];
    
    selecdType *data = [arr objectAtIndex:indexPath.row];

    if ([data.bigType isEqualToString:@"10"])
    {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        backControl.hidden = NO;
        _priceTable.hidden = NO;
        
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
    else if ([data.bigType isEqualToString:@"11"])
    {
        return 60;
    }
    else if ([data.bigType isEqualToString:@"10"])
    {
        return 40;
    }
    else
    {
        elseModel *info = (elseModel *)data;
        
        if ([info.workerType isEqualToString:@"3"])
        {
            return 0;
        }
        else
        {
            return 40;
        }
        
        
    }
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

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    
    return view;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    NSInteger count = dataArray.count;
    
    UIView *footview = [[UIView alloc] init];
    
    if (count - 1 == section)
    {
        UIButton *save = [UIButton buttonWithType:UIButtonTypeSystem];
        
        [save setTitle:@"确认支付" forState:UIControlStateNormal];
        
        [save addTarget:self action:@selector(zhifuBtn) forControlEvents:UIControlEventTouchUpInside];
        
        save.backgroundColor = [myselfway stringTOColor:@"0x2E84F8"];
        
        save.layer.cornerRadius = 5;
        
        save.frame = CGRectMake(15, 20, SCREEN_WIDTH - 30, 40);
        
        save.tintColor = [UIColor whiteColor];
        
        [footview addSubview:save];
    }
    
    
    return footview;
    
}







//确认支付按钮
- (void)zhifuBtn
{
    //支付
    [UIView animateWithDuration:0.5 animations:^{
        
        
        Passwordview.frame = CGRectMake(0, SCREEN_HEIGHT - 120 - 216, SCREEN_WIDTH, 120 + 216);
        cor.hidden = NO;
    } completion:^(BOOL finished) {
        [self.pasView.textField becomeFirstResponder];
    }];
    
    
   
}


//制作数据
- (void)initData
{
    
//    NSMutableArray *arr = [NSMutableArray array];
//
//    threModel *data = [[threModel alloc] init];
//
//    data.bigType = @"10";
//
//    data.name = @"优惠券:";
//    data.data = @"未使用优惠券";
//    
//    [arr addObject:data];
//
//    [dataArray addObject:arr];
    
    
    NSMutableArray *arr1 = [NSMutableArray array];
    
    fouModel *model = [[fouModel alloc] init];
    
    model.bigType = @"11";
    
    model.name = @"工程总价: 180";
    
    model.mongey = @"小计: 180";
    
    [arr1 addObject:model];
    
    [dataArray addObject:arr1];
    
    
}

//背景
- (void)initbackCon
{
    backControl = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, SCREEN_HEIGHT, SCREEN_HEIGHT)];
    backControl.hidden = YES;
    [backControl addTarget:self action:@selector(deletebtn) forControlEvents:UIControlEventTouchUpInside];
    backControl.backgroundColor = [UIColor colorWithWhite:0.7 alpha:0.5];
    [window addSubview:backControl];
    
    
}


//背景的点击事件
- (void)deletebtn
{
    backControl.hidden = YES;
    _priceTable.hidden = YES;
}



- (PriceTableview *)priceTable
{
    if (!_priceTable)
    {
        _priceTable = [[PriceTableview alloc] initWithFrame:CGRectMake(0, 150, SCREEN_WIDTH, SCREEN_HEIGHT - 300) style:UITableViewStyleGrouped];
        
        _priceTable.hidden = YES;
        
        [backControl addSubview:_priceTable];
        
        
        
    }
    

    return _priceTable;
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (void)postData
{
    NSString *url = [NSString stringWithFormat:@"%@Tasks/index?action=publish", baseUrl];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:url parameters:self.postDic success:^(NSURLSessionDataTask *task, id responseObject)
     {
         NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         
         if ([[dictionary objectForKey:@"code"] integerValue] == 200)
         {
          //   NSArray *arr = [dictionary objectForKey:@"data"];
             
            
             
         }
         
     } failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         
     }];
    
    
}


- (void)passworkPost
{
    _window = [[UIApplication sharedApplication] keyWindow];
    
    cor = [[UIControl alloc] init];
    cor.hidden = YES;
    
    cor.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [cor addTarget:self action:@selector(NOBtn) forControlEvents:UIControlEventTouchUpInside];
    
    cor.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    
    [_window addSubview:cor];
    
    
    Passwordview = [[UIView alloc] init];
    
    Passwordview.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 0);
    Passwordview.backgroundColor = [UIColor whiteColor];
    
    [cor addSubview:Passwordview];
    
    
    UILabel *titile = [[UILabel alloc] init];
    
    titile.text = @"请输入支付密码";
    titile.textAlignment = NSTextAlignmentCenter;
    titile.font = [UIFont systemFontOfSize:16];
    [Passwordview addSubview:titile];
    
    [titile mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(Passwordview).offset(7);
        make.centerX.mas_equalTo(Passwordview);
        make.width.mas_equalTo(250);
        make.height.mas_equalTo(25);
    }];
    
    
    //    UIView *line = [[UIView alloc] init];
    //    line.backgroundColor = [myselfway stringTOColor:@"0xF3F3F3"];
    //    [Passwordview addSubview:line];
    //
    //    [line mas_makeConstraints:^(MASConstraintMaker *make) {
    //
    //    }];
    
    
    self.pasView = [[SYPasswordView alloc] initWithFrame:CGRectMake(16, SCREEN_HEIGHT - 216 - 80, SCREEN_WIDTH - 32, 45)];
    
    self.pasView.delegate = self;
    
    [cor addSubview:self.pasView];
    
}





//关闭支付view
- (void)NOBtn
{
    [UIView animateWithDuration:0.5 animations:^{
        [self.pasView.textField resignFirstResponder];
        Passwordview.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 0);
        
        
    } completion:^(BOOL finished) {
        cor.hidden = YES;
        
    }];
}

//获取编辑密码的代理
- (void)password: (NSString *)num
{
    password = num;
    
     [self.postDic setValue:password forKey:@"u_pass"];
    //网络请求
    NSData *datainfo = [NSJSONSerialization dataWithJSONObject:self.postDic options:NSJSONWritingPrettyPrinted error:nil];
    
    
    NSString *getStr = [datainfo base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    NSDictionary *dicAll = @{@"data" : getStr};
    
    NSString *url = [NSString stringWithFormat:@"%@?action=publish", baseUrl];
    [self postRequestByServiceUrl:url andApi:nil andParams:dicAll andCallBack:^(id obj) {
        
        NSLog(@"%@", obj);
        
        if ([[obj objectForKey:@"code"] integerValue] == 200)
        {
            [SVProgressHUD showInfoWithStatus:[obj objectForKey:@"data"]];

        }
        
        
    }];
}


- (void)postRequestByServiceUrl:(NSString *)service
                         andApi:(NSString *)api
                      andParams:(NSDictionary *)params
                    andCallBack:(void (^)(id obj))callback
{
    // NSString *basePath = [service stringByAppendingString:api];
    
    NSURL *url = [NSURL URLWithString:service];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    NSString *body = [myselfway dealWithParam:params];
    NSData *bodyData = [body dataUsingEncoding:NSUTF8StringEncoding];
    
    // 设置请求体
    [request setHTTPBody:bodyData];
    
    // 设置本次请求的提交数据格式
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    // 设置本次请求请求体的长度(因为服务器会根据你这个设定的长度去解析你的请求体中的参数内容)
    [request setValue:[NSString stringWithFormat:@"%ld",bodyData.length] forHTTPHeaderField:@"Content-Length"];
    
    // 设置本次请求的最长时间
    request.timeoutInterval = 20;
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        if (dic) {
            callback(dic);
        }else
        {
            callback(error.description);
        }
    }];
    
    [task resume];
}

@end
