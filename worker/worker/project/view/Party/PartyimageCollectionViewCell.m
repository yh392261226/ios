//
//  PartyimageCollectionViewCell.m
//  worker
//
//  Created by 郭健 on 2017/9/6.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "PartyimageCollectionViewCell.h"

@implementation PartyimageCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        _image = [[UIImageView alloc] init];
        
        _image.layer.masksToBounds = YES;
        
        _image.backgroundColor = [UIColor redColor];
        
        _image.layer.cornerRadius = 3;
        
        [self.contentView addSubview:_image];
        
        [_image mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.centerX.mas_equalTo(self.contentView);
            make.centerY.mas_equalTo(self.contentView);
            make.width.mas_equalTo(90);
            make.height.mas_equalTo(90);
        }];
        
    }
    
    return self;
    
}

@end
