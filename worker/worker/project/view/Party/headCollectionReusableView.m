//
//  headCollectionReusableView.m
//  worker
//
//  Created by 郭健 on 2017/9/6.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "headCollectionReusableView.h"


@implementation footCollectionReusableView

- (instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _yes = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _yes.frame = CGRectMake(40, 5, SCREEN_WIDTH - 80, 40);
        
        [_yes setTitle:@"提交" forState:0];
        
        _yes.layer.cornerRadius = 8;
        
        _yes.backgroundColor = [myselfway stringTOColor:@"0x2E84F8"];
        
        [self addSubview:_yes];
        
    }
    
    return self;
}

@end




@implementation headCollectionReusableView

- (instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, 50, 20)];
        _label.text = @"图片";
        _label.font = [UIFont systemFontOfSize:17];
        _label.textAlignment = NSTextAlignmentLeft;
        
        [self addSubview:_label];
        
        
        _label1 = [[UILabel alloc] initWithFrame:CGRectMake(60, 5, 300, 20)];
        _label1.text = @"(选填,提供问题图片最多上传5张)";
        _label1.font = [UIFont systemFontOfSize:14];
        _label1.textColor = [UIColor grayColor];
        _label1.textAlignment = NSTextAlignmentLeft;
        
        [self addSubview:_label1];
       
        
    }
    return self;
}

@end
