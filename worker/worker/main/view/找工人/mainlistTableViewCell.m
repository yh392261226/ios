//
//  mainlistTableViewCell.m
//  Steel
//
//  Created by 郭健 on 2017/5/9.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "mainlistTableViewCell.h"

@implementation mainlistTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.backgroundColor = [myselfway stringTOColor:@"0xF1F1F1"];
        
        _name = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 200, 30)];
        _name.textAlignment = NSTextAlignmentLeft;
        _name.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_name];
        
        _image = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 50, 10, 20, 20)];
        [self.contentView addSubview:_image];
        
        
    }
    
    return self;
}

@end
