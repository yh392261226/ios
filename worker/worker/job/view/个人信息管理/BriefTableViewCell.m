//
//  BriefTableViewCell.m
//  worker
//
//  Created by 郭健 on 2017/8/10.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "BriefTableViewCell.h"

@implementation BriefTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        _name = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, 150, 30)];
        _name.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_name];
        
        
        _data = [[UITextView alloc] init];
        _data.font = [UIFont systemFontOfSize:14];
        _data.textColor = [UIColor grayColor];
        [self.contentView addSubview:_data];
        
    }
    
    return self;
}



- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_data mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.top.mas_equalTo(_name).offset(30);
        make.left.mas_equalTo(self.contentView).offset(15);
        make.right.mas_equalTo(self.contentView).offset(-15);
        make.height.mas_equalTo(100);
    }];
}


@end
