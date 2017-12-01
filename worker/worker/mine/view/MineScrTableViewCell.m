//
//  MineScrTableViewCell.m
//  worker
//
//  Created by 郭健 on 2017/8/1.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "MineScrTableViewCell.h"

@implementation MineScrTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.dataArray = [NSMutableArray arrayWithObjects:@"mine_favorite",@"mine_ appraise", @"mine_money", @"mine_mess", nil];
        
        self.nameArray = [NSMutableArray arrayWithObjects:@"收藏",@"评价", @"钱包", @"消息", nil];
        
        _scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 70)];
        
        
        _scrollview.delegate = self;
        
        _scrollview.contentSize = CGSizeMake(SCREEN_WIDTH, 70);
        
        _scrollview.bounces = YES;
        
       // 水平方向
        _scrollview.showsHorizontalScrollIndicator = NO;
       // 垂直方向
        _scrollview.showsVerticalScrollIndicator = NO;
        
        
        [self.contentView addSubview:_scrollview];
        
        
        for (int i = 0; i < self.dataArray.count; i++)
        {
            _button = [UIButton buttonWithType:UIButtonTypeCustom];
            
            _button.tag = 900 + i;
            
            [_button addTarget:self action:@selector(scrBtn:) forControlEvents:UIControlEventTouchUpInside];
            
            _button.frame = CGRectMake(i * (SCREEN_WIDTH / 4), 0, SCREEN_WIDTH / 4, 70);
            
            [_scrollview addSubview:_button];
            
            
            _image = [[UIImageView alloc] init];
            
            _image.image = [UIImage imageNamed:[self.dataArray objectAtIndex:i]];
            
            [_scrollview addSubview:_image];
            
            [_image mas_makeConstraints:^(MASConstraintMaker *make)
            {
                make.centerX.mas_equalTo(_button);
                make.top.mas_equalTo(_scrollview).offset(10);
                make.width.mas_equalTo(30);
                make.height.mas_equalTo(30);
            }];
            
            
            _label = [[UILabel alloc] init];
            _label.textColor = [myselfway stringTOColor:@"0x2E84F8"];
            _label.font = [UIFont systemFontOfSize:15];
            _label.textAlignment = NSTextAlignmentCenter;
            _label.text = [self.nameArray objectAtIndex:i];
            [_scrollview addSubview:_label];
            
            [_label mas_makeConstraints:^(MASConstraintMaker *make)
             {
                 make.centerX.mas_equalTo(_button);
                 make.top.mas_equalTo(_image).offset(35);
                 make.width.mas_equalTo(55);
                 make.height.mas_equalTo(20);
             }];
            
        }
        
        
    
        
    }
    
    return self;
}


//按钮的点击事件
- (void)scrBtn: (UIButton *)btn
{
    [self.delegate tempVal:btn.tag];
}











@end
