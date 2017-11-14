//
//  PersonWorTableViewCell.m
//  worker
//
//  Created by 郭健 on 2017/9/8.
//  Copyright © 2017年 郭健. All rights reserved.
//



#define num 4




#import "PersonWorTableViewCell.h"

@implementation PersonWorTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        number = 4;
        
        
    }
    
    return self;
}




- (void)setDataArray:(NSMutableArray *)dataArray
{
    _dataArray = dataArray;
    
    for (int i = 0; i < _dataArray.count; i++)
    {
        
        _workerName = [[UILabel alloc] init];
        
        _workerName.layer.borderColor = [[UIColor grayColor] CGColor];
        
        _workerName.layer.cornerRadius = 10;
        
        _workerName.layer.borderWidth = 0.5f;
        
        _workerName.layer.masksToBounds = YES;
        
        _workerName.font = [UIFont systemFontOfSize:14];
        
        _workerName.textAlignment = NSTextAlignmentCenter;
        
        _workerName.text = [_dataArray objectAtIndex:i];
        
        [self.contentView addSubview:_workerName];
        
        
        
        if (i < 4)
        {
            [_workerName mas_makeConstraints:^(MASConstraintMaker *make)
             {
                 make.top.mas_equalTo(self.contentView).offset(5);
                 make.left.mas_equalTo(self.contentView).offset(i * (SCREEN_WIDTH / 4) + 5);
                 make.width.mas_equalTo(SCREEN_WIDTH / 4 - 10);
                 make.height.mas_equalTo(30);
             }];
        }
        else
        {
            number = i - 4;
            
            [_workerName mas_makeConstraints:^(MASConstraintMaker *make)
             {
                 make.top.mas_equalTo(self.contentView).offset(40);
                 make.left.mas_equalTo(self.contentView).offset(number * (SCREEN_WIDTH / 4) + 5);
                 make.width.mas_equalTo(SCREEN_WIDTH / 4 - 10);
                 make.height.mas_equalTo(30);
             }];
        }
        
    }
    
    
    
    
}



- (void)layoutSubviews
{
    [super layoutSubviews];
    
}
























@end
