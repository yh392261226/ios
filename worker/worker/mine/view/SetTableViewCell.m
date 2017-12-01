//
//  SetTableViewCell.m
//  worker
//
//  Created by 郭健 on 2017/8/14.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "SetTableViewCell.h"

@implementation SetTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        _name = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 100, 30)];
        
        _name.textAlignment = NSTextAlignmentLeft;
        
        _name.textColor = [UIColor grayColor];
        
        _name.font = [UIFont systemFontOfSize:15];
        
        [self.contentView addSubview:_name];
        
        
        
        _data = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 150, 5, 120, 30)];
        _data.textAlignment = NSTextAlignmentRight;
        _data.textColor = [UIColor grayColor];
        _data.font = [UIFont systemFontOfSize:15];
        
        [self.contentView addSubview:_data];
        
        
    }
    
    
    return self;
}

@end
