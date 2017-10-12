//
//  MineLoginTableViewCell.m
//  worker
//
//  Created by 郭健 on 2017/8/1.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "MineLoginTableViewCell.h"

@implementation MineLoginTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        _IconImage = [[UIImageView alloc] init];
        
        _IconImage.frame = CGRectMake(20, 15, 50, 50);
        
        _IconImage.layer.cornerRadius = 25;
        
        _IconImage.layer.masksToBounds = YES;
        
        _IconImage.image = [UIImage imageNamed:@"job_icon"];
        
        [self.contentView addSubview:_IconImage];
        
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_loginBtn.layer setCornerRadius:5];
        [_loginBtn setTitle:@"立即登录" forState:UIControlStateNormal];
        _loginBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        
        [_loginBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_loginBtn.layer setMasksToBounds:YES];//设置按钮的圆角半径不会被遮挡
        _loginBtn.layer.borderColor = [UIColor grayColor].CGColor;
        [_loginBtn.layer setBorderWidth:1];//设置边界的宽度
        
        [self.contentView addSubview:_loginBtn];
        
        
        _introduce = [[UILabel alloc] init];
        
        _introduce.font = [UIFont systemFontOfSize:14];
        
        _introduce.textColor = [UIColor grayColor];
        
        _introduce.text = @"开启轻松生活";
        
        [self.contentView addSubview:_introduce];
        
        
        
        _userName = [[UILabel alloc] init];
        
        _userName.font = [UIFont systemFontOfSize:15];
        
        [self.contentView addSubview:_userName];
        
        
        _userImage = [[UIImageView alloc] init];
        
        [self.contentView addSubview:_userImage];
        
        
        _typeButton = [[UISwitch alloc] init];
        
        
        [self.contentView addSubview:_typeButton];
        
        
        _isstate = [[UIImageView alloc] init];
        
        _isstate.image = [UIImage imageNamed:@"mine_kuangkuang"];
        
        [self.contentView addSubview:_isstate];
        
        
        _textL = [[UILabel alloc] init];
        _textL.textColor = [UIColor grayColor];
        _textL.font = [UIFont systemFontOfSize:10];
        _textL.text = @"公开信息";
        [self.contentView addSubview:_textL];
        
    }
    
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_userName mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.mas_equalTo(self.contentView);
        make.left.mas_equalTo(_IconImage).offset(60);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(150);
    }];
    
    [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.mas_equalTo(_IconImage).offset(80);
        make.centerY.mas_equalTo(self.contentView);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(25);
    }];
    
    [_introduce mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.mas_equalTo(_loginBtn).offset(105);
         make.centerY.mas_equalTo(self.contentView);
         make.width.mas_equalTo(120);
         make.height.mas_equalTo(25);
     }];
    
    
    [_userImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.mas_equalTo(self.contentView);
        make.left.mas_equalTo(_userName).offset(135);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(20);
    }];
    
    
    [_typeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.mas_equalTo(self.contentView);
        make.right.mas_equalTo(self.contentView).offset(0);
        make.height.mas_equalTo(28);
        make.width.mas_equalTo(70);
    }];
    
    
    [_isstate mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.mas_equalTo(self.contentView);
        make.right.mas_equalTo(_typeButton).offset(-75);
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(55);
    }];
    
    
    [_textL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_isstate).offset(10);
        make.left.mas_equalTo(_isstate).offset(5);
        make.right.mas_equalTo(_isstate).offset(-5);
        make.bottom.mas_equalTo(_isstate).offset(-10);
    }];
    
    
    
}






@end
