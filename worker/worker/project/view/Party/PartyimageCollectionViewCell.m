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

        
        _image.layer.cornerRadius = 3;
        
      
        
        [self.contentView addSubview:_image];
        
        [_image mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.centerX.mas_equalTo(self.contentView);
            make.centerY.mas_equalTo(self.contentView);
            make.width.mas_equalTo(90);
            make.height.mas_equalTo(90);
        }];
        
        
        
        _close = [UIButton buttonWithType:UIButtonTypeCustom];
        
       
        
        [_close setBackgroundImage:[UIImage imageNamed:@"project_close"] forState:UIControlStateNormal];
        
        _close.layer.cornerRadius = 10;
        
        
        
        [self.contentView addSubview:_close];
        
        
        [_close mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.top.mas_equalTo(_image).offset(-5);
            make.right.mas_equalTo(_image).offset(5);
            make.height.mas_equalTo(20);
            make.width.mas_equalTo(20);
        }];
        
        
        
        
        
    }
    
    return self;
    
}

@end
