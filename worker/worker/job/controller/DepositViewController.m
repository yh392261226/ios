//
//  DepositViewController.m
//  worker
//
//  Created by 郭健 on 2017/9/5.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "DepositViewController.h"
#import "lssueUserTableViewCell.h"
#import "DepositTableViewCell.h"
#import "SYPasswordView.h"

@interface DepositModel : NSObject

@property (nonatomic, strong)NSString *p_id;
@property (nonatomic, strong)NSString *p_type;
@property (nonatomic, strong)NSString *p_name;
@property (nonatomic, strong)NSString *p_info;
@property (nonatomic, strong)NSString *p_status;
@property (nonatomic, strong)NSString *p_paras;
@property (nonatomic, strong)NSString *p_author;
@property (nonatomic, strong)NSString *p_last_editor;
@property (nonatomic, strong)NSString *p_last_edit_time;
@property (nonatomic, strong)NSString *p_default;


@end




@implementation DepositModel



@end


@interface DepositViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *dataArray;
    
    NSMutableArray *bankArray;
    
    NSString *name;       //姓名
    NSString *number;     //卡号
    NSString *money;      //银行
    
    NSString *bank;       //金额
    NSString *bank_ID;    //银行ID，  传给后台
    
    NSString *password;    //提现密码
    
    
    CGFloat height;   //键盘高度
    
    UIView *Passwordview;   //支付密码的view
    UIControl *cor;   //背景
    
}

@property (nonatomic, strong)UITableView *tableview;
@property (nonatomic, strong)UIWindow *window;

@property (nonatomic, strong)SYPasswordView *pasView;

@end

@implementation DepositViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self passworkPost];
    
    //增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWillShow:)
     
                                                 name:UIKeyboardWillShowNotification
     
                                               object:nil];
    
    bank = @"请选择银行";
    
    
    dataArray = [NSMutableArray array];
    bankArray = [NSMutableArray array];
    
    [self getdata];
    
    [self addhead:@"转到银行卡"];
    
    [self tableview];
    
    
    
    
    
    
}






- (void)keyboardWillShow:(NSNotification *)aNotification
{
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    CGRect keyboardRect = [aValue CGRectValue];
    
    height = keyboardRect.size.height;

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
    
    [Passwordview addSubview:self.pasView];
    
    [self.pasView mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.mas_equalTo(Passwordview).offset(40);
         make.left.mas_equalTo(Passwordview).offset(16);
         make.right.mas_equalTo(Passwordview).offset(-16);
         make.height.mas_equalTo(45);
     }];
    
}



//获取编辑密码的代理
- (void)password: (NSString *)num
{
    password = num;
    
    [self postData];
}



- (UITableView *)tableview
{
    if (!_tableview)
    {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 65, SCREEN_WIDTH, SCREEN_HEIGHT - 65) style:UITableViewStyleGrouped];
        
        _tableview.delegate = self;
        _tableview.dataSource = self;
        
        _tableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.1)];
        _tableview.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.1)];
        
        [_tableview registerClass:[lssueUserTableViewCell class] forCellReuseIdentifier:@"cell"];
        
        [_tableview registerClass:[DepositTableViewCell class] forCellReuseIdentifier:@"elsecell"];
        
        [self.view addSubview:_tableview];
        
    }
    
    return _tableview;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2)
    {
    
        DepositTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"elsecell"];
        
        cell.name.text = @"银行:";
        
        
        
        cell.data.text = bank;
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        
        return cell;
    }
    else
    {
        lssueUserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        
        [cell.data addTarget:self action:@selector(changeText:) forControlEvents:UIControlEventEditingChanged];
        
        cell.name.textAlignment = NSTextAlignmentCenter;
        
        cell.data.tag = indexPath.row + 900;
        
        if (indexPath.row == 0)
        {
            cell.name.text = @"姓名:";
            cell.data.placeholder = @"收款人姓名";
        }
        else if (indexPath.row == 1)
        {
            cell.name.text = @"卡号:";
            cell.data.keyboardType = UIKeyboardTypeNumberPad;
            cell.data.placeholder = @"收款人储蓄卡号";
        }
        else if (indexPath.row == 3)
        {
            cell.name.text = @"金额:";
            cell.data.keyboardType = UIKeyboardTypeNumberPad;
            cell.data.placeholder = @"";
        }
      
        
    
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        return cell;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 2)
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"请选择银行" preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *returnAlert = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        
        [alertController addAction:returnAlert];
        
        for (int i = 0; i < bankArray.count; i++)
        {
            DepositModel *model = [bankArray objectAtIndex:i];
            
            UIAlertAction *action = [UIAlertAction actionWithTitle:model.p_name style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                                     {
                                         bank = action.title;
                                     
                                         [self.tableview reloadData];
                                     }];
            
            [alertController addAction:action];
            
            
        }
        
        [self presentViewController:alertController animated:YES completion:nil];
        
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 70;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footview = [[UIView alloc] init];
    
        UIButton *save = [UIButton buttonWithType:UIButtonTypeSystem];
        
        [save setTitle:@"下一步" forState:UIControlStateNormal];
        
        [save addTarget:self action:@selector(Escbtn) forControlEvents:UIControlEventTouchUpInside];
        
        save.backgroundColor = [myselfway stringTOColor:@"0x2E84F8"];
        
        save.layer.cornerRadius = 5;
        
        save.frame = CGRectMake(20, 25, SCREEN_WIDTH - 40, 40);
        
        save.tintColor = [UIColor whiteColor];
        
        [footview addSubview:save];
        

    
    return footview;
}



