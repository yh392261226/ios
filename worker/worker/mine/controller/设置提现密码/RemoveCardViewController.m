//
//  RemoveCardViewController.m
//  worker
//
//  Created by 郭健 on 2017/8/31.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "RemoveCardViewController.h"

@interface RemoveCardViewController ()<UITextFieldDelegate>
{
    UITextField *cardNumber;
    
}

@end

@implementation RemoveCardViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addhead:@"重置提现密码"];
    
    [self slitherBack:self.navigationController];
    
    
    
}


//加载UI控件
- (void)initUI
{
    //UILabel *title = [UILabel alloc] initWithFrame:CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
}








- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
