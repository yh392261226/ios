//
//  PartyBdismissViewController.m
//  worker
//
//  Created by 郭健 on 2017/9/6.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "PartyBdismissViewController.h"
#import "MoneyDetailsViewController.h"
#import "PartyBdomplainViewController.h"
#import "PartyDomplainViewController.h"

@interface PartyBdismissViewController ()<UITextViewDelegate>
{
    UIImageView *icon;    //头像
    UILabel *name;     //名字
    UILabel *worker;   //工种
    UILabel *evaluate;   //评价
    UILabel *money;     //钱
    
    UIImageView *sex;   //性别
    
    UIButton *Complaints;   //投诉工人按钮
    UIButton *deail;    //详情按钮
    UIButton *yes;      //提交按钮
    
    UITextView *text;    //解雇原因
    
    
    UILabel *dddddddd;   //文字
    
    UIButton *good1;    //评价按钮
    UIButton *good2;
    UIButton *good3;
    
    NSInteger evaluation;   //评价， 传给后台
    
    UILabel *plans;   //水印字样


    UILabel *field;   //支付或者收入字样
    
    UILabel *tousuZiyang;   //投诉雇主字样

    
    NSString *qustion;    //辞退原因
}

@end

@implementation PartyBdismissViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUI];
    
    
    self.view.backgroundColor = [myselfway stringTOColor:@"0xF1F1F1"];
    
    
    
    
}





