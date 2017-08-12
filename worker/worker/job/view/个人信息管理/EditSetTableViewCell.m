//
//  EditSetTableViewCell.m
//  worker
//
//  Created by 郭健 on 2017/8/11.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "EditSetTableViewCell.h"

@implementation EditSetTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        _name = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, 150, 30)];
        _name.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_name];
        
        
        _woman = [[UILabel alloc] init];
        
        _woman.textColor = [UIColor grayColor];
        
        _woman.textAlignment = NSTextAlignmentCenter;
        
        _woman.font = [UIFont systemFontOfSize:14];
        
        [self.contentView addSubview:_woman];
        
        
        _womanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _womanBtn.layer.cornerRadius = 3.5;
        
        [self.contentView addSubview:_womanBtn];
        
        _man = [[UILabel alloc] init];
        
        _man.textColor = [UIColor redColor];
        
        _man.textAlignment = NSTextAlignmentCenter;
        
        _man.font = [UIFont systemFontOfSize:14];
        
        [self.contentView addSubview:_man];
        
        
        _manBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _manBtn.layer.cornerRadius = 3.5;
        
        [self.contentView addSubview:_manBtn];
        
    }
    
    return self;
}



- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_woman mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.right.mas_equalTo(self.contentView).offset(-10);
        make.top.mas_equalTo(self.contentView).offset(5);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(20);
        
    }];
    
    
    [_womanBtn mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.right.mas_equalTo(_woman).offset(-25);
         make.centerY.mas_equalTo(self.contentView);
         make.height.mas_equalTo(7);
         make.width.mas_equalTo(7);
         
     }];
    
    
    
    [_man mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.right.mas_equalTo(_womanBtn).offset(-12);
         make.centerY.mas_equalTo(self.contentView);
         make.height.mas_equalTo(30);
         make.width.mas_equalTo(20);
         
     }];
    
    [_manBtn mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.right.mas_equalTo(_womanBtn).offset(-25);
         make.centerY.mas_equalTo(self.contentView);
         make.height.mas_equalTo(7);
         make.width.mas_equalTo(7);
         
     }];
    
   
}


@end
