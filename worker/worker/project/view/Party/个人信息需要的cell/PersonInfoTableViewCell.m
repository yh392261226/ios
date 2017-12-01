//
//  PersonInfoTableViewCell.m
//  worker
//
//  Created by 郭健 on 2017/9/8.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "PersonInfoTableViewCell.h"

@implementation PersonInfoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        _name = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, 200, 30)];
        
        _name.font = [UIFont systemFontOfSize:15];
        
        [self.contentView addSubview:_name];
        
        
        _data = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 250, 5, 235, 30)];
        
        _data.textAlignment = NSTextAlignmentRight;
        
        _data.font = [UIFont systemFontOfSize:15];
        
        [self.contentView addSubview:_data];
    }
    
    return self;
}

@end
