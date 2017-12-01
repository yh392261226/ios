//
//  EditworkerCollectionViewCell.m
//  worker
//
//  Created by 郭健 on 2017/8/14.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "EditworkerCollectionViewCell.h"

@implementation EditworkerCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        _workerName = [[UILabel alloc] init];
        
        _workerName.layer.borderColor = [[UIColor grayColor] CGColor];
        
        _workerName.layer.cornerRadius = 10;
        
        _workerName.layer.borderWidth = 0.5f;
        
        _workerName.layer.masksToBounds = YES;
        
        _workerName.font = [UIFont systemFontOfSize:14];
        
        _workerName.textAlignment = NSTextAlignmentCenter;
        
        [self.contentView addSubview:_workerName];
        
        
        _logoImage = [[UIImageView alloc] init];
        _logoImage.layer.cornerRadius = 5;
        _logoImage.image = [UIImage imageNamed:@"job_ddee"];
        [self.contentView addSubview:_logoImage];
        
        [_logoImage mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.top.mas_equalTo(_workerName).offset(-2.5);
             make.width.mas_equalTo(10);
             make.right.mas_equalTo(_workerName).offset(2.5);
             make.height.mas_equalTo(10);
         }];
        
    }
    
    return self;
    
}



- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_workerName mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.mas_equalTo(self.contentView).offset(5);
         make.left.mas_equalTo(self.contentView).offset(5);
         make.right.mas_equalTo(self.contentView).offset(-5);
         make.bottom.mas_equalTo(self.contentView).offset(-5);
     }];
    
    
    
    
    
}

@end
