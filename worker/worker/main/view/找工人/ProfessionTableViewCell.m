//
//  ProfessionTableViewCell.m
//  worker
//
//  Created by 郭健 on 2017/7/31.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "ProfessionTableViewCell.h"

@implementation ProfessionTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.backgroundColor = [myselfway stringTOColor:@"0xC4CED3"];
        
        _backview = [[UIView alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH - 20, 70)];
        _backview.backgroundColor = [UIColor whiteColor];
        _backview.layer.cornerRadius = 8;
        [self.contentView addSubview:_backview];
        
        _logoImage = [[UIImageView alloc] init];
        _logoImage.frame = CGRectMake(25, 10, 50, 50);
        _logoImage.backgroundColor = [UIColor redColor];
        _logoImage.layer.cornerRadius = 5;
        [_backview addSubview:_logoImage];
        
        _worker = [[UILabel alloc] init];
        _worker.font = [UIFont systemFontOfSize:16];
        _worker.frame = CGRectMake(100, 25, 300, 20);
        _worker.textColor = [UIColor grayColor];
        [_backview addSubview:_worker];
        
    }
    
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
    
}






@end
