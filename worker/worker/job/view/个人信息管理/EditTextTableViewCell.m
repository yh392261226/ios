//
//  EditTextTableViewCell.m
//  worker
//
//  Created by 郭健 on 2017/8/11.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "EditTextTableViewCell.h"

@implementation EditTextTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        _name = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, 150, 30)];
        _name.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_name];
        
        
        _field = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 200, 5, 180, 30)];
        _field.font = [UIFont systemFontOfSize:14];
        _field.textAlignment = NSTextAlignmentRight;
        _field.textColor = [UIColor grayColor];
        [self.contentView addSubview:_field];
        
    }
    
    return self;
}



- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_field mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.mas_equalTo(_name).offset(30);
         make.left.mas_equalTo(self.contentView).offset(15);
         make.right.mas_equalTo(self.contentView).offset(-15);
         make.height.mas_equalTo(100);
     }];
}

@end
