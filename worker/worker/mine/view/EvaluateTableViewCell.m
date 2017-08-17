//
//  EvaluateTableViewCell.m
//  worker
//
//  Created by 郭健 on 2017/8/14.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "EvaluateTableViewCell.h"

@implementation EvaluateTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        _logoimage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 60, 60)];
        
        _logoimage.backgroundColor = [UIColor orangeColor];
        
        _logoimage.layer.cornerRadius = 30;
        
        [self.contentView addSubview:_logoimage];
        
        _title = [[UILabel alloc] init];
        _title.text = @"小伙子干活特别麻利，必须好评!";
        _title.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_title];
        
        _evaluate = [[UIImageView alloc] init];
        
        _evaluate.backgroundColor = [UIColor blueColor];
        
        [self.contentView addSubview:_evaluate];
        
        
        
        _timer = [[UILabel alloc] init];
        
        _timer.text = @"2017年03月1号 12:12";
        
        _timer.textAlignment = NSTextAlignmentRight;
        
        _timer.font = [UIFont systemFontOfSize:14];
        
        _timer.textColor = [UIColor grayColor];
        
        [self.contentView addSubview:_timer];
        
        
        
    }
    
    
    return self;
}




- (void)layoutSubviews
{
    [super layoutSubviews];

    [_title mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.mas_equalTo(_logoimage).offset(70);
        make.top.mas_equalTo(self.contentView).offset(5);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(250);
    }];
    
    [_evaluate mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.mas_equalTo(_logoimage).offset(70);
         make.bottom.mas_equalTo(self.contentView).offset(-10);
         make.height.mas_equalTo(25);
         make.width.mas_equalTo(100);
     }];
    
    
    
    [_timer mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.right.mas_equalTo(self.contentView).offset(-15);
         make.bottom.mas_equalTo(self.contentView).offset(-5);
         make.height.mas_equalTo(30);
         make.width.mas_equalTo(150);
     }];
    
}















@end
