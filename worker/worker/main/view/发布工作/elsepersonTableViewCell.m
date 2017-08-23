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
        
        _money.font = [UIFont systemFontOfSize:14];
        
        [self.contentView addSubview:_money];
        
        
        _moneyfield = [[UITextField alloc] init];
        
        _moneyfield.placeholder = @"输入工人工资";
        
        [self.contentView addSubview:_moneyfield];
        
        
        _person = [[UILabel alloc] init];
        
        _person.font = [UIFont systemFontOfSize:14];
        
        _person.textAlignment = NSTextAlignmentRight;
        
        _person.text = @"人";
        
        [self.contentView addSubview:_person];
        
        
        _personfield = [[UITextField alloc] init];
        
        _personfield.placeholder = @"输入招工个数";
        
        [self.contentView addSubview:_personfield];
        
        
        
    }
    
    
    return self;

}



- (void)layoutSubviews
{
    [super layoutSubviews];
    
    

}


















@end
