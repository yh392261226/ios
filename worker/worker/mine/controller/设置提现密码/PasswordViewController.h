//
//  PasswordViewController.h
//  worker
//
//  Created by 郭健 on 2017/8/30.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "BaseViewController.h"

@interface PasswordViewController : BaseViewController


@property (nonatomic, strong)NSString *oldpassword;


@property (nonatomic, strong)NSString *wangjimima;  //忘记密码走的路， 记录一下， 用于修改密码网络请求判断
@property (nonatomic, strong)NSString *yanzhengmaNu;   //验证码
@property (nonatomic, strong)NSString *shenfenzhenghao;  //身份证号

@end
