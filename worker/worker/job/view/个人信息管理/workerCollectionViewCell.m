//
//  workerCollectionViewCell.m
//  worker
//
//  Created by 郭健 on 2017/8/11.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "workerCollectionViewCell.h"

@implementation workerCollectionViewCell


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
