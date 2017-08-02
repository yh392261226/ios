//
//  ElseTableViewCell.m
//  worker
//
//  Created by 郭健 on 2017/8/1.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "ElseTableViewCell.h"

@implementation ElseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _title = [[UILabel alloc] init];
        _title.frame = CGRectMake(20, 15, 200, 30);
        _title.font = [UIFont boldSystemFontOfSize:15];
        _title.textColor = [myselfway stringTOColor:@"0x2E84F8"];
        [self.contentView addSubview:_title];
        
        _image = [[UIImageView alloc] init];
        _image.frame = CGRectMake(SCREEN_WIDTH - 50, 15, 30, 30);
        _image.image = [UIImage imageNamed:@"job_right"];
        [self.contentView addSubview:_image];
        
    }
    
    return self;
}


@end
