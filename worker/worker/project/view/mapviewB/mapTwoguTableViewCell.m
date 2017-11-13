//
//  mapTwoguTableViewCell.m
//  worker
//
//  Created by ios_g on 2017/10/24.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "mapTwoguTableViewCell.h"

@implementation mapTwoguTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        _dian = [[UIView alloc] initWithFrame:CGRectMake(20, 10, 15, 15)];
        
        _dian.backgroundColor = [UIColor blueColor];
        
        _dian.layer.cornerRadius = 7.5;
        
        [self.contentView addSubview:_dian];
        
        
        _dian1 = [[UIView alloc] initWithFrame:CGRectMake(20, 35, 15, 15)];
        
        _dian1.backgroundColor = [UIColor blueColor];
        
        _dian1.layer.cornerRadius = 7.5;
        
        [self.contentView addSubview:_dian1];
        
        
        
        _adree = [[UILabel alloc] init];
        
        _adree.text = @"123erefdsv";
        
        _adree.font = [UIFont systemFontOfSize:15];
        
        [self.contentView addSubview:_adree];
        
        
        _detail = [[UILabel alloc] init];
        
        _detail.text = @"描述";
        
        _detail.font = [UIFont systemFontOfSize:15];
        
        [self.contentView addSubview:_detail];
        
        
        
        
        _dian2 = [[UIView alloc] init];
        
        _dian2.backgroundColor = [UIColor orangeColor];
        _dian2.layer.cornerRadius = 7.5;
        
        [self.contentView addSubview:_dian2];
        
        
        _money = [[UILabel alloc] init];
        
        _money.text = @"dasdasd";
        
        
        _money.font = [UIFont systemFontOfSize:15];
        
        [self.contentView addSubview:_money];
        
        
        _seleced = [[UIImageView alloc] init];
        
        _seleced.layer.cornerRadius = 10;
        
        _seleced.layer.masksToBounds = YES;
        
        _seleced.backgroundColor = [UIColor grayColor];
        
        [self.contentView addSubview:_seleced];
       
        
    }
    
    return self;
    
}



- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_adree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_dian).offset(30);
        make.centerY.mas_equalTo(_dian);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(21);
    }];
    
    [_detail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_dian1).offset(30);
        make.centerY.mas_equalTo(_dian1);
        make.width.mas_equalTo(300);
        make.height.mas_equalTo(21);
    }];
    

    [_dian2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_adree).offset(110);
        make.centerY.mas_equalTo(_dian);
        make.height.mas_equalTo(15);
        make.width.mas_equalTo(15);
    }];
    
    [_money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_dian2).offset(30);
        make.centerY.mas_equalTo(_dian);
        make.height.mas_equalTo(21);
        make.width.mas_equalTo(150);
    }];
    
    
    [_seleced mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView).offset(-20);
        make.centerY.mas_equalTo(self.contentView);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(20);
    }];
    
    
}



@end
