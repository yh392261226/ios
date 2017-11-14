//
//  winView.m
//  worker
//
//  Created by ios_g on 2017/11/10.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "winView.h"

@implementation winView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        _title = [[UILabel alloc] init];
        
        _title.font = [UIFont systemFontOfSize:15];
        
    
        
        [self addSubview:_title];
        
        _detail = [[UITextView alloc] init];
        
        _detail.textColor = [UIColor grayColor];
        
        _detail.font = [UIFont systemFontOfSize:13];
        
        _detail.userInteractionEnabled = NO;
        
     
        
        [self addSubview:_detail];
        
        _time = [[UILabel alloc] init];
        
        _time.font = [UIFont systemFontOfSize:14];
        
        _time.textAlignment = NSTextAlignmentRight;
        
     
        
        [self addSubview:_time];
    }
    
    return self;
    
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
    [_title mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.mas_equalTo(self).offset(7);
         make.left.mas_equalTo(self).offset(15);
         make.height.mas_equalTo(20);
         make.width.mas_equalTo(200);
         
     }];
    
    [_time mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.mas_equalTo(self).offset(5);
         make.right.mas_equalTo(self).offset(-15);
         make.height.mas_equalTo(20);
         make.width.mas_equalTo(200);
         
     }];
    
    
    [_detail mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.mas_equalTo(_title).offset(25);
         make.left.mas_equalTo(self).offset(15);
         make.height.mas_equalTo(100);
         make.right.mas_equalTo(self).offset(-15);
         
     }];
    
    
    
    
    
}




@end
