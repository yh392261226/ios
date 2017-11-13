//
//  worInfoTableViewCell.m
//  worker
//
//  Created by ios_g on 2017/10/30.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "worInfoTableViewCell.h"

@implementation worInfoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if(self)
    {
        _icon = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 50, 50)];
        
        _icon.layer.masksToBounds = YES;
        
        _icon.layer.cornerRadius = 25;
        
        [self.contentView addSubview:_icon];
        
        
        _name = [[UILabel alloc] init];
        
        _name.font = [UIFont systemFontOfSize:15];
        
        _name.text = @"张飞翼德";
        
        [self.contentView addSubview:_name];
        
        
        _sex = [[UIImageView alloc] init];
        
        [self.contentView addSubview:_sex];
        
        
        _state = [[UILabel alloc] init];
        
        _state.font = [UIFont systemFontOfSize:14];
        
        _state.layer.cornerRadius = 5;
        
        _state.layer.masksToBounds = YES;
        
        _state.backgroundColor = [UIColor greenColor];
        
        _state.textColor = [UIColor whiteColor];
        
        _state.textAlignment = NSTextAlignmentCenter;
        
        [self.contentView addSubview:_state];
        
        
        _call = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_call setBackgroundImage:[UIImage imageNamed:@"mine_call"] forState:UIControlStateNormal];
        
        [self.contentView addSubview:_call];
        
        
        _workerType = [[UILabel alloc] init];
        
        _workerType.font = [UIFont systemFontOfSize:14];
        
        _workerType.text = @"水泥工";
        
        [self.contentView addSubview:_workerType];
        
        
    }
    
    return self;
    
}



- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).offset(10);
        make.left.mas_equalTo(_icon).offset(60);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(21);
    }];
    
    [_sex mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).offset(10);
        make.left.mas_equalTo(_name).offset(105);
        make.width.mas_equalTo(21);
        make.height.mas_equalTo(21);
    }];
    
    
    [_workerType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_name).offset(35);
        make.left.mas_equalTo(_icon).offset(60);
        make.width.mas_equalTo(65);
        make.height.mas_equalTo(21);
    }];
    
    [_state mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_name).offset(35);
        make.left.mas_equalTo(_workerType).offset(90);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(21);
    }];
    
    [_call mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.right.mas_equalTo(self.contentView).offset(-25);
        make.height.mas_equalTo(25);
        make.width.mas_equalTo(25);
    }];
    
}



@end
