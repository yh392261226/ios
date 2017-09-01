//
//  NormalTableViewCell.m
//  worker
//
//  Created by 郭健 on 2017/9/1.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "NormalTableViewCell.h"

@implementation NormalTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        
        _title = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, 80, 30)];
        
        _title.font = [UIFont systemFontOfSize:16];
        
        [self.contentView addSubview:_title];
        
        
        _data = [[UILabel alloc] initWithFrame:CGRectMake(100, 5, 300, 30)];
        
        _data.font = [UIFont systemFontOfSize:16];
        
        _data.textColor = [myselfway stringTOColor:@"0xC7C7CD"];
        
        [self.contentView addSubview:_data];
        
    }
    
    return self;
    
}

@end
