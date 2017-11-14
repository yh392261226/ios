//
//  RechargeViewController.m
//  worker
//
//  Created by 郭健 on 2017/8/7.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "RechargeViewController.h"
#import "RechargeTableViewCell.h"
#import "PayTableViewCell.h"
#import "HYBNetworking.h"
#import "NSString+MD5.h"


@interface RechangeType : NSObject

@property (nonatomic, strong)NSString *p_id;
@property (nonatomic, strong)NSString *p_type;
@property (nonatomic, strong)NSString *p_name;
@property (nonatomic, strong)NSString *p_info;
@property (nonatomic, strong)NSString *p_status;
@property (nonatomic, strong)NSArray *p_paras;
@property (nonatomic, strong)NSString *p_author;
@property (nonatomic, strong)NSString *p_last_editor;
@property (nonatomic, strong)NSString *p_last_edit_time;
@property (nonatomic, strong)NSString *p_default;


@end


@implementation RechangeType


@end



@implementation wechatGet


@end



@interface RechargeViewController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
{
    NSMutableArray *dataArray;
    
    
    NSMutableArray *nameArray;   
    NSMutableArray *imageArray;
    
    NSInteger paySelecd;   //判断选择支付方式
    
    NSString *money;  //编辑框的充值金额
    
    wechatGet *info;
    
    
    NSMutableDictionary *dictionWechat;   //微信支付的参数字典
}


@property (nonatomic, strong)UITableView *tableview;



@end

@implementation RechargeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    dictionWechat = [NSMutableDictionary dictionary];
    
    money = @"0";   //默认充值0元，不能往服务器传空
    
    paySelecd = 0;   //默认选择第一个
    
    dataArray = [NSMutableArray array];
    
    nameArray = [NSMutableArray array];
    
    imageArray = [NSMutableArray arrayWithObjects:@"job_wechat", @"job_alipay", nil];
    
    [self addhead:@"充值"];
    
    [self slitherBack:self.navigationController];
    
    [self postData];
    
    [self tableview];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getOrderPayResult:) name:@"ORDER_PAY_NOTIFICATION" object:nil];
}



- (void)temp
{
    [super temp];
    
    [self.delegate tempVaalllllll];
    
}



#pragma tableview 代理方法

- (UITableView *)tableview
{
    if (!_tableview)
    {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 65, SCREEN_WIDTH, SCREEN_HEIGHT - 65) style:UITableViewStyleGrouped];
        
        [_tableview registerClass:[RechargeTableViewCell class] forCellReuseIdentifier:@"firstCell"];
        [_tableview registerClass:[PayTableViewCell class] forCellReuseIdentifier:@"paycell"];
        
        _tableview.separatorStyle = NO;
        
        _tableview.backgroundColor = [myselfway stringTOColor:@"0xC4CED3"];
        
        _tableview.delegate = self;
        _tableview.dataSource = self;
        
        [self.view addSubview:_tableview];
        
    }
    
    
    
    
    return _tableview;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 1;
    }
    else
    {
        return nameArray.count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        RechargeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"firstCell"];
        
        [cell.textfield addTarget:self action:@selector(textFieldEditChanged:) forControlEvents:UIControlEventEditingChanged];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
   else
   {
       RechangeType *info1 = [nameArray objectAtIndex:indexPath.row];
       
       
       PayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"paycell"];
       
       cell.logoImage.image = [UIImage imageNamed:@"job_wechat"];
       
       cell.name.text = info1.p_name;
       
       cell.selecd.image = [UIImage imageNamed:@"job_back"];
       
       NSLog(@"%ld", indexPath.row);
       
       if (indexPath.row == paySelecd)
       {
           cell.selecd.image = [UIImage imageNamed:@"job_dd"];
       }
       
       
       return cell;
   }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return 40;
    }
    else
    {
        return 60;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    
    
    UILabel *name = [[UILabel alloc] init];
    
    if (section == 0)
    {
        name.text = @"充值金额";
        
        
    }
    else
    {
        name.text = @"支付方式";

    }
    
    name.textAlignment = NSTextAlignmentLeft;
    name.textColor = [UIColor grayColor];
    name.font = [UIFont systemFontOfSize:15];
    
    [view addSubview:name];
    
    
    [name mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.top.mas_equalTo(view).offset(5);
        make.height.mas_equalTo(20);
        make.left.mas_equalTo(view).offset(15);
        make.width.mas_equalTo(200);
    }];
    

    return view;
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 0.1;
    }
    else
    {
        return 40;
    }
    
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    
    if (section == 1)
    {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        button.tag = 400;
        
        button.backgroundColor = [myselfway stringTOColor:@"0x2E84F8"];
        
        [button setTitle:@"去支付" forState:UIControlStateNormal];
        
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        button.layer.cornerRadius = 5;
        
        [button addTarget:self action:@selector(payBtn) forControlEvents:UIControlEventTouchUpInside];
        
        [view addSubview:button];
        
        
        [button mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.top.mas_equalTo(view).offset(25);
            make.height.mas_equalTo(35);
            make.left.mas_equalTo(view).offset(30);
            make.right.mas_equalTo(view).offset(-30);
        }];
        
    }
    
    return view;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    

    if (indexPath.section == 1)
    {
        
        
        
        paySelecd = indexPath.row;
        
        
        
        [self.tableview reloadData];
        
    }
   
}




