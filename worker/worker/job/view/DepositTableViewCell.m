//
//  DepositTableViewCell.m
//  worker
//
//  Created by 郭健 on 2017/9/5.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "DepositTableViewCell.h"

@implementation DepositTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        _name = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, 80, 30)];
        
        _name.font = [UIFont systemFontOfSize:16];
        
        _name.textAlignment = NSTextAlignmentCenter;
        
        [self.contentView addSubview:_name];
        
        _data = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 180, 5, 150, 30)];
        
        _data.textAlignment = NSTextAlignmentRight;
        
        _data.font = [UIFont systemFontOfSize:15];
        
        _data.textColor = [UIColor grayColor];
        
       
        
        [self.contentView addSubview:_data];
        
    }
    
    
    return self;
}

@end
