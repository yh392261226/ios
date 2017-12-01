//
//  EdirAddTableViewCell.m
//  worker
//
//  Created by 郭健 on 2017/8/14.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "EdirAddTableViewCell.h"

@implementation EdirAddTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        _AddImage = [[UIImageView alloc] init];
        
        _AddImage.frame = CGRectMake(20, 10, 30, 30);
        
        _AddImage.image = [UIImage imageNamed:@"job_add"];
        
        [self.contentView addSubview:_AddImage];
        
        
//        [_AddImage mas_makeConstraints:^(MASConstraintMaker *make)
//         {
//             make.top.mas_equalTo(self.contentView).offset(10);
//             make.left.mas_equalTo(self.contentView).offset(20);
//             make.width.mas_equalTo(30);
//             make.height.mas_equalTo(30);
//         }];
    
    }
    
    return self;
}


//- (void)layoutSubviews
//{
//    [super layoutSubviews];
//    
//    
//    
//}








@end
