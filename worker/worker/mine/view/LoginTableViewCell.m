//
//  LoginTableViewCell.m
//  worker
//
//  Created by 郭健 on 2017/8/9.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "LoginTableViewCell.h"

@implementation LoginTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
         self.contentView.backgroundColor = [myselfway stringTOColor:@"0xC4CED3"];
        
        _view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_HEIGHT, 101)];
        
        _view.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:_view];
        
        _User = [[UIImageView alloc] initWithFrame:CGRectMake(30, 12.5, 25, 25)];
        
        _User.image = [UIImage imageNamed:@"mine_login1"];
        
        [_view addSubview:_User];
        
        _Password = [[UIImageView alloc] initWithFrame:CGRectMake(30, 63.5, 25, 25)];
        
        _Password.image = [UIImage imageNamed:@"mine_login2"];
        
        [_view addSubview:_Password];
        
        _textuser = [[UITextField alloc] initWithFrame:CGRectMake(60, 0.5, 250, 50)];
        _textuser.keyboardType = UIKeyboardTypeNumberPad;
        _textuser.tag = 10001;
        _textuser.placeholder = @"请输入手机号";
        [_view addSubview:_textuser];
        
        _textpassword = [[UITextField alloc] initWithFrame:CGRectMake(60, 51.5, 250, 50)];
        _textpassword.keyboardType = UIKeyboardTypeNumberPad;
        _textpassword.placeholder = @"请输入收到的动态密码";
        _textpassword.tag = 10002;
        _textpassword.secureTextEntry = YES;
        [_view addSubview:_textpassword];
        
        _line = [[UILabel alloc] init];
        _line.backgroundColor = [myselfway stringTOColor:@"0xF3F3F3"];
        [_view addSubview:_line];
        
        _yanzhengma = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 110, 10, 100, 30)];
        [_yanzhengma setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_yanzhengma setTitleColor:[UIColor whiteColor] forState:0];
        _yanzhengma.layer.cornerRadius = 5;
        _yanzhengma.backgroundColor = [myselfway stringTOColor:@"0x2E84F8"];
        _yanzhengma.titleLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_yanzhengma];
        
        _login = [UIButton buttonWithType:UIButtonTypeCustom];
        _login.frame = CGRectMake(20, 135, SCREEN_WIDTH - 40, 40);
        _login.backgroundColor = [UIColor whiteColor];
        _login.layer.cornerRadius = 5;
        [_login setTitle:@"登录" forState:UIControlStateNormal];
        [_login setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self.contentView addSubview:_login];
        
        
        
        
        
        
        
        
    }
    return self;
}



- (void)layoutSubviews
{
    [_line mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.mas_equalTo(self.view).offset(0);
         make.top.mas_equalTo(_view).offset(50);
         make.right.mas_equalTo(_view).offset(-10);
         make.size.height.mas_equalTo(1);
     }];
}

@end
