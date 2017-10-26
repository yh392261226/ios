//
//  PasswordToViewController.h
//  worker
//
//  Created by 郭健 on 2017/8/30.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "BaseViewController.h"

@interface PasswordToViewController : BaseViewController

@property (nonatomic, strong)NSString *firPass;   //第一次编辑的密码

@property (nonatomic, strong)NSString *odlpassword;   //旧密码    ,,用于网络请求，用于判断是输入原密码更改密码


@property (nonatomic, strong)NSString *yanzhengma;  //验证码
@property (nonatomic, strong)NSString *wangjimima;  //用于判断此次是不知道原密码修改密码
@property (nonatomic, strong)NSString *card_ID;   //身份证号

@end