- (void)initUI
{
    [self addhead:@"辞职原因"];
    
    UIView *backview = [[[NSBundle mainBundle] loadNibNamed:@"worker" owner:self options:nil] objectAtIndex:0];
    
    backview.frame = CGRectMake(0, 65, SCREEN_WIDTH, SCREEN_HEIGHT - 65);
    
    
    icon = [backview viewWithTag:1001];
    icon.layer.masksToBounds = YES;
    icon.layer.cornerRadius = 35;
    NSURL *url = [NSURL URLWithString:self.icon];
    [icon sd_setImageWithURL:url];
   
    
    
    name = [backview viewWithTag:1002];
    name.text = self.name;
    
    worker = [backview viewWithTag:1003];
    worker.text = @"雇主";
    
    
    evaluate = [backview viewWithTag:1004];
    evaluate.text = [NSString stringWithFormat:@"好评%@次", self.haoping];
    

    Complaints = [backview viewWithTag:1005];
    
    Complaints.layer.cornerRadius = 5;
    [Complaints addTarget:self action:@selector(compBtn) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    money = [backview viewWithTag:1006];
    
    
    deail = [backview viewWithTag:1007];
    [deail addTarget:self action:@selector(deailaaBtn) forControlEvents:UIControlEventTouchUpInside];
    
    
    text = [backview viewWithTag:1008];
    
    text.delegate = self;
    text.layer.borderColor = UIColor.grayColor.CGColor;
    text.layer.borderWidth = 1;
    text.layer.cornerRadius = 6;
    text.layer.masksToBounds = YES;
    
    
    yes = [backview viewWithTag:1009];
    yes.layer.cornerRadius = 5;
    [yes addTarget:self action:@selector(yesBtn) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    good1 = [backview viewWithTag:1111];
    [good1 addTarget:self action:@selector(goodBtn1) forControlEvents:UIControlEventTouchUpInside];
    
    good2 = [backview viewWithTag:2222];
    [good2 addTarget:self action:@selector(goodBtn2) forControlEvents:UIControlEventTouchUpInside];
    
    good3 = [backview viewWithTag:3333];
    [good3 addTarget:self action:@selector(goodBtn3) forControlEvents:UIControlEventTouchUpInside];
    
    
    field = [backview viewWithTag:1777];
    field.text = @"收到工资";
    
    
    
    
    
    dddddddd = [backview viewWithTag:1155];
    
    dddddddd.text = @"辞职后，系统将按照已完成工时为您计算工资，工资将在XX时间内发放至您的钢建众工账户";
    
    
    
    tousuZiyang = [backview viewWithTag:5555];
    tousuZiyang.text = @"投诉雇主";
    
    
    plans = [backview viewWithTag:1555];
    plans.text = @"请填写辞职原因";
    
    
    
    sex = [backview viewWithTag:1100];
    
    
    
    
    
     
     
    
    if ([self.sex isEqualToString:@"0"])
    {
        sex.image = [UIImage imageNamed:@"job_woman"];
    }
    else if ([self.sex isEqualToString:@"1"])
    {
        sex.image = [UIImage imageNamed:@"job_man"];
    }
    
    
    [self.view addSubview:backview];
}


//查看明细按钮
- (void)deailaaBtn
{
    self.hidesBottomBarWhenPushed = YES;
    MoneyDetailsViewController *temp = [[MoneyDetailsViewController alloc] init];
    [self.navigationController pushViewController:temp animated:YES];
}



//投诉雇主按钮
- (void)compBtn
{
    PartyDomplainViewController *temp = [[PartyDomplainViewController alloc] init];
    
    
    temp.worker = self.u_id;
   
    temp.name = self.name;
    temp.sex = self.sex;
    temp.icon = self.icon;
    temp.workerName = self.workerName;
    temp.number = self.haoping;
    
    
    temp.type = @"1";
    
    [self.navigationController pushViewController:temp animated:YES];
}



//提交按钮
- (void)yesBtn
{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    if (qustion.length == 0)
    {
        [SVProgressHUD showInfoWithStatus:@"请填写辞退原因"];
    }
    else
    {
        [self workerNO];
    }
}





- (void)infoBtn
{
    [SVProgressHUD dismiss];
}


//改变好评1
- (void)goodBtn1
{
    [good1 setBackgroundImage:[UIImage imageNamed:@"job_ok"] forState:UIControlStateNormal];
    [good2 setBackgroundImage:[UIImage imageNamed:@"job_no"] forState:UIControlStateNormal];
    [good3 setBackgroundImage:[UIImage imageNamed:@"job_no"] forState:UIControlStateNormal];
    
    
    evaluation = 1;
}


//改变好评2
- (void)goodBtn2
{
    [good1 setBackgroundImage:[UIImage imageNamed:@"job_ok"] forState:UIControlStateNormal];
    [good2 setBackgroundImage:[UIImage imageNamed:@"job_ok"] forState:UIControlStateNormal];
    [good3 setBackgroundImage:[UIImage imageNamed:@"job_no"] forState:UIControlStateNormal];
    
    evaluation = 2;
}




//改变好评3
- (void)goodBtn3
{
    [good1 setBackgroundImage:[UIImage imageNamed:@"job_ok"] forState:UIControlStateNormal];
    [good2 setBackgroundImage:[UIImage imageNamed:@"job_ok"] forState:UIControlStateNormal];
    [good3 setBackgroundImage:[UIImage imageNamed:@"job_ok"] forState:UIControlStateNormal];
    
    evaluation = 3;
}



//获取textview的数据
- (void)textViewDidChange:(UITextView *)textView
{
    if ([textView.text length] == 0)
    {
        [plans setHidden:NO];
    }
    else
    {
        [plans setHidden:YES];
    }
    
    
    
    qustion = textView.text;
}




//工人辞职
//- (void)workerNO
//{
//    NSString *eva = [NSString stringWithFormat:@"%ld", evaluation];
//
//    NSString *url = [NSString stringWithFormat:@"%@Orders/index?action=unbind&tew_id=%@&t_id=%@&type=resign&o_worker=%@&u_id=%@&s_id=%@&start=%@&appraisal=%@", baseUrl, self.tew_id , self.t_id , user_ID, self.u_id, self.s_id, eva, qustion];
//
//    NSLog(@"%@", url);
//
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//
//    [manager GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject)
//     {
//         NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//
//         if ([[dictionary objectForKey:@"code"] integerValue] == 200)
//         {
//
//             [self performSelector:@selector(infoBtn) withObject:nil afterDelay:1.5];
//
//             self.hidesBottomBarWhenPushed = NO;
//             self.tabBarController.selectedIndex = 1;
//             [self.navigationController popToRootViewControllerAnimated:YES];
//
//         }
//
//     } failure:^(NSURLSessionDataTask *task, NSError *error)
//     {
//
//
//
//     }];
//
//
//}



//消键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



//d去下
- (void)workerNO
{
    
    NSString *eva = [NSString stringWithFormat:@"%ld", evaluation];
    
    NSString *url = [NSString stringWithFormat:@"%@Orders/index?action=unbind&tew_id=%@&t_id=%@&type=resign&o_worker=%@&u_id=%@&s_id=%@&start=%@&appraisal=%@", baseUrl, self.tew_id , self.t_id , user_ID, self.u_id, self.s_id, eva, qustion];
    
    NSString *urlString = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:urlString parameters:nil success:^(NSURLSessionDataTask *task, id responseObject)
     {
         NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         
         if ([[dictionary objectForKey:@"code"] integerValue] == 200)
         {
         
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
             [SVProgressHUD showSuccessWithStatus:@"辞职成功"];
             
            [self performSelector:@selector(infoBtn) withObject:nil afterDelay:1.5];
         
            self.hidesBottomBarWhenPushed = NO;
            self.tabBarController.selectedIndex = 1;
            [self.navigationController popToRootViewControllerAnimated:YES];
         
        }
         
         
         
     }
         failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
         [SVProgressHUD showSuccessWithStatus:@"辞职失败，请检查网络..."];
     }];
    
    
}


@end
