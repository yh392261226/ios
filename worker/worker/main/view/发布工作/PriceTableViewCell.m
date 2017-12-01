//
//  PriceTableViewCell.m
//  worker
//
//  Created by sd on 2017/10/14.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "PriceTableViewCell.h"

@implementation PriceTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        
        _backview = [[UIView alloc] init];
        
        _backview.layer.cornerRadius = 5;
        
        _backview.backgroundColor = [myselfway stringTOColor:@"0xF9F9F9"];
        
        [self.contentView addSubview:_backview];
        
        [_backview mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.top.mas_equalTo(self.contentView).offset(5);
             make.left.mas_equalTo(self.contentView).offset(10);
             make.right.mas_equalTo(self.contentView).offset(-10);
             make.bottom.mas_equalTo(self.contentView).offset(-5);
         }];
        
        
        _money = [[UILabel alloc] initWithFrame:CGRectMake(25, 10, 250, 30)];
        
        _money.font = [UIFont systemFontOfSize:22];
        
        _money.text = @"5元优惠券";
        
        _money.textColor = [UIColor redColor];
        
        [self.contentView addSubview:_money];
        
        
        
        _text = [[UILabel alloc] init];
        
        _text.font = [UIFont systemFontOfSize:15];
        
        _text.text = @"领取后直接转入余额";
        
        _text.textColor = [UIColor blackColor];
        
        [self.contentView addSubview:_text];
        
        
        _time = [[UILabel alloc] init];
        
        _time.font = [UIFont systemFontOfSize:15];
        
        _time.text = @"领取期限2017.02.23 - 2017.05.03";
        
        _time.textColor = [UIColor blackColor];
        
        [self.contentView addSubview:_time];
        
        
        _seleced = [[UIImageView alloc] init];
        
        _seleced.layer.cornerRadius = 10;
        
        [self.contentView addSubview:_seleced];
        
        
    }
    
    return self;
    
}


- (void)layoutSubviews
{
    
    
    [_text mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_money).offset(35);
        make.left.mas_equalTo(self.contentView).offset(25);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(20);
    }];
    
    
    [_time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_text).offset(25);
        make.left.mas_equalTo(self.contentView).offset(25);
        make.width.mas_equalTo(300);
        make.height.mas_equalTo(20);
    }];
    
    
    [_seleced mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.right.mas_equalTo(self.contentView).offset(-30);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);
    }];
    
    
}


@end