#pragma textfield的代理






//消键盘
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}


//获取充值金额数据
- (void)textFieldEditChanged:(UITextField *)textField
{
    money = textField.text;
    NSLog(@"textfield text %@",textField.text);
    
}


#pragma 自己定义的方法

//去支付按钮
- (void)payBtn
{
    
    RechangeType *data = [nameArray objectAtIndex:paySelecd];
    
    
    
    
    //获取后台返回的微信值
    [self wechatData:data.p_id];
    

}



//调起微信支付
- (void)wechatTemp
{
    //得到的微信支付后台生成预订单信息
    NSDictionary *dict = @{@"appid":info.appId,//APPID
                           @"noncestr":info.nonceStr,//随机字符串
                           @"package":@"Sign=WXPay",//固定值
                           @"partnerid":info.partnerid,//商户ID
                           @"prepayid":info.prepay_id,//支付订单号
                           @"timestamp":info.timeStamp,
                           };
    
    NSMutableString *contentString = [NSMutableString string];
    
    NSArray *keys = [dict allKeys];
    
    //按首字母排序
    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        
        return [obj1 compare:obj2 options:NSNumericSearch];
        
    }];
    
    //拼接字符串
    
    for (NSString *categoryId in sortedArray)
    {
        
        if (![[dict objectForKey:categoryId]isEqualToString:@""] && ![categoryId isEqualToString:@"sign"] && ![categoryId isEqualToString:@"key"])
        {
            
            //拼接的时候不要写错%@=%@& 少了&调起微信支付只会有一个确定按钮没有订单信息导致无法支付
            [contentString appendFormat:@"%@=%@&",categoryId,dict[categoryId]];
            
        }
        
    }
    
    
    NSString *endSign = [NSString stringWithFormat:@"%@key=gangjianwang1234567891234567891z", contentString];
    
    //加密生成字符串 MD5
    NSString *md5Sign = [self md5:endSign];
    
    //调起微信支付
    PayReq *req             = [[PayReq alloc] init];
    req.openID              = info.appId;
    req.partnerId           = [dict objectForKey:@"partnerid"];
    req.prepayId            = [dict objectForKey:@"prepayid"];
    req.nonceStr            = [dict objectForKey:@"noncestr"];
    
    NSString *stamp = info.timeStamp;
    
    req.timeStamp           = stamp.intValue;
    req.package             = [dict objectForKey:@"package"];
    req.sign                = md5Sign;
    
    
    [WXApi sendReq:req];

}




