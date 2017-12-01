//
//  DomFirstCollectionViewCell.m
//  worker
//
//  Created by 郭健 on 2017/9/6.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "DomFirstCollectionViewCell.h"

@implementation DomFirstCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        _icon = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 70, 70)];
        
    //    _icon.backgroundColor = [UIColor greenColor];
        
        _icon.image = [UIImage imageNamed:@"job_icon"];
        
        _icon.layer.masksToBounds = YES;
        
        _icon.layer.cornerRadius = 35;
        
        [self.contentView addSubview:_icon];
        
        _name = [[UILabel alloc] init];
        
        _name.text = @"王二妮";
        
        _name.font = [UIFont systemFontOfSize:16];
        
        [self.contentView addSubview:_name];
        
        
        [_name mas_makeConstraints:^(MASConstraintMaker *make)
         {
            make.top.mas_equalTo(self.contentView).offset(10);
             make.left.mas_equalTo(_icon).offset(90);
             make.width.mas_equalTo(77);
             make.height.mas_equalTo(21);
        }];
        
        
        
        
        _worker = [[UILabel alloc] init];
        
        _worker.font = [UIFont systemFontOfSize:13];
        
        _worker.textColor = [UIColor grayColor];
        
        _worker.text = @"保洁  保洁   保洁";
        
        [self.contentView addSubview:_worker];
        
        
        [_worker mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.top.mas_equalTo(_name).offset(25);
             make.left.mas_equalTo(_icon).offset(90);
             make.width.mas_equalTo(200);
             make.height.mas_equalTo(21);
         }];
        
        
        _comment = [[UILabel alloc] init];
        
        _comment.text = @"好评10次";
        
        _comment.textColor = [UIColor redColor];
        
        _comment.font = [UIFont systemFontOfSize:17];
        
        [self.contentView addSubview:_comment];
        
        [_comment mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.top.mas_equalTo(_worker).offset(30);
             make.left.mas_equalTo(_icon).offset(90);
             make.width.mas_equalTo(200);
             make.height.mas_equalTo(21);
         }];
        
        
        _sex = [[UIImageView alloc] init];
        
        _sex.image = [UIImage imageNamed:@"job_man"];
        
        [self.contentView addSubview:_sex];
        
        [_sex mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.top.mas_equalTo(self.contentView).offset(10);
            make.left.mas_equalTo(_name).offset(70);
            make.width.mas_equalTo(20);
            make.height.mas_equalTo(20);
        }];
        
        
    }
    
    
    return self;
}




@end
