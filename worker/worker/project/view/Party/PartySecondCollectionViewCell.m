//
//  PartySecondCollectionViewCell.m
//  worker
//
//  Created by 郭健 on 2017/9/6.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "PartySecondCollectionViewCell.h"

@implementation PartySecondCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        _name = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, 80, 30)];
        _name.text = @"投诉问题:";
        _name.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:_name];
        
        _data = [[UITextField alloc] initWithFrame:CGRectMake(100, 6, 300, 30)];
        
        _data.enabled = NO;
        
        [_data setValue:[UIFont boldSystemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
        
        _data.placeholder = @"请点击选择您要投诉的问题";
        
        [self.contentView addSubview:_data];
        
    }
    
    
    return self;
}

@end
