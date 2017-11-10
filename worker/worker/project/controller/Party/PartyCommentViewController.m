//
//  PartyCommentViewController.m
//  worker
//
//  Created by 郭健 on 2017/9/7.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "PartyCommentViewController.h"
#import "MoneyDetailsViewController.h"
#import "PartyDomplainViewController.h"

@interface XDworDetailData : NSObject

@property (nonatomic, strong)NSString *u_id;
@property (nonatomic, strong)NSString *u_mobile;
@property (nonatomic, strong)NSString *u_idcard;
@property (nonatomic, strong)NSString *u_sex;
@property (nonatomic, strong)NSString *u_name;
@property (nonatomic, strong)NSString *u_skills;
@property (nonatomic, strong)NSString *uei_info;
@property (nonatomic, strong)NSString *u_task_status;
@property (nonatomic, strong)NSString *u_true_name;
@property (nonatomic, strong)NSString *ucp_posit_x;

@property (nonatomic, strong)NSString *ucp_posit_y;
@property (nonatomic, strong)NSString *uei_address;
@property (nonatomic, strong)NSString *u_img;


@property (nonatomic, strong)NSString *u_high_opinions;




@end

@implementation XDworDetailData


@end

@interface PartyCommentViewController ()<UITextViewDelegate>
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
    
    NSString *question;    //问题原因
    
    
    NSString *nameData;
    NSString *sexData;
    NSString *imageIcon;
    NSString *numData;
    NSString *workerDATA;   //传给下一页
}

@end

@implementation PartyCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self getData];
    
    [self initUI];
    
    evaluation = 0;
    
    
    self.view.backgroundColor = [myselfway stringTOColor:@"0xF1F1F1"];
    
    
    
}






- (void)initUI
{
    [self addhead:@"待评价"];
    
    UIView *backview = [[[NSBundle mainBundle] loadNibNamed:@"worker" owner:self options:nil] objectAtIndex:0];
    
    backview.frame = CGRectMake(0, 65, SCREEN_WIDTH, SCREEN_HEIGHT - 65);
    
    
    icon = [backview viewWithTag:1001];
    icon.layer.masksToBounds = YES;
    icon.layer.cornerRadius = 35;
    icon.backgroundColor = [UIColor orangeColor];
    
    name = [backview viewWithTag:1002];
    
    
    worker = [backview viewWithTag:1003];
    
    
    evaluate = [backview viewWithTag:1004];
    
    
    
    Complaints = [backview viewWithTag:1005];
    
    Complaints.layer.cornerRadius = 5;
    [Complaints addTarget:self action:@selector(compBtn) forControlEvents:UIControlEventTouchUpInside];
    
    
    money = [backview viewWithTag:1006];
    
    
//    deail = [backview viewWithTag:1007];
//    [deail addTarget:self action:@selector(deailaaBtn) forControlEvents:UIControlEventTouchUpInside];
    
    
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
    
    
    
    
    
    
    
    dddddddd = [backview viewWithTag:1155];
    
    dddddddd.text = @"工作已确认完成，工资将在XX时间内支付到工人的钢建众工账户";
    
    
    plans = [backview viewWithTag:1555];
    
    
    
    
    sex = [backview viewWithTag:1100];
    
    
    [self.view addSubview:backview];
    
}


//查看明细按钮
//- (void)deailaaBtn
//{
//
//    self.hidesBottomBarWhenPushed = YES;
//    MoneyDetailsViewController *temp = [[MoneyDetailsViewController alloc] init];
//    [self.navigationController pushViewController:temp animated:YES];
//
//}



//投诉工人按钮
- (void)compBtn
{
    
    self.hidesBottomBarWhenPushed = YES;
    
    PartyDomplainViewController *temp = [[PartyDomplainViewController alloc] init];
    
    temp.name = nameData;
    temp.icon = imageIcon;
    temp.worker = workerDATA;
    temp.sex = sexData;
    temp.number = numData;
    temp.worker = self.o_worker;
    temp.workerName = self.worName;
    
    [self.navigationController pushViewController:temp animated:YES];
    
}



//提交按钮
- (void)yesBtn
{
    [SVProgressHUD setForegroundColor:[UIColor blackColor]];
    if (question.length == 0)
    {
        [SVProgressHUD showInfoWithStatus:@"请填写辞退原因"];
    }
    else
    {
        
        [self employerEva];
        
    }
    
    
}

