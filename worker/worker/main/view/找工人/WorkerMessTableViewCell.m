//
//  WorkerMessTableViewCell.m
//  worker
//
//  Created by 郭健 on 2017/8/2.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "WorkerMessTableViewCell.h"

@implementation WorkerMessTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.backgroundColor = [myselfway stringTOColor:@"0xC4CED3"];
        
        _backview = [[UIView alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH - 20, 80)];
        _backview.backgroundColor = [UIColor whiteColor];
        _backview.layer.cornerRadius = 8;
        [self.contentView addSubview:_backview];
        
        
        //用户头像
        _IconBtn = [[UIImageView alloc] init];;
        _IconBtn.frame = CGRectMake(15, 10, 60, 60);
        _IconBtn.layer.cornerRadius = 30;
        _IconBtn.backgroundColor = [UIColor orangeColor];
        [_backview addSubview:_IconBtn];
        
        
        _title = [[UILabel alloc] init];
        _title.textColor = [UIColor blackColor];
        _title.text = @"专业水泥工";
        _title.font = [UIFont systemFontOfSize:14];
        [_backview addSubview:_title];
        
        
        _introduce = [[UILabel alloc] init];
        _introduce.textColor = [UIColor grayColor];
        _introduce.text = @"如果暴力不是为了杀戮，那就毫无意义";
        _introduce.font = [UIFont systemFontOfSize:13];
        [_backview addSubview:_introduce];
        
        
        _details = [[UILabel alloc] init];
        _details.textColor = [UIColor redColor];
        _details.text = @"时间，并不在于你拥有多少，而在于你怎样去使用";
        _details.font = [UIFont systemFontOfSize:13];
        [_backview addSubview:_details];
        
        _state = [[UIImageView alloc] init];
        _state.layer.cornerRadius = 5;
        _state.image = [UIImage imageNamed:@"main_state1"];
        [_backview addSubview:_state];
        
        
        _favoriteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_favoriteBtn setBackgroundImage:[UIImage imageNamed:@"main_favoriteNO"] forState:UIControlStateNormal];
        
        [_backview addSubview:_favoriteBtn];
        
        
        _distance = [[UILabel alloc] init];
        _distance.textColor = [UIColor grayColor];
        _distance.text = @"距我30公里";
        _distance.textAlignment = NSTextAlignmentRight;
        _distance.font = [UIFont systemFontOfSize:13];
        [_backview addSubview:_distance];
        
    }
    
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_title mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.top.mas_equalTo(_backview).offset(5);
        make.left.mas_equalTo(_IconBtn).offset(70);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(200);
    }];
    
    [_favoriteBtn mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.mas_equalTo(_backview).offset(7.5);
         make.right.mas_equalTo(_backview).offset(-10);
         make.height.mas_equalTo(20);
         make.width.mas_equalTo(20);
     }];
    
    [_state mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.mas_equalTo(_backview).offset(7.5);
         make.right.mas_equalTo(_favoriteBtn).offset(-28);
         make.height.mas_equalTo(20);
         make.width.mas_equalTo(50);
     }];
    
    
    [_distance mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.bottom.mas_equalTo(_backview).offset(-5);
         make.right.mas_equalTo(_backview).offset(-15);
         make.height.mas_equalTo(20);
         make.width.mas_equalTo(80);
     }];
    
    
    [_introduce mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.mas_equalTo(_title).offset(27.5);
         make.left.mas_equalTo(_IconBtn).offset(70);
         make.right.mas_equalTo(_backview).offset(-20);
         make.height.mas_equalTo(20);
     }];
    
    [_details mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.mas_equalTo(_introduce).offset(22.5);
         make.left.mas_equalTo(_IconBtn).offset(70);
         make.height.mas_equalTo(20);
         make.right.mas_equalTo(_distance).offset(-85);
     }];
}

















@end
