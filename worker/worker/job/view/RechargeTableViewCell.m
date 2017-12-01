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
        _logoimage = [[UILabel alloc] init];
        _logoimage.text = @"￥";
        _logoimage.font = [UIFont systemFontOfSize:20];
        [self.contentView addSubview:_logoimage];
        
        
        _textfield = [[UITextField alloc] init];
        _textfield.placeholder = @"请填写充值金额";
        _textfield.borderStyle = UITextBorderStyleNone;
        _textfield.keyboardType = UIKeyboardTypeNumberPad;
        [_textfield setValue:[UIFont boldSystemFontOfSize:17] forKeyPath:@"_placeholderLabel.font"];
        [self.contentView addSubview:_textfield];
    
        
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
         make.left.mas_equalTo(_logoimage).offset(25);
         make.top.mas_equalTo(self.contentView).offset(5);
         make.height.mas_equalTo(30);
         make.width.mas_equalTo(200);
     }];
    
}







@end
