//
//  packetTableViewCell.m
//  worker
//
//  Created by sd on 2017/9/30.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "packetTableViewCell.h"

@implementation packetTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        _money = [[UILabel alloc] initWithFrame:CGRectMake(25, 10, 100, 30)];
        
        _money.font = [UIFont systemFontOfSize:17];
        
        _money.textColor = [UIColor redColor];
        
        [self.contentView addSubview:_money];
        
    }
    
    return self;;
    
}

@end
