//
//  EditSelecedTableViewCell.m
//  worker
//
//  Created by 郭健 on 2017/8/11.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "EditSelecedTableViewCell.h"

@implementation EditSelecedTableViewCell


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
        
        
        
        
        
        _worker = [UIButton buttonWithType:UIButtonTypeCustom];
        
   //     _worker.backgroundColor = [UIColor redColor];
        
        [self.contentView addSubview:_worker];
        
    
        
        
        
        
        
        _noworker = [UIButton buttonWithType:UIButtonTypeCustom];
        
   //     _noworker.backgroundColor = [UIColor greenColor];
        
        [self.contentView addSubview:_noworker];
        
        
        
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
         make.width.mas_equalTo(70);
         
     }];
    
    
    [_womanBtn mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.right.mas_equalTo(_woman).offset(-75);
         make.centerY.mas_equalTo(self.contentView);
         make.height.mas_equalTo(10);
         make.width.mas_equalTo(10);
         
     }];
    
    
    
    [_man mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.right.mas_equalTo(_womanBtn).offset(-15);
         make.centerY.mas_equalTo(self.contentView);
         make.height.mas_equalTo(30);
         make.width.mas_equalTo(80);
         
     }];
    
    [_manBtn mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.right.mas_equalTo(_man).offset(-85);
         make.centerY.mas_equalTo(self.contentView);
         make.height.mas_equalTo(10);
         make.width.mas_equalTo(10);
         
     }];
    
    
    
    
    
    
    [_worker mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.right.mas_equalTo(_man).offset(-15);
         make.centerY.mas_equalTo(self.contentView);
         make.height.mas_equalTo(20);
         make.width.mas_equalTo(70);
         
     }];
    
    
    
    
    
    [_noworker mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.right.mas_equalTo(_woman).offset(-5);
         make.centerY.mas_equalTo(self.contentView);
         make.height.mas_equalTo(20);
         make.width.mas_equalTo(70);
         
     }];
    
}

@end
