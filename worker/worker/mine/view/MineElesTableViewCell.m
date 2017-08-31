//
//  MineElesTableViewCell.m
//  worker
//
//  Created by 郭健 on 2017/8/1.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "MineElesTableViewCell.h"

@implementation MineElesTableViewCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _image = [[UIImageView alloc] initWithFrame:CGRectMake(15, 7.5, 30, 30)];
        [self.contentView addSubview:_image];
        
        _name = [[UILabel alloc] initWithFrame:CGRectMake(55, 7.5, 100, 30)];
        _name.font = [UIFont systemFontOfSize:16];
        _name.textColor = [UIColor grayColor];
        _name.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_name];
        
    }
    
    return self;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
