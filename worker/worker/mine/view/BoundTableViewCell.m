//
//  BoundTableViewCell.m
//  worker
//
//  Created by 郭健 on 2017/9/1.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "BoundTableViewCell.h"

@implementation BoundTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        _field = [[UITextField alloc] initWithFrame:CGRectMake(25, 10, 300, 30)];
        
        _field.borderStyle = UITextBorderStyleNone;
        
        [self.contentView addSubview:_field];
        
    }
 
    return self;
}

@end
