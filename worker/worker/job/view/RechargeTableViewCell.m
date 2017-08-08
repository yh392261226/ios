//
//  RechargeTableViewCell.m
//  worker
//
//  Created by 郭健 on 2017/8/7.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "RechargeTableViewCell.h"

@implementation RechargeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        _logoimage = [[UIImageView alloc] init];
        _logoimage.backgroundColor = [UIColor orangeColor];
        [self.contentView addSubview:_logoimage];
        
        
        _textfield = [[UITextField alloc] init];
        _textfield.placeholder = @"请填写充值金额";
        _textfield.borderStyle = UITextBorderStyleNone;
        _textfield.keyboardType = UIKeyboardTypeNumberPad;
        [_textfield setValue:[UIFont boldSystemFontOfSize:17] forKeyPath:@"_placeholderLabel.font"];
        [self.contentView addSubview:_textfield];
        
        _line = [[UIView alloc] init];
        _line.backgroundColor = [myselfway stringTOColor:@"0x808080"];
        _line.frame = CGRectMake(20, 39, SCREEN_WIDTH - 40, 1);
        [self.contentView addSubview:_line];
        
    }
    
    return self;
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_logoimage mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.mas_equalTo(self.contentView).offset(20);
        make.top.mas_equalTo(self.contentView).offset(10);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(20);
    }];
    
    
    [_textfield mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.mas_equalTo(_logoimage).offset(35);
         make.top.mas_equalTo(self.contentView).offset(5);
         make.height.mas_equalTo(30);
         make.width.mas_equalTo(200);
     }];
    
}







@end
