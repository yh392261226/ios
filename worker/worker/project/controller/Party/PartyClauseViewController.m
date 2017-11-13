//
//  PartyClauseViewController.m
//  worker
//
//  Created by 郭健 on 2017/9/8.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "PartyClauseViewController.h"
#import "ModifyMoneyViewController.h"

@interface PartyClauseViewController ()
{
    UILabel *title;
    
    UILabel *firstLab;
    
    UILabel *secondLab;
    
    UILabel *threeLab;
    
    UILabel *fourLab;
    
    UILabel *fiveLab;
    
    
    UIButton *left;
    UIButton *center;
    UIButton *right;

    UILabel *qian;
}

@end

@implementation PartyClauseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self addhead:@"服务条款"];
    
    
    [self initUI];
    
    
}



- (void)initUI
{
    UIView *backview = [[[NSBundle mainBundle] loadNibNamed:@"worker" owner:self options:nil] objectAtIndex:3];
    
    backview.frame = CGRectMake(0, 65, SCREEN_WIDTH, SCREEN_HEIGHT - 65);
    
    [self.view addSubview:backview];
    
    secondLab = [backview viewWithTag:2222];
    
    qian = [backview viewWithTag:9888];
    
    NSString *sta = [myselfway timeWithTimeIntervalString:self.startTime];
    NSString *end = [myselfway timeWithTimeIntervalString:self.endTime];
    
    qian.text = [NSString stringWithFormat:@"%@元/人/天, 工期%@ 一 %@", self.money, sta, end];
    
    NSMutableAttributedString *hintString = [[NSMutableAttributedString alloc]initWithString:@"工作期间未发生解雇或辞职的状况，工作完成后，雇主确认工程结束，即算完工，系统将自动把雇主预付的工人工资结算给工人。如工期结束后，雇主未确认工程结束，系统将在工期结束后3日，把工人应得的工资结算给工人。在工资结算时，系统将收取工人相应的服务费，并把扣除服务费后的薪资转入到工人账户。"];
    //获取要调整颜色的文字位置,调整颜色
    NSRange range1 = [[hintString string] rangeOfString:@"工作期间未发生解雇或辞职的状况，工作完成后，雇主确认工程结束，即算完工，系统将自动把雇主预付的工人工资结算给工人。如工期结束后，雇主未确认工程结束，系统将在工期结束后3日，把工人应得的工资结算给工人。"];
    [hintString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range1];
    
    NSRange range2 = [[hintString string] rangeOfString:@"在工资结算时，系统将收取工人相应的服务费，并把扣除服务费后的薪资转入到工人账户。"];
    [hintString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range2];
    
    secondLab.attributedText = hintString;
    
    threeLab = [backview viewWithTag:3333];
    
    NSMutableAttributedString *threeLabnum = [[NSMutableAttributedString alloc] initWithString:@"如工作中出现纠纷，请双方先进行沟通，不要轻易的辞职或者解雇。如发生解雇工人的情况，请在完成当日工作后的第二日再与工人解除工作关系，解雇工人当日需要支付工人当日的工资。如发生工人辞职的情况，请工人在完成当日工作后第二天再点击我要辞职，辞职当日雇主不需要支付当日工人工资。"];
    
    //获取要调整颜色的文字位置,调整颜色
    NSRange range10 = [[threeLabnum string] rangeOfString:@"如工作中出现纠纷，请双方先进行沟通，不要轻易的辞职或者解雇。"];
    [threeLabnum addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range10];
    
    NSRange range20 = [[threeLabnum string] rangeOfString:@"如发生解雇工人的情况，请在完成当日工作后的第二日再与工人解除工作关系，解雇工人当日需要支付工人当日的工资。如发生工人辞职的情况，请工人在完成当日工作后第二天再点击我要辞职，辞职当日雇主不需要支付当日工人工资。"];
    [threeLabnum addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range20];
    
    threeLab.attributedText = threeLabnum;
    
    
    left = [backview viewWithTag:1999];
    
    left.layer.cornerRadius = 6.0;//2.0是圆角的弧度，根据需求自己更改
    left.layer.borderColor = [UIColor blackColor].CGColor;//设置边框颜色
    left.layer.borderWidth = 1.0f;//设置边框颜色
    [left addTarget:self action:@selector(leftBtn) forControlEvents:UIControlEventTouchUpInside];
    
    center = [backview viewWithTag:2999];
    center.layer.cornerRadius = 6;
    [center addTarget:self action:@selector(centerBtn) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    right = [backview viewWithTag:3999];
    
    right.layer.cornerRadius = 6.0;//2.0是圆角的弧度，根据需求自己更改
    right.layer.borderColor = [UIColor blackColor].CGColor;//设置边框颜色
    right.layer.borderWidth = 1.0f;//设置边框颜色
    [right addTarget:self action:@selector(rightBtn) forControlEvents:UIControlEventTouchUpInside];

}


//先不开工按钮
- (void)leftBtn
{
    [self.navigationController popViewControllerAnimated:NO];
}


//修改工资按钮
- (void)centerBtn
{
    ModifyMoneyViewController *temp = [[ModifyMoneyViewController alloc] init];
    
    
    temp.delegate = self;
    
    temp.worName = self.worName;
    temp.person = self.person;
    temp.money = self.money;
    temp.startTime = self.startTime;
    temp.endTime = self.endTime;
    temp.skill = self.skill;
    temp.o_worker = self.o_worker;
    temp.tew_id = self.tew_id;
    temp.t_id = self.t_id;
    
    [self.navigationController pushViewController:temp animated:YES];
    
}


//   修改金钱回调
- (void)tempMoney: (NSString *)money
{
    NSString *sta = [myselfway timeWithTimeIntervalString:self.startTime];
    NSString *end = [myselfway timeWithTimeIntervalString:self.endTime];
    qian.text = [NSString stringWithFormat:@"%@元/人/天, 工期%@ 一 %@", money, sta, end];
}



//开始干活按钮
- (void)rightBtn
{
    [self guzhuYes];
}



//雇主确认
- (void)guzhuYes
{
    
    NSString *url = [NSString stringWithFormat:@"%@Orders/index?action=employerConfirm&o_id=%@&t_id=%@&u_id=%@", baseUrl, self.o_id, self.t_id, user_ID];
    
    NSLog(@"%@", url);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject)
     {
         NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         
         if ([[dictionary objectForKey:@"code"] integerValue] == 200)
         {
             
             NSString *dic = [dictionary objectForKey:@"data"];
             
             NSLog(@"%@", dic);
             [SVProgressHUD setForegroundColor:[UIColor blackColor]];
             [SVProgressHUD showInfoWithStatus:dic];
             
             [self.delegate secuuss];
             
             [self.navigationController popViewControllerAnimated:NO];
             
             
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
