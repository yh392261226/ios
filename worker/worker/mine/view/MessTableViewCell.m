//
//  MessTableViewCell.m
//  worker
//
//  Created by 郭健 on 2017/8/3.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "MessTableViewCell.h"

@implementation MessTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        _title = [[UILabel alloc] init];
        
        _title.font = [UIFont systemFontOfSize:15];
        
        _title.text = @"工作邀约";
        
        [self.contentView addSubview:_title];
        
        _detail = [[UILabel alloc] init];
        
        _detail.textColor = [UIColor grayColor];
        
        _detail.font = [UIFont systemFontOfSize:13];
        
        _detail.text = @"我于杀戮之中盛放, 亦如黎明中的花朵";
        
        [self.contentView addSubview:_detail];
        
        _time = [[UILabel alloc] init];
        
        _time.font = [UIFont systemFontOfSize:14];
        
        _time.textAlignment = NSTextAlignmentRight;
        
        _time.text = @"2017/03/08";
        
        [self.contentView addSubview:_time];
        
        
        
        _look = [[UILabel alloc] init];
        
        _look.layer.borderColor = [[UIColor grayColor] CGColor];
        
        _look.text = @"点击查看";
        
        _look.textColor = [UIColor grayColor];
        
        _look.layer.cornerRadius = 10;
        
        _look.layer.borderWidth = 0.5f;
        
        _look.layer.masksToBounds = YES;
        
        _look.font = [UIFont systemFontOfSize:14];
        
        _look.textAlignment = NSTextAlignmentCenter;
        
        [self.contentView addSubview:_look];
        
        
        
        
    }
    
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_title mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.top.mas_equalTo(self.contentView).offset(10);
        make.left.mas_equalTo(self.contentView).offset(15);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(200);
        
    }];
    
    [_time mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.mas_equalTo(self.contentView).offset(5);
         make.right.mas_equalTo(self.contentView).offset(-15);
         make.height.mas_equalTo(20);
         make.width.mas_equalTo(200);
         
     }];
    
    
    [_detail mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.mas_equalTo(_title).offset(25);
         make.left.mas_equalTo(self.contentView).offset(15);
         make.height.mas_equalTo(20);
         make.width.mas_equalTo(SCREEN_WIDTH - 100);
         
     }];
    
    [_look mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.bottom.mas_equalTo(self.contentView).offset(-5);
         make.right.mas_equalTo(self.contentView).offset(-15);
         make.height.mas_equalTo(25);
         make.width.mas_equalTo(80);
         
     }];
}






@end