//下一步按钮
- (void)Escbtn
{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    
    for (int j = 0; j < bankArray.count; j++)
    {
        DepositModel *model = [bankArray objectAtIndex:j];
        
        if ([model.p_name isEqualToString:bank])
        {
            bank_ID = model.p_id;
        }

    }
    
    
    
    
    if (name.length == 0)
    {
        [SVProgressHUD showErrorWithStatus:@"姓名未填写"];
    }
    else if (number.length == 0)
    {
        [SVProgressHUD showErrorWithStatus:@"卡号未填写"];
    }
    else if (money.length == 0)
    {
        [SVProgressHUD showErrorWithStatus:@"金额未填写"];
    }
    else
    {
        //成功
        
        [UIView animateWithDuration:0.5 animations:^{
            
            
            Passwordview.frame = CGRectMake(0, SCREEN_HEIGHT - 120 - 216, SCREEN_WIDTH, 120 + 216);
            cor.hidden = NO;
        } completion:^(BOOL finished) {
            [self.pasView.textField becomeFirstResponder];
        }];
        
        
    }
    
    [self performSelector:@selector(DatTime) withObject:self afterDelay:1.5];
    
}


- (void)DatTime
{
    [SVProgressHUD dismiss];
}


//获取textfield字段
- (void)changeText: (UITextField *)textfield
{
    if (textfield.tag == 900)
    {
        name = textfield.text;
    }
    else if (textfield.tag == 901)
    {
        number = textfield.text;
    }
    else
    {
        money = textfield.text;
    }
}







//体现列表获取
- (void)getdata
{
    NSString *url = [NSString stringWithFormat:@"%@Payments/index?p_type=1", baseUrl];

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject)
     {
         NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         
         if ([[dictionary objectForKey:@"code"] integerValue] == 200)
         {
             NSArray *tem = [dictionary objectForKey:@"data"];
             
             [bankArray removeAllObjects];
             
             for (int i = 0; i < tem.count; i++)
             {
                 NSDictionary *dic = [tem objectAtIndex:i];
                 
                 DepositModel *model = [[DepositModel alloc] init];
                 
                 model.p_id = [dic objectForKey:@"p_id"];
                 model.p_type = [dic objectForKey:@"p_type"];
                 model.p_name = [dic objectForKey:@"p_name"];
                 model.p_info = [dic objectForKey:@"p_info"];
                 model.p_status = [dic objectForKey:@"p_status"];
                 model.p_paras = [dic objectForKey:@"p_paras"];
                 model.p_author = [dic objectForKey:@"p_author"];
                 model.p_last_editor = [dic objectForKey:@"p_last_editor"];
                 model.p_last_edit_time = [dic objectForKey:@"p_last_edit_time"];
                 model.p_default = [dic objectForKey:@"p_default"];
        
                 [bankArray addObject:model];
                 
             }
             
             
             for (int i = 0; i < bankArray.count; i++)
             {
                 DepositModel *model = [bankArray objectAtIndex:i];
                 
                 if ([model.p_default isEqualToString:@"1"])
                 {
                     bank = model.p_name;
                 }
             }
             
             
             [self.tableview reloadData];
         }
         
     } failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         
     }];
    
}




//体现信息上传
- (void)postData
{

    NSString *url = [NSString stringWithFormat:@"%@Users/applyWithdraw", baseUrl];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSDictionary *dic = @{@"u_id" : user_ID,
                          @"uwl_amount" : money,
                          @"p_id" : bank_ID,
                          @"uwl_card" : number,
                          @"uwl_truename" : name,
                          @"u_pass" : password
                          };
    
    
    [manager POST:url parameters:dic success:^(NSURLSessionDataTask *task, id responseObject)
     {
         NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         
         if ([[dictionary objectForKey:@"code"] integerValue] == 1)
         {
             NSDictionary *dic = [dictionary objectForKey:@"data"];
             
             NSString *msg = [dic objectForKey:@"msg"];
             
             [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
             
             [SVProgressHUD showSuccessWithStatus:msg];
             
             [self performSelector:@selector(DatTime) withObject:self afterDelay:1.5];
             
             [self NOBtn];
         }
         else
         {
             NSDictionary *dic = [dictionary objectForKey:@"data"];
             
             NSString *msg = [dic objectForKey:@"msg"];
             
             [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
             
             [SVProgressHUD showErrorWithStatus:msg];
             
             [self performSelector:@selector(DatTime) withObject:self afterDelay:1.5];
         }
         
     } failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         
     }];
    
}








- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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



@end
