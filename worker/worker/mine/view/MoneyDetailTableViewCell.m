//
//  MoneyDetailTableViewCell.m
//  worker
//
//  Created by 郭健 on 2017/8/15.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "MoneyDetailTableViewCell.h"

@implementation MoneyDetailTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _title = [[UILabel alloc] init];
        _title.font = [UIFont systemFontOfSize:15];
        _title.text = @"提现";
        [self.contentView addSubview:_title];
        
        _balance = [[UILabel alloc] init];
        _balance.font = [UIFont systemFontOfSize:13];
        _balance.textColor = [UIColor grayColor];
        _balance.text = @"余额: 200.00";
        [self.contentView addSubview:_balance];
        
        _time = [[UILabel alloc] init];
        _time.font = [UIFont systemFontOfSize:13];
        _time.textColor = [UIColor grayColor];
        _time.textAlignment = NSTextAlignmentRight;
        _time.text = @"2017-04-34";
        [self.contentView addSubview:_time];
        
        _money = [[UILabel alloc] init];
        _money.font = [UIFont systemFontOfSize:17];
        _money.textAlignment = NSTextAlignmentRight;
        _money.text = @"+100.00";
        [self.contentView addSubview:_money];
        
        
    }

    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_title mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.mas_equalTo(self.contentView).offset(25);
        make.top.mas_equalTo(self.contentView).offset(7);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(150);
        
    }];
    
    [_balance mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.mas_equalTo(self.contentView).offset(25);
         make.bottom.mas_equalTo(self.contentView).offset(-5);
         make.height.mas_equalTo(20);
         make.width.mas_equalTo(150);
         
     }];
    
    
    [_money mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.right.mas_equalTo(self.contentView).offset(-25);
         make.bottom.mas_equalTo(self.contentView).offset(-3);
         make.height.mas_equalTo(30);
         make.width.mas_equalTo(150);
         
     }];
    
    [_time mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.right.mas_equalTo(self.contentView).offset(-25);
         make.top.mas_equalTo(self.contentView).offset(7);
         make.height.mas_equalTo(20);
         make.width.mas_equalTo(150);
         
     }];
    

}



















@end
