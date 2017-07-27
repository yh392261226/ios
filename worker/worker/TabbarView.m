//
//  TabbarView.m
//  worker
//
//  Created by 郭健 on 2017/7/27.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "TabbarView.h"

@implementation TabbarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.backgroundColor = [myselfway stringTOColor:@"0xF9F9F9"];
        
        _line = [[UIView alloc] init];
        _line.frame = CGRectMake(0, 0, SCREEN_WIDTH, 1);
        _line.backgroundColor = [myselfway stringTOColor:@"0xD9D9D9"];
        [self addSubview:_line];
        
        _MainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH / 4, 49)];
        [self addSubview:_MainView];
        
        _MainIcon = [UIButton buttonWithType:UIButtonTypeCustom];
        [_MainIcon setBackgroundImage:[UIImage imageNamed:@"tabbar_main"] forState:UIControlStateNormal];
        [_MainView addSubview:_MainIcon];
        
        _Maintitle = [[UILabel alloc] init];
        _Maintitle.font = [UIFont systemFontOfSize:10];
        _Maintitle.text = @"首页";
        _Maintitle.textColor = [UIColor grayColor];
        _Maintitle.textAlignment = NSTextAlignmentCenter;
        [_MainView addSubview:_Maintitle];
        
        
        
        _JobView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 4, 0, SCREEN_WIDTH / 4, 49)];
        [self addSubview:_JobView];
        
        _JobIcon = [UIButton buttonWithType:UIButtonTypeCustom];
        [_JobIcon setBackgroundImage:[UIImage imageNamed:@"tabbar_job"] forState:UIControlStateNormal];
        [_JobView addSubview:_JobIcon];
        
        _jobtitle = [[UILabel alloc] init];
        _jobtitle.font = [UIFont systemFontOfSize:10];
        _jobtitle.textColor = [UIColor grayColor];
        _jobtitle.textAlignment = NSTextAlignmentCenter;
        _jobtitle.text = @"工作管理";
        [_JobView addSubview:_jobtitle];
        
        
        
        
        _MessView = [[UIView alloc] initWithFrame:CGRectMake(2 * (SCREEN_WIDTH / 4), 0, SCREEN_WIDTH / 4, 49)];
        [self addSubview:_MessView];
        
        _MessIcon = [UIButton buttonWithType:UIButtonTypeCustom];
        [_MessIcon setBackgroundImage:[UIImage imageNamed:@"tabbar_mess"] forState:UIControlStateNormal];
        [_MessView addSubview:_MessIcon];
        
        _Messtitle = [[UILabel alloc] init];
        _Messtitle.font = [UIFont systemFontOfSize:10];
        _Messtitle.textColor = [UIColor grayColor];
        _Messtitle.textAlignment = NSTextAlignmentCenter;
        _Messtitle.text = @"优惠信息";
        [_MessView addSubview:_Messtitle];
        
        
    
        
        _MineView = [[UIView alloc] initWithFrame:CGRectMake(3 * (SCREEN_WIDTH / 4), 0, SCREEN_WIDTH / 4, 49)];
        [self addSubview:_MineView];
        
        _MineIcon = [UIButton buttonWithType:UIButtonTypeCustom];
        [_MineIcon setBackgroundImage:[UIImage imageNamed:@"tabbar_mine"] forState:UIControlStateNormal];
        [_MineView addSubview:_MineIcon];
        
        _Minetitle = [[UILabel alloc] init];
        _Minetitle.font = [UIFont systemFontOfSize:10];
        _Minetitle.textColor = [UIColor grayColor];
        _Minetitle.textAlignment = NSTextAlignmentCenter;
        _Minetitle.text = @"我的";
        [_MineView addSubview:_Minetitle];
        
    }
    
    
    
    
    return self;
}



- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_Maintitle mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.centerX.mas_equalTo(_MainView);
        make.bottom.mas_equalTo(_MainView).offset(-3);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(10);
    }];
    
    
    [_jobtitle mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.centerX.mas_equalTo(_JobView);
         make.bottom.mas_equalTo(_JobView).offset(-3);
         make.width.mas_equalTo(60);
         make.height.mas_equalTo(10);
     }];
    
    
    [_Messtitle mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.centerX.mas_equalTo(_MessView);
         make.bottom.mas_equalTo(_MessView).offset(-3);
         make.width.mas_equalTo(60);
         make.height.mas_equalTo(10);
     }];
    
    
    [_Minetitle mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.centerX.mas_equalTo(_MineView);
         make.bottom.mas_equalTo(_MineView).offset(-3);
         make.width.mas_equalTo(60);
         make.height.mas_equalTo(10);
     }];
    
    
    
    
    [_MainIcon mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.centerX.mas_equalTo(_MainView);
         make.bottom.mas_equalTo(_Maintitle).offset(-15);
         make.width.mas_equalTo(25);
         make.height.mas_equalTo(25);
     }];
    
    [_JobIcon mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.centerX.mas_equalTo(_JobView);
         make.bottom.mas_equalTo(_jobtitle).offset(-15);
         make.width.mas_equalTo(25);
         make.height.mas_equalTo(25);
     }];
    
    
    [_MessIcon mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.centerX.mas_equalTo(_MessView);
         make.bottom.mas_equalTo(_Messtitle).offset(-15);
         make.width.mas_equalTo(25);
         make.height.mas_equalTo(25);
     }];
    
    
    [_MineIcon mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.centerX.mas_equalTo(_MineView);
         make.bottom.mas_equalTo(_Minetitle).offset(-15);
         make.width.mas_equalTo(25);
         make.height.mas_equalTo(25);
     }];
}
















@end
