//
//  MainTableViewCell.m
//  worker
//
//  Created by 郭健 on 2017/7/27.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "MainTableViewCell.h"

@implementation MainTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        _worker = [[UIImageView alloc] init];
        _worker.backgroundColor = [UIColor orangeColor];
        [self.contentView addSubview:_worker];
        
    }
    
    return self;
}



- (void)layoutSubviews
{
   [_worker mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.top.mas_equalTo(self.contentView).offset(5);
        make.left.mas_equalTo(self.contentView).offset(10);
        make.right.mas_equalTo(self.contentView).offset(-10);
        make.bottom.mas_equalTo(self.contentView).offset(-5);
   }];
    
}






@end
