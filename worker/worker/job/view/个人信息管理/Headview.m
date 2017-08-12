//
//  Headview.m
//  worker
//
//  Created by 郭健 on 2017/8/9.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "Headview.h"

@implementation Headview

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        _Icon = [[UIImageView alloc] init];
        
        _Icon.image = [UIImage imageNamed:@"job_icon"];
        
        [self addSubview:_Icon];
        
        
        _btnIcon = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [self addSubview:_btnIcon];
        
        
        
        _logoimage = [[UIImageView alloc] init];
        
        [self addSubview:_logoimage];
        
        _introduce = [[UILabel alloc] init];
        
        _introduce.font = [UIFont systemFontOfSize:12];
        
        _introduce.numberOfLines = 2;
        
        _introduce.text = @"上传真实头像能极大提高洽谈几率";
        
        _introduce.textColor = [UIColor grayColor];
        
        [self addSubview:_introduce];
        
        
        _line = [[UIView alloc] initWithFrame:CGRectMake(0, 69, SCREEN_WIDTH, 1)];
        _line.backgroundColor = [myselfway stringTOColor:@"0x808080"];
        [self addSubview:_line];
        
        
        
        
        
    }
    
    
    return self;
}



- (void)setDataArray:(NSMutableArray *)dataArray
{
    _dataArray = dataArray;
    
    for (int i = 0; i < self.dataArray.count; i++)
    {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _btn.tag = 500 + i;
        
        [_btn addTarget:self action:@selector(selecedbtn:) forControlEvents:UIControlEventTouchUpInside];
        
        _btn.frame = CGRectMake(i * (SCREEN_WIDTH / self.dataArray.count), 70, SCREEN_WIDTH / self.dataArray.count, 40);
        
        [self addSubview:_btn];
        
        _name = [[UILabel alloc] init];
        
        if (i == 0)
        {
            _name.textColor = [UIColor redColor];
        }
        else
        {
            _name.textColor = [UIColor grayColor];
        }
        
        _name.tag = 600 + i;
        
        
        _name.text = [self.dataArray objectAtIndex:i];
        
        _name.font = [UIFont systemFontOfSize:16];
        
        _name.textAlignment = NSTextAlignmentCenter;
        
        
        
        [_btn addSubview:_name];
        
        [_name mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.centerX.mas_equalTo(_btn);
             make.centerY.mas_equalTo(_btn);
             make.height.mas_equalTo(30);
             make.width.mas_equalTo(100);
         }];
        
    }
    
    
}


- (void)selecedbtn: (UIButton *)btn
{
    for (int i = 0; i < self.dataArray.count; i++)
    {
        UILabel *label = [self viewWithTag:600 + i];
        
        if (btn.tag == 500 + i)
        {
            label.textColor = [UIColor redColor];
        }
        else
        {
            label.textColor = [UIColor grayColor];
        }
        
    }
    
    
    [self.delegate tempVal:btn.tag];
}




- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
    [_Icon mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self).offset(10);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    [_btnIcon mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.centerX.mas_equalTo(self);
         make.top.mas_equalTo(self).offset(10);
         make.width.mas_equalTo(50);
         make.height.mas_equalTo(50);
     }];
    
    
    [_introduce mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.mas_equalTo(_Icon).offset(70);
         make.top.mas_equalTo(self).offset(15);
         make.width.mas_equalTo(100);
         make.height.mas_equalTo(40);
     }];
    
}

















@end
