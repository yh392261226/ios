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
        
        _IconImage.backgroundColor = [UIColor orangeColor];
        
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
        
        
        
        
    }
    
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.mas_equalTo(_IconImage).offset(60);
        make.centerY.mas_equalTo(self.contentView);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(25);
    }];
    
    [_introduce mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.mas_equalTo(_loginBtn).offset(85);
         make.centerY.mas_equalTo(self.contentView);
         make.width.mas_equalTo(100);
         make.height.mas_equalTo(25);
     }];
}






@end
