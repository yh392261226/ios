//
//  TypeView.m
//  worker
//
//  Created by 郭健 on 2017/8/8.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "TypeView.h"

@implementation TypeView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        
    
    }
    
    return self;
    
}



- (void)setNameArray:(NSMutableArray *)nameArray
{
    _nameArray = nameArray;
    
    for (int i = 0; i < self.nameArray.count; i++)
    {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
        _btn.tag = 500 + i;
        
        [_btn addTarget:self action:@selector(selecedbtn:) forControlEvents:UIControlEventTouchUpInside];
        
        _btn.frame = CGRectMake(i * (SCREEN_WIDTH / self.nameArray.count), 0, SCREEN_WIDTH / self.nameArray.count, 40);
        
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
        
        
        _name.text = [self.nameArray objectAtIndex:i];
        
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
    for (int i = 0; i < self.nameArray.count; i++)
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
}


@end
