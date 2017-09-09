//
//  PersonEvaTableViewCell.m
//  worker
//
//  Created by 郭健 on 2017/9/8.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "PersonEvaTableViewCell.h"

@implementation PersonEvaTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self = [[[NSBundle mainBundle] loadNibNamed:@"worker" owner:self options:nil] objectAtIndex:2];
        
        _icon.backgroundColor = [UIColor redColor];
        
        _icon.layer.masksToBounds = YES;
        
        _icon.layer.cornerRadius = 25;
        
    }
    
    return self;
}

@end
