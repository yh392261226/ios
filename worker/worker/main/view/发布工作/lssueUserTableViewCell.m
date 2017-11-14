//
//  lssueUserTableViewCell.m
//  worker
//
//  Created by 郭健 on 2017/8/23.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "lssueUserTableViewCell.h"

@implementation lssueUserTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        _name = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, 80, 30)];
        
        _name.text = @"搜索范围:";
        
        _name.font = [UIFont systemFontOfSize:16];
        
        [self.contentView addSubview:_name];
        
        
        _data = [[UITextField alloc] initWithFrame:CGRectMake(100, 5, 300, 30)];
        
        _data.font = [UIFont systemFontOfSize:16];
        
        _data.placeholder = @"点击选择";
        
//      _data.enabled = NO;
        
        [self.contentView addSubview:_data];
        
    }

    return self;
}

@end
