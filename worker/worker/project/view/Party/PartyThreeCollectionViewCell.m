//
//  PartyThreeCollectionViewCell.m
//  worker
//
//  Created by 郭健 on 2017/9/6.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "PartyThreeCollectionViewCell.h"

@implementation PartyThreeCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        _text = [[UITextView alloc] initWithFrame:CGRectMake(15, 5, SCREEN_WIDTH - 30, 90)];
        _text.layer.borderColor = UIColor.grayColor.CGColor;
        _text.layer.borderWidth = 1;
        _text.layer.cornerRadius = 6;
        _text.layer.masksToBounds = YES;
        
        [self.contentView addSubview:_text];
        
        
        _place = [[UILabel alloc] initWithFrame:CGRectMake(4, 4, 300, 21)];
        
        _place.tag = 999;
        
        _place.text = @"请详细描述您要投诉的问题";
        
        _place.textColor = [UIColor grayColor];
        
        _place.font = [UIFont systemFontOfSize:14];
        
        [_text addSubview:_place];
        
        
        
        
    }

    return self;
}

@end
