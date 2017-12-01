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
        
        _woman.textAlignment = NSTextAlignmentCenter;
        
        _woman.font = [UIFont systemFontOfSize:14];
        
        [self.contentView addSubview:_woman];
        
        
        _womanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _womanBtn.layer.cornerRadius = 5;
        
        [self.contentView addSubview:_womanBtn];
        
        _man = [[UILabel alloc] init];
        
        
        _man.textAlignment = NSTextAlignmentCenter;
        
        _man.font = [UIFont systemFontOfSize:14];
        
        [self.contentView addSubview:_man];
        
        
        _manBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _manBtn.layer.cornerRadius = 5;
        
        [self.contentView addSubview:_manBtn];
        
        
        
        //按钮
        
        
        _manB = [UIButton buttonWithType:UIButtonTypeCustom];
        
     //   _manB.backgroundColor = [UIColor redColor];
        
        [self.contentView addSubview:_manB];
        
        
        
        
        _womanB = [UIButton buttonWithType:UIButtonTypeCustom];
        
     //   _womanB.backgroundColor = [UIColor greenColor];
        
        [self.contentView addSubview:_womanB];
        
        
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
         make.height.mas_equalTo(10);
         make.width.mas_equalTo(10);
         
     }];
    
    
    
    [_man mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.right.mas_equalTo(_womanBtn).offset(-15);
         make.centerY.mas_equalTo(self.contentView);
         make.height.mas_equalTo(30);
         make.width.mas_equalTo(20);
         
     }];
    
    [_manBtn mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.right.mas_equalTo(_man).offset(-25);
         make.centerY.mas_equalTo(self.contentView);
         make.height.mas_equalTo(10);
         make.width.mas_equalTo(10);
         
     }];
    
    
    //按钮
    
    [_manB mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.right.mas_equalTo(_man).offset(-5);
         make.centerY.mas_equalTo(self.contentView);
         make.height.mas_equalTo(20);
         make.width.mas_equalTo(35);
         
     }];
    
    
    
    [_womanB mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.right.mas_equalTo(_woman).offset(-5);
         make.centerY.mas_equalTo(self.contentView);
         make.height.mas_equalTo(20);
         make.width.mas_equalTo(35);
         
     }];
    
   
}


@end
