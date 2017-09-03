//
//  BoundPhoneViewController.m
//  worker
//
//  Created by 郭健 on 2017/9/1.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "BoundPhoneViewController.h"
#import "BoundTableViewCell.h"

@interface BoundPhoneViewController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>



@property (nonatomic, strong)UITableView *tableview;

@end

@implementation BoundPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addhead:@"手机绑定"];
    
    [self slitherBack:self.navigationController];
    
    [self tableview];
    
    
}


#pragma tableview的代理

- (UITableView *)tableview
{
    if (!_tableview)
    {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStyleGrouped];
        
        _tableview.delegate = self;
        _tableview.dataSource = self;
        
        //_tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _tableview.backgroundColor = [myselfway stringTOColor:@"0xC4CED3"];
        
        _tableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.1)];
        _tableview.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.1)];
        
        [_tableview registerClass:[BoundTableViewCell class] forCellReuseIdentifier:@"cell"];
        
        [self.view addSubview:_tableview];
       
        
    }
    
    return _tableview;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BoundTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row == 0)
    {
        cell.field.placeholder = @"请输入手机号码";
        
        cell.field.delegate = self;
        
        cell.field.tag = 10001;
    }
    else
    {
        cell.field.placeholder = @"请输入动态密码";
        
        cell.field.tag = 10002;
        
        cell.field.delegate = self;
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        btn.backgroundColor = [myselfway stringTOColor:@"0x2E84F8"];
        
        [btn setTitle:@"获取动态密码" forState:0];
        
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        
        [btn addTarget:self action:@selector(yanzhengmaBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        btn.layer.cornerRadius = 8;
        
        [cell addSubview:btn];
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.right.mas_equalTo(cell).offset(-15);
            make.top.mas_equalTo(cell).offset(10);
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(110);
        }];
        
        
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 100;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    
    UILabel *label = [[UILabel alloc] init];
    
    label.textColor = [UIColor grayColor];
    
    label.numberOfLines = 2;
    label.text = @"手机号码便于登陆和接收雇主来电，重新绑定后，请使用新的手机号码登陆";
    label.font = [UIFont systemFontOfSize:14];
    
    label.frame = CGRectMake(15, 0, SCREEN_WIDTH - 20, 60);
    
    [view addSubview:label];
    
    
    UIButton *login = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [login setTitle:@"确定" forState:0];
    
    login.layer.cornerRadius = 10;
    
    [login addTarget:self action:@selector(loginBtn) forControlEvents:UIControlEventTouchUpInside];
    
    login.backgroundColor = [myselfway stringTOColor:@"0x2E84F8"];
    
    [view addSubview:login];
    
    [login mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.top.mas_equalTo(label).offset(80);
        make.left.mas_equalTo(view).offset(30);
        make.right.mas_equalTo(view).offset(-30);
        make.height.mas_equalTo(35);
    }];
    
    
    return view;
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}


#pragma textfield的代理
//限制textfield的长度
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.tag == 10001)
    {
        if (string.length == 0)
            
            return YES;
        
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        
        if (existedLength - selectedLength + replaceLength > 11)
        {
            return NO;
        }
    }
    
    else
    {
        if (string.length == 0)
            
            return YES;
        
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > 4)
        {
            return NO;
        }
    }
    
    return YES;
}





#pragma 自己的方法

//点击验证码按钮
- (void)yanzhengmaBtn: (UIButton *)btn
{
    UITextField *field = [self.view viewWithTag:10001];
    
    if (field.text.length == 0)
    {
        [SVProgressHUD showInfoWithStatus:@"手机号为空"];
    }
    else
    {
        [self time:btn];
    }
    
}


//登录按钮
- (void)loginBtn
{
    UITextField *field = [self.view viewWithTag:10001];
    UITextField *fielf1 = [self.view viewWithTag:10002];
    
    if (field.text.length == 0)
    {
        [SVProgressHUD showInfoWithStatus:@"手机号为空"];
    }
    else if (fielf1.text.length == 1)
    {
        [SVProgressHUD showInfoWithStatus:@"验证码为空"];
    }
    else
    {
        NSLog(@"1");
    }
    
}


//倒计数秒
- (void)time: (UIButton *)timebutton
{
    __block int timeout = 60; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(timeout <= 0)
        { //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置界面的按钮显示
                
                [timebutton setTitle:@"重新获取" forState:UIControlStateNormal];
                
                timebutton.userInteractionEnabled = YES;
                
                timebutton.backgroundColor = [myselfway stringTOColor:@"0x3E9FEA"];
                
            });
            
        }
        else
        {
            
            int seconds = timeout;
            
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //让按钮变为不可点击的灰色
                
                timebutton.backgroundColor = [UIColor grayColor];
                
                timebutton.userInteractionEnabled = NO;
                
                //设置界面的按钮显示
                
                [UIView beginAnimations:nil context:nil];
                
                [UIView setAnimationDuration:1];
                
                [timebutton setTitle:[NSString stringWithFormat:@"%@秒后重新发送",strTime] forState:UIControlStateNormal];
                
                [UIView commitAnimations];
                
            });
            
            timeout--;
            
        }
        
    });
    
    dispatch_resume(_timer);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
