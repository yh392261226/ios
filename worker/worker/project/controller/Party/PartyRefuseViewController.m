//
//  PartyRefuseViewController.m
//  worker
//
//  Created by 郭健 on 2017/9/7.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "PartyRefuseViewController.h"

@interface PartyRefuseViewController ()<UITextViewDelegate>
{
    
    NSMutableArray *dataArray;
    
    UIImageView *icon;    //头像
    
    UILabel *name;  //名字
    
    UILabel *worker;   //工种
    
    UILabel *evaluation;   //评价
    
    UILabel *question;   //原因
    
    UIButton *seleced;    //点击选择按钮
    
    UITextView *textview;  //编辑框
    
    UILabel *place;   //水印
    
    UIImageView *sex;   //性别
    
    UIButton *yes;   //提交按钮
    
    
    NSString *data;   //原因的数据
    
    NSString *derail;   //详细的原因
    
    
    
    
    NSInteger type;     //判断原因内容是否选择
}

@end

@implementation PartyRefuseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    type = 0;
    
    dataArray = [NSMutableArray array];
    [dataArray addObject:@"1"];
    [dataArray addObject:@"1"];
    [dataArray addObject:@"1"];
    [dataArray addObject:@"1"];
    [dataArray addObject:@"1"];
    
    
    [self initUI];
    
}


- (void)initUI
{
    [self addhead:@"填写原因"];
    
    
    UIView *backview = [[[NSBundle mainBundle] loadNibNamed:@"worker" owner:self options:nil] objectAtIndex:1];
    
    backview.frame = CGRectMake(0, 65, SCREEN_WIDTH, SCREEN_HEIGHT - 65);
    
    [self.view addSubview:backview];
    
    icon = [backview viewWithTag:1001];
    
    icon.layer.masksToBounds = YES;
    
    icon.layer.cornerRadius = 35;
    
    icon.backgroundColor = [UIColor orangeColor];
    
    
    
    name = [backview viewWithTag:1002];
    
    
    worker = [backview viewWithTag:1003];
    
    
    evaluation = [backview viewWithTag:1004];
    
    
    question = [backview viewWithTag:1005];
    
    
    seleced = [backview viewWithTag:1006];
    [seleced addTarget:self action:@selector(selectBtn) forControlEvents:UIControlEventTouchUpInside];
    
    
    textview = [backview viewWithTag:1007];
    
    textview.delegate = self;
    textview.layer.borderColor = UIColor.grayColor.CGColor;
    textview.layer.borderWidth = 1;
    textview.layer.cornerRadius = 6;
    textview.layer.masksToBounds = YES;
    
    
    place = [backview viewWithTag:1008];
    
    place.text = @"请填写您不用该工人的原因";
    
    
    sex = [backview viewWithTag:2000];
    
    
    
    
    yes = [backview viewWithTag:1009];
    
    yes.layer.cornerRadius = 5;
    
    [yes addTarget:self action:@selector(yesBtn) forControlEvents:UIControlEventTouchUpInside];
    
    
    
}












//点击选择按钮
- (void)selectBtn
{
    UIAlertController *alertcontroller = [UIAlertController alertControllerWithTitle:nil message:@"选择原因" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *returnAction = [UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleCancel handler:nil];
    
    [alertcontroller addAction:returnAction];
    
    
    for (int i = 0; i < dataArray.count; i++)
    {
        UIAlertAction *action = [UIAlertAction actionWithTitle:[dataArray objectAtIndex:i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                                 {
                                     data = action.title;
                                     
                                     type = 1;
                                     
                                     [seleced setTitle:data forState:UIControlStateNormal];
                                 }];
        
        
        [alertcontroller addAction:action];
        
    }
    
    [self presentViewController:alertcontroller animated:YES completion:nil];

}






//提交按钮
- (void)yesBtn
{
    if (type == 0)
    {
        [SVProgressHUD showInfoWithStatus:@"请点击选择原因"];
    }
    else if (derail.length == 0)
    {
        [SVProgressHUD showInfoWithStatus:@"请填写您的原因"];
    }
    else
    {
        NSLog(@"1");
    }
}


//获取textview的数据
- (void)textViewDidChange:(UITextView *)textView
{
    if ([textView.text length] == 0)
    {
        [place setHidden:NO];
    }
    else
    {
        [place setHidden:YES];
    }
    
    derail = textview.text;
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
