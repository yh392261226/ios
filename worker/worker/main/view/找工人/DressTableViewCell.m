//
//  DressTableViewCell.m
//  worker
//
//  Created by 郭健 on 2017/8/17.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "DressTableViewCell.h"

@implementation DressTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.backgroundColor = [myselfway stringTOColor:@"0xC4CED3"];
        
        _backview = [[UIView alloc] init];
        
        _backview.backgroundColor = [UIColor whiteColor];
        
        _backview.layer.cornerRadius = 8;
        
        [self.contentView addSubview:_backview];
        
        
        
        
        _detail = [[UILabel alloc] init];
        
        _detail.font = [UIFont systemFontOfSize:15];
        
   //     _detail.text = @"阿卡积分厚大司考结果还是考过了fhjk";
    
        [_backview addSubview:_detail];
        
        
        
        _close = [UIButton buttonWithType:UIButtonTypeCustom];
        
        
        
        [_close setBackgroundImage:[UIImage imageNamed:@"main_close"] forState:UIControlStateNormal];
        
        [_backview addSubview:_close];
        
        
    }
    
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_backview mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.top.mas_equalTo(self.contentView).offset(5);
        make.left.mas_equalTo(self.contentView).offset(10);
        make.right.mas_equalTo(self.contentView).offset(-10);
        make.bottom.mas_equalTo(self.contentView).offset(-2.5);
    }];
    
    
    [_detail mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.mas_equalTo(_backview).offset(0);
         make.left.mas_equalTo(_backview).offset(15);
         make.width.mas_equalTo(259);
         make.bottom.mas_equalTo(_backview).offset(0);
     }];
    
    
    
    [_close mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.mas_equalTo(_backview).offset(3.5);
         make.right.mas_equalTo(_backview).offset(-2.5);
         make.width.mas_equalTo(25);
         make.height.mas_equalTo(25);
     }];

    
}

@end
