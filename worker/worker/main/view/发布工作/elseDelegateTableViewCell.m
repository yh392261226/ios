//
//  elseDelegateTableViewCell.m
//  worker
//
//  Created by 郭健 on 2017/8/24.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "elseDelegateTableViewCell.h"

@implementation elseDelegateTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        _deleteWorker = [[UILabel alloc] init];
        
        _deleteWorker.textAlignment = NSTextAlignmentCenter;
        
        _deleteWorker.textColor = [UIColor whiteColor];
        
        _deleteWorker.text = @"删除该工种";
        
        _deleteWorker.layer.cornerRadius = 8;
        
        _deleteWorker.backgroundColor = [UIColor grayColor];
        
        _deleteWorker.layer.masksToBounds = YES;
        
        _deleteWorker.font = [UIFont systemFontOfSize:14];
        
        [self.contentView addSubview:_deleteWorker];
        
    }

    return self;
}


- (void)layoutSubviews
{
  
    [super layoutSubviews];
    
    [_deleteWorker mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.top.mas_equalTo(self.contentView).offset(5);
        make.left.mas_equalTo(self.contentView).offset(40);
        make.right.mas_equalTo(self.contentView).offset(-40);
        make.bottom.mas_equalTo(self.contentView).offset(-5);
    }];


}











@end