- (NSString *)md5:(NSString *)str
{
    
    const char *cStr = [str UTF8String];

    unsigned char digest[CC_MD5_DIGEST_LENGTH];

    CC_MD5(cStr,(unsigned int)strlen(cStr),digest);

    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];

    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
    {
        [output appendFormat:@"%02X",digest[i]];

    }
    
    return output;

}



#pragma mark - 收到支付成功的消息后作相应的处理
- (void)getOrderPayResult:(NSNotification *)notification
{
    BaseResp *resp =  notification.userInfo[@"ORDER_PAY_NOTIFICATION"];
    //支付返回结果，实际支付结果需要去微信服务器端查询
    NSString *strMsg;
    switch (resp.errCode) {
        case WXSuccess:
            strMsg = @"支付结果：成功！";
            [SVProgressHUD showInfoWithStatus:strMsg];
          
            break;
            
        default:
            strMsg = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
            [SVProgressHUD showInfoWithStatus:strMsg];
          
            break;
    }
    
}




//获取支付方式的列表
- (void)postData
{
    [SVProgressHUD showWithStatus:@"请等待..."];
    
    
    
    NSString *url = [NSString stringWithFormat:@"%@Payments/index?p_type=0", baseUrl];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject)
     {
         NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         
         if ([[dictionary objectForKey:@"code"] integerValue] == 200)
         {
             NSArray *dataArr = [dictionary objectForKey:@"data"];
             
             for (int i = 0; i < dataArr.count; i++)
             {
                 NSDictionary *dic = [dataArr objectAtIndex:i];
                 
                 RechangeType *data = [[RechangeType alloc] init];
                 
                 data.p_id = [dic objectForKey:@"p_id"];
                 data.p_type = [dic objectForKey:@"p_type"];
                 data.p_name = [dic objectForKey:@"p_name"];
                 data.p_info = [dic objectForKey:@"p_info"];
                 data.p_status = [dic objectForKey:@"p_status"];
                 data.p_paras = [dic objectForKey:@"p_paras"];
                 data.p_author = [dic objectForKey:@"p_author"];
                 data.p_last_editor = [dic objectForKey:@"p_last_editor"];
                 data.p_last_edit_time = [dic objectForKey:@"p_last_edit_time"];
                 data.p_default = [dic objectForKey:@"p_default"];
                 
                 [nameArray addObject:data];
                 
             }
             
             [self.tableview reloadData];
             
         }
         
         [SVProgressHUD dismiss];
        
         
     } failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         [SVProgressHUD dismiss];
     }];
    
}




//获取微信相关的参数
- (void)wechatData: (NSString *)p_id
{
    [SVProgressHUD showWithStatus:@"请等待..."];
    
    NSString *url = [NSString stringWithFormat:@"%@Users/applyRechargeLog?u_id=%@&p_id=%@&url_amount=%@", baseUrl, user_ID, p_id, money];
  
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    
    [manager POST:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject)
     {
         NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         
         if ([[dictionary objectForKey:@"code"] integerValue] == 1)
         {
             NSMutableDictionary *dicInfo = [dictionary objectForKey:@"data"];
             
             info = [[wechatGet alloc] init];
             
             info.appId = [dicInfo objectForKey:@"appId"];
             info.nonceStr = [dicInfo objectForKey:@"nonceStr"];
             info.package = [dicInfo objectForKey:@"package"];
             info.partnerid = [dicInfo objectForKey:@"partnerid"];
             info.prepay_id = [dicInfo objectForKey:@"prepay_id"];
             info.timeStamp = [dicInfo objectForKey:@"timeStamp"];
             info.paySign = [dicInfo objectForKey:@"paySign"];

             //调起微信支付
             [self wechatTemp];
             
         }
         
         
         [SVProgressHUD dismiss];
         
     } failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         [SVProgressHUD dismiss];
     }];
}













- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
