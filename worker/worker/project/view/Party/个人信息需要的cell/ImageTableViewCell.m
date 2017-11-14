//
//  ImageTableViewCell.m
//  worker
//
//  Created by 郭健 on 2017/9/8.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "ImageTableViewCell.h"

@implementation ImageTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        _image = [[UIImageView alloc] init];
        
        _image.layer.masksToBounds = YES;
        
        _image.layer.cornerRadius = 35;

        _image.image = [UIImage imageNamed:@"job_icon"];
        
        [self.contentView addSubview:_image];
        
        
        [_image mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.top.mas_equalTo(self.contentView).offset(15);
            make.centerX.mas_equalTo(self.contentView);
            make.width.mas_equalTo(70);
            make.height.mas_equalTo(70);
        }];
        
        
    }
    
    return self;
}

@end