- (void)bbbbbb
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
    
    question = textView.text;
}






//消键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


//获取数据
- (void)getData
{
    NSString *url = [NSString stringWithFormat:@"%@Users/getUsers?u_id=%@", baseUrl, self.o_worker];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject)
     {
         NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         
         if ([[dictionary objectForKey:@"code"] integerValue] == 1)
         {
             NSDictionary *dic = [dictionary objectForKey:@"data"];
             
             NSArray *arr = [dic objectForKey:@"data"];
             
             for (int i = 0; i < arr.count; i++)
             {
                 NSDictionary *dicInfo = [arr objectAtIndex:i];
                 
                 XDworDetailData *data = [[XDworDetailData alloc] init];
                 
                 data.u_id = [dicInfo objectForKey:@"u_id"];
                 data.u_mobile = [dicInfo objectForKey:@"u_mobile"];
                 data.u_idcard = [dicInfo objectForKey:@"u_idcard"];
                 data.u_sex = [dicInfo objectForKey:@"u_sex"];
                 data.u_name = [dicInfo objectForKey:@"u_name"];
                 data.u_skills = [dicInfo objectForKey:@"u_skills"];
                 data.uei_info = [dicInfo objectForKey:@"uei_info"];
                 data.u_task_status = [dicInfo objectForKey:@"u_task_status"];
                 data.u_true_name = [dicInfo objectForKey:@"u_true_name"];
                 data.ucp_posit_x = [dicInfo objectForKey:@"ucp_posit_x"];
                 
                 data.ucp_posit_y = [dicInfo objectForKey:@"ucp_posit_y"];
                 data.uei_address = [dicInfo objectForKey:@"uei_address"];
                 data.u_img = [dicInfo objectForKey:@"u_img"];
                 data.u_high_opinions = [dicInfo objectForKey:@"u_high_opinions"];
                 
                 
                 imageIcon = data.u_img;
                 nameData = data.u_true_name;
                 numData = data.u_high_opinions;
                 workerDATA = self.worName;
                 sexData = data.u_sex;
                 
                 
                 
                 NSURL *url = [NSURL URLWithString:data.u_img];
                 
                 [icon sd_setImageWithURL:url];
                 
                 name.text = data.u_true_name;
                 
                 
                 evaluate.text = [NSString stringWithFormat:@"好评%@次", data.u_high_opinions];
                 worker.text = self.worName;
                 
                 if ([data.u_sex isEqualToString:@"0"])
                 {
                     sex.image = [UIImage imageNamed:@"job_woman"];
                 }
                 else if ([data.u_sex isEqualToString:@"1"])
                 {
                     sex.image = [UIImage imageNamed:@"job_man"];
                 }
                 
             }
             
         }
         
     } failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         
     }];
    
    
}



//评价
- (void)employerEva
{
    NSString *url = [NSString stringWithFormat:@"%@Users/commentAdd", baseUrl];
    
    NSLog(@"%@", url);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *eva = [NSString stringWithFormat:@"%ld", evaluation];
    
    NSDictionary *dic = @{@"u_id" : user_ID,
                          @"t_id" : self.t_id,
                          @"tc_u_id" : self.o_worker,
                          @"tce_desc" : question,
                          @"tc_start" : eva
                          };
    
    [manager POST:url parameters:dic success:^(NSURLSessionDataTask *task, id responseObject)
     {
         NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         
         if ([[dictionary objectForKey:@"code"] integerValue] == 1)
         {
             NSDictionary *dic = [dictionary objectForKey:@"data"];
             
             NSString *msg = [dic objectForKey:@"data"];
             [SVProgressHUD setForegroundColor:[UIColor blackColor]];
             
             if (msg)
             {
                 [SVProgressHUD showInfoWithStatus:@"评价成功"];
                 [self performSelector:@selector(bbbbbb) withObject:nil afterDelay:1];
                 self.hidesBottomBarWhenPushed = NO;
                 
                 self.navigationController.tabBarController.selectedIndex = 1;
                 [self.navigationController popToRootViewControllerAnimated:YES];
             }
             else
             {
                 [SVProgressHUD showErrorWithStatus:@"评论失败"];
                 [self performSelector:@selector(bbbbbb) withObject:nil afterDelay:1];
             }
             
             
             
             
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
