//
//  PartyBclauseViewController.m
//  worker
//
//  Created by 郭健 on 2017/9/9.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "PartyBclauseViewController.h"
#import "BYesWorkerViewController.h"

@interface PartyBclauseViewController ()
{
    UILabel *title;
    
    UILabel *firstLab;
    
    UILabel *secondLab;
    
    UILabel *threeLab;
    
    UILabel *fourLab;
    
    UILabel *fiveLab;
    
    
    UIButton *left;
    
    UIButton *right;
    
     UILabel *tiaokuan;  //条款
}

@end

@implementation PartyBclauseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addhead:@"服务条款"];
    
    
    [self initUI];
    
}


- (void)initUI
{
    
    
    UIView *backview = [[[NSBundle mainBundle] loadNibNamed:@"worker" owner:self options:nil] objectAtIndex:4];
    
    backview.frame = CGRectMake(0, 65, SCREEN_WIDTH, SCREEN_HEIGHT - 65);
    
    [self.view addSubview:backview];
    
    secondLab = [backview viewWithTag:2222];
    
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
    
    left.layer.cornerRadius = 6.0; //2.0是圆角的弧度，根据需求自己更改
    left.layer.borderColor = [UIColor blackColor].CGColor;//设置边框颜色
    left.layer.borderWidth = 1.0f; //设置边框颜色
    [left addTarget:self action:@selector(leftBtn) forControlEvents:UIControlEventTouchUpInside];
    
    
    tiaokuan = [backview viewWithTag:9888];
    tiaokuan.text = [NSString stringWithFormat:@"%@   %@", self.orangeText, self.greenText];
    
    
    
    right = [backview viewWithTag:2999];
    
    right.layer.cornerRadius = 6.0; //2.0是圆角的弧度，根据需求自己更改
    right.layer.borderColor = [UIColor blackColor].CGColor;//设置边框颜色
    right.layer.borderWidth = 1.0f; //设置边框颜色
    [right addTarget:self action:@selector(rightBtn) forControlEvents:UIControlEventTouchUpInside];
    
    
}


//工资不对按钮
- (void)leftBtn
{
    [self.navigationController popViewControllerAnimated:YES];
}





//开始干活按钮
- (void)rightBtn
{
    [self worKerYes];
}




//工人确认
- (void)worKerYes
{
    
    NSString *url = [NSString stringWithFormat:@"%@Orders/index?action=workerConfirm&o_id=%@&t_id=%@&o_worker=%@", baseUrl, self.o_id, self.t_id, user_ID];
    
    NSLog(@"%@", url);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject)
     {
         
         NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         
         
         if ([[dictionary objectForKey:@"code"] integerValue] == 200)
         {
             
//            NSString *dic = [dictionary objectForKey:@"data"];
//
//            NSLog(@"%@", dic);
//
//            BYesWorkerViewController *temp = [[BYesWorkerViewController alloc] init];
//
//            temp.redText = self.redText;
//            temp.orangeText = self.orangeText;
//            temp.greenText = self.greenText;
//            temp.blueText = self.blueText;
//
//            temp.t_id = self.t_id;
             
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
            [SVProgressHUD showInfoWithStatus:@"确认成功"];
                 
        //    [self.navigationController pushViewController:temp animated:YES];

             [self.navigationController popToRootViewControllerAnimated:YES];
             
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
