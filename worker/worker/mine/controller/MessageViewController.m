//
//  MessageViewController.m
//  worker
//
//  Created by 郭健 on 2017/9/1.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "MessageViewController.h"


@interface MessageViewController ()
{
    
    
}

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addhead:@"消息提示"];
    
    [self slitherBack:self.navigationController];

    [self initUI];
}



- (void)initUI
{
    UIImageView *image = [[UIImageView alloc] init];
    
    image.image = [UIImage imageNamed:@"mine_mess-1"];
    
    [self.view addSubview:image];

    
    [image mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.top.mas_equalTo(self.view).offset(100);
        make.centerX.mas_equalTo(self.view);
        make.height.mas_equalTo(100);
        make.width.mas_equalTo(100);
    }];
    
    
//    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"您已关闭消息提示功能，如想打开需要在手机的设置-通知-找工人中手动设置"];
//    
//    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(21,29)];
   
    
    
    UILabel *name = [[UILabel alloc] init];
    
    name.font = [UIFont systemFontOfSize:16];
    
    name.textAlignment = NSTextAlignmentCenter;
    
    name.numberOfLines = 2;
    
    name.text = @"您已关闭消息提示功能，如想打开需要在手机的设置-通知-找工人中手动设置";
    
    [self.view addSubview:name];
    
    
    [name mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.top.mas_equalTo(image).offset(120);
        make.left.mas_equalTo(40);
        make.right.mas_equalTo(-40);
        make.height.mas_equalTo(60);
    }];
    
}








- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
