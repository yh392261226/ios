//
//  elsepersonTableViewCell.m
//  worker
//
//  Created by 郭健 on 2017/8/23.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "elsepersonTableViewCell.h"

@implementation elsepersonTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        _money = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 100, 5, 85, 30)];
        
        _money.textAlignment = NSTextAlignmentRight;
        
        _money.text = @"元/人/天";
        
        _money.font = [UIFont systemFontOfSize:15];
        
        [self.contentView addSubview:_money];
        
        
        _moneyfield = [[UITextField alloc] init];
        
        _moneyfield.textAlignment = NSTextAlignmentRight;
        
        _moneyfield.placeholder = @"输入工人工资";
        
        [self.moneyfield setValue:[UIFont systemFontOfSize:16.0] forKeyPath:@"_placeholderLabel.font"];
        
        [self.contentView addSubview:_moneyfield];
        

        
        _person = [[UILabel alloc] init];
        
        _person.font = [UIFont systemFontOfSize:15];
        
        _person.textAlignment = NSTextAlignmentRight;
        
        _person.text = @"人";
        
        [self.contentView addSubview:_person];
        
        
        _personfield = [[UITextField alloc] init];
        
        _personfield.textAlignment = NSTextAlignmentRight;
        
        _personfield.placeholder = @"输入招工个数";
        
        [self.personfield setValue:[UIFont systemFontOfSize:16.0] forKeyPath:@"_placeholderLabel.font"];
        
        [self.contentView addSubview:_personfield];
        
        
        
    }
    
    
    return self;

}



- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_moneyfield mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.right.mas_equalTo(_money).offset(-65);
        make.top.mas_equalTo(self.contentView).offset(7);
        make.width.mas_equalTo(110);
        make.height.mas_equalTo(30);
    }];
    
    
    
    [_person mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.right.mas_equalTo(_moneyfield).offset(-120);
         make.top.mas_equalTo(self.contentView).offset(5);
         make.width.mas_equalTo(20);
         make.height.mas_equalTo(30);
     }];
    
    
    [_personfield mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.right.mas_equalTo(_person).offset(-25);
         make.top.mas_equalTo(self.contentView).offset(7);
         make.width.mas_equalTo(107);
         make.height.mas_equalTo(30);
     }];
    

}


















@end
