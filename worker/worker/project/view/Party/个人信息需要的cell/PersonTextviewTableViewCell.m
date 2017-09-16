//
//  PersonTextviewTableViewCell.m
//  worker
//
//  Created by 郭健 on 2017/9/8.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "PersonTextviewTableViewCell.h"

@implementation PersonTextviewTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        _name = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, 200, 30)];
        
        _name.font = [UIFont systemFontOfSize:15];
        
        [self.contentView addSubview:_name];
        
        
        _textview = [[UITextView alloc] initWithFrame:CGRectMake(20, 37, SCREEN_WIDTH - 40, 70)];
        
        _textview.font = [UIFont systemFontOfSize:15];
        
        [self.contentView addSubview:_textview];
        
    }

    
    return self;
}

@end
