//
//  PayTableViewCell.m
//  worker
//
//  Created by 郭健 on 2017/8/7.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "PayTableViewCell.h"

@implementation PayTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        
        
        _logoImage = [[UIImageView alloc] init];
        
         [self.contentView addSubview:_logoImage];
        
        
        _name = [[UILabel alloc] init];
        _name.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:_name];
        
        
        _selecd = [[UIImageView alloc] init];
        _selecd.layer.cornerRadius = 10;
        
        [self.contentView addSubview:_selecd];
        
        
        
        
    }
    
    return self;
    
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_logoImage mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.mas_equalTo(self.contentView).offset(25);
        make.top.mas_equalTo(self.contentView).offset(10);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(40);
    }];
    
    
    [_name mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.mas_equalTo(_logoImage).offset(55);
         make.top.mas_equalTo(self.contentView).offset(15);
         make.width.mas_equalTo(100);
         make.height.mas_equalTo(30);
     }];
    
    
    [_selecd mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.centerY.mas_equalTo(self.contentView);
         make.right.mas_equalTo(self.contentView).offset(-30);
         make.width.mas_equalTo(20);
         make.height.mas_equalTo(20);
     }];
}






@end
