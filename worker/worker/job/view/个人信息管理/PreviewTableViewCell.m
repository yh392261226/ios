//
//  PreviewTableViewCell.m
//  worker
//
//  Created by 郭健 on 2017/8/10.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "PreviewTableViewCell.h"

@implementation PreviewTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    
    if (self)
    {
        _name = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, 150, 30)];
        _name.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_name];
        
        
        _data = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 200, 5, 180, 30)];
        _data.font = [UIFont systemFontOfSize:14];
        _data.textAlignment = NSTextAlignmentRight;
        _data.textColor = [UIColor grayColor];
        [self.contentView addSubview:_data];
        
    }
    
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
}







@end
