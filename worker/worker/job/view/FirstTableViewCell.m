//
//  FirstTableViewCell.m
//  worker
//
//  Created by 郭健 on 2017/8/1.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "FirstTableViewCell.h"

@implementation FirstTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftBtn.frame = CGRectMake(0, 0, SCREEN_WIDTH / 2, 100);
        [self.contentView addSubview:_leftBtn];
        
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightBtn.frame = CGRectMake(SCREEN_WIDTH / 2, 0, SCREEN_WIDTH / 2, 100);
        [self.contentView addSubview:_rightBtn];
        
        _leftLab = [[UILabel alloc] init];
        _leftLab.font = [UIFont boldSystemFontOfSize:15];
        _leftLab.text = @"充值";
        _leftLab.textAlignment = NSTextAlignmentCenter;
        _leftLab.textColor = [UIColor grayColor];
        [_leftBtn addSubview:_leftLab];
        
        _rightLab = [[UILabel alloc] init];
        _rightLab.textAlignment = NSTextAlignmentCenter;
        _rightLab.font = [UIFont boldSystemFontOfSize:15];
        _rightLab.text = @"发布工作";
        _rightLab.textColor = [UIColor grayColor];
        [_rightBtn addSubview:_rightLab];
        
        _leftImage = [[UIImageView alloc] init];
        _leftImage.image = [UIImage imageNamed:@"job_recharge"];
        [_leftBtn addSubview:_leftImage];
        
        _rightImage = [[UIImageView alloc] init];
        _rightImage.image = [UIImage imageNamed:@"job_work"];
        [_rightBtn addSubview:_rightImage];
        
    }
    
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_leftImage mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.centerX.mas_equalTo(_leftBtn);
        make.top.mas_equalTo(_leftBtn).offset(12.5);
        make.width.mas_equalTo(35);
        make.height.mas_equalTo(35);
    }];
    
    [_rightImage mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.centerX.mas_equalTo(_rightBtn);
         make.top.mas_equalTo(_rightBtn).offset(12.5);
         make.width.mas_equalTo(35);
         make.height.mas_equalTo(35);
     }];
    
    
    [_leftLab mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.centerX.mas_equalTo(_leftBtn);
         make.top.mas_equalTo(_leftImage).offset(40);
         make.width.mas_equalTo(80);
         make.height.mas_equalTo(20);
     }];
    
    
    [_rightLab mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.centerX.mas_equalTo(_rightBtn);
         make.top.mas_equalTo(_rightImage).offset(40);
         make.width.mas_equalTo(80);
         make.height.mas_equalTo(20);
     }];
    
}
















@end
