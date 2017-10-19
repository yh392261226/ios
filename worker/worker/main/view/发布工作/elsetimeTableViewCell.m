//
//  elsetimeTableViewCell.m
//  worker
//
//  Created by 郭健 on 2017/8/23.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "elsetimeTableViewCell.h"

@implementation elsetimeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        _name = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, 50, 30)];
        
        _name.font = [UIFont systemFontOfSize:17];
        
        _name.text = @"工期:";
        
        [self.contentView addSubview:_name];
        
        
        _startTime = [[UITextField alloc] init];
        
        _startTime.placeholder = @"项目开始时间";
        
        [self.startTime setValue:[UIFont systemFontOfSize:16.0] forKeyPath:@"_placeholderLabel.font"];
        
        [self.contentView addSubview:_startTime];
        
        
        _line = [[UIView alloc] init];
        
        _line.backgroundColor = [UIColor grayColor];
        
        [self.contentView addSubview:_line];
        
        _endTime = [[UITextField alloc] init];
        
        _endTime.placeholder = @"项目结束时间";
        
        [self.endTime setValue:[UIFont systemFontOfSize:16.0] forKeyPath:@"_placeholderLabel.font"];
        
        [self.contentView addSubview:_endTime];
        
        
        _start = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [self.contentView addSubview:_start];
        
        
        _end = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [self.contentView addSubview:_end];
        
    }
    
    return self;
}



- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_startTime mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.mas_equalTo(_name).offset(50);
        make.top.mas_equalTo(self.contentView).offset(6);
        make.width.mas_equalTo(110);
        make.height.mas_equalTo(30);
    }];
    
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.mas_equalTo(_startTime).offset(107);
        make.top.mas_equalTo(self.contentView).offset(19);
        make.width.mas_equalTo(45);
        make.height.mas_equalTo(1);
    }];

    
    [_endTime mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.mas_equalTo(_line).offset(55);
         make.top.mas_equalTo(self.contentView).offset(6);
         make.width.mas_equalTo(110);
         make.height.mas_equalTo(30);
     }];
    
    
    [_end mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.mas_equalTo(_line).offset(55);
         make.top.mas_equalTo(self.contentView).offset(7);
         make.width.mas_equalTo(110);
         make.height.mas_equalTo(30);
     }];
    
    
    
    [_start mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.mas_equalTo(_name).offset(50);
         make.top.mas_equalTo(self.contentView).offset(7);
         make.width.mas_equalTo(110);
         make.height.mas_equalTo(30);
     }];
}



















@end
