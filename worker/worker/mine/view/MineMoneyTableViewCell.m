//
//  MineMoneyTableViewCell.m
//  worker
//
//  Created by 郭健 on 2017/8/1.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "MineMoneyTableViewCell.h"

@implementation MineMoneyTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.dataArray = [NSMutableArray array];
        
        [self.dataArray addObject:@"mine_redpacket"];
        [self.dataArray addObject:@"mine_ roll"];
       // [self.dataArray addObject:@"mine_ integral"];
        
        
        for (int i = 0; i < self.dataArray.count; i++)
        {
            _button = [UIButton buttonWithType:UIButtonTypeCustom];
            
            _button.tag = 800 + i;
            
            [_button addTarget:self action:@selector(scrBtn:) forControlEvents:UIControlEventTouchUpInside];
            
            _button.frame = CGRectMake(i * (SCREEN_WIDTH / 4), 0, SCREEN_WIDTH / 4, 50);
            
            [self.contentView addSubview:_button];
            
            
            _image = [[UIImageView alloc] init];
            
            _image.image = [UIImage imageNamed:[self.dataArray objectAtIndex:i]];
            
            [_button addSubview:_image];
            
            [_image mas_makeConstraints:^(MASConstraintMaker *make)
             {
                 make.centerX.mas_equalTo(_button);
                 make.top.mas_equalTo(self.contentView).offset(10);
                 make.width.mas_equalTo(40);
                 make.height.mas_equalTo(40);
             }];
        }
        
    }
    
    return self;
}

//红包等按钮点击事件
- (void)scrBtn: (UIButton *)btn
{
    [self.delegate temMoney:btn.tag];
}


@end
