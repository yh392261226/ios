//
//  mapFirstguTableViewCell.m
//  worker
//
//  Created by ios_g on 2017/10/24.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "mapFirstguTableViewCell.h"

@implementation mapFirstguTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        _icon = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _icon.backgroundColor = [UIColor redColor];
        
        _icon.layer.cornerRadius = 35;
        
        _icon.layer.masksToBounds = YES;
        
        _icon.frame = CGRectMake(15, 15, 70, 70);
        
        [self.contentView addSubview:_icon];
        
        
        _name = [[UILabel alloc] init];
        
        _name.text = @"王二小";
        
        _name.font = [UIFont systemFontOfSize:16];
        
        [self.contentView addSubview:_name];
        
        
        _sex = [[UIImageView alloc] init];
        
        [self.contentView addSubview:_sex];
        
        
        _guzhu = [[UILabel alloc] init];
        
        _guzhu.text = @"雇主";
        
        _guzhu.font = [UIFont systemFontOfSize:16];
        
        [self.contentView addSubview:_guzhu];
        
        
        
        _call = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_call setImage:[UIImage imageNamed:@"mine_call"] forState:UIControlStateNormal];
        
        [self.contentView addSubview:_call];
        
        
    }
    
    return self;
}



- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).offset(21);
        make.left.mas_equalTo(_icon).offset(90);
        make.height.mas_equalTo(21);
        make.width.mas_equalTo(85);
    }];
    
    
    [_sex mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).offset(21);
        make.left.mas_equalTo(_icon).offset(173);
        make.height.mas_equalTo(21);
        make.width.mas_equalTo(21);
    }];
    
    
    [_guzhu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_name).offset(28);
        make.left.mas_equalTo(_icon).offset(90);
        make.height.mas_equalTo(21);
        make.width.mas_equalTo(53);
    }];
    
    
    
    [_call mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).offset(34);
        make.right.mas_equalTo(self.contentView).offset(-16);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(40);
    }];
    
    
    
}













@end
