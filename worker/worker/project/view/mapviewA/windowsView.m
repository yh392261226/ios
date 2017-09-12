//
//  windowsView.m
//  worker
//
//  Created by 郭健 on 2017/9/11.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "windowsView.h"

@implementation windowsView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        //创建遮罩
        _blackview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _blackview.backgroundColor = [UIColor blackColor];
        _blackview.alpha = 0.5;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(blackClick)];
        [self.blackview addGestureRecognizer:tap];
        [self addSubview:_blackview];
        
        
        //创建alert
        
        self.alertview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 270, 190)];
        self.alertview.center = self.center;
        self.alertview.layer.cornerRadius = 17;
        self.alertview.clipsToBounds = YES;
        self.alertview.backgroundColor = [UIColor whiteColor];
        [self addSubview:_alertview];
        [self exChangeOut:self.alertview dur:0.6];
        
        
    }
    
    
    return self;
}



- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _tipLable = [[UILabel alloc] initWithFrame:CGRectMake(0,0,270,43)];
    
    _tipLable.textAlignment = NSTextAlignmentCenter;
    
    _tipLable.text = _titleData;
    
    [_tipLable setBackgroundColor:[UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1.0]];
    
    [_tipLable setFont:[UIFont systemFontOfSize:18]];
    
    [_tipLable setTextColor:[UIColor colorWithRed:51 / 255.0 green:51 / 255.0 blue:51 / 255.0 alpha:1.0]];
    
    [self.alertview addSubview:_tipLable];
 
    _cancel = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [_cancel setTitle:_cancelData forState:UIControlStateNormal];
    
    [_cancel addTarget:self action:@selector(cancelBtn) forControlEvents:UIControlEventTouchUpInside];
    
    _cancel.backgroundColor = [myselfway stringTOColor:@"0xFC6769"];
    
    _cancel.layer.cornerRadius = 7;
    
    [self.alertview addSubview:_cancel];
    
    
    CGFloat width = self.alertview.bounds.size.width;
    
    [_cancel mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.bottom.mas_equalTo(self.alertview).offset(-10);
         make.left.mas_equalTo(self.alertview).offset(15);
         make.width.mas_equalTo(width / 2 - 30);
         make.height.mas_equalTo(32);
     }];

    
    _confirm = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [_confirm setTitle:_confirmData forState:UIControlStateNormal];
    
    _confirm.backgroundColor = [myselfway stringTOColor:@"0x3697F7"];
    
    _confirm.layer.cornerRadius = 7;
    
    [_confirm addTarget:self action:@selector(confirmBtn) forControlEvents:UIControlEventTouchUpInside];
    
    [self.alertview addSubview:_confirm];
    
    [_confirm mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.bottom.mas_equalTo(self.alertview).offset(-10);
         make.right.mas_equalTo(self.alertview).offset(-15);
         make.width.mas_equalTo(width / 2 - 30);
         make.height.mas_equalTo(32);
     }];
    
    
    _detail = [[UITextView alloc] init];
    _detail.font = [UIFont systemFontOfSize:15];
    _detail.textAlignment = NSTextAlignmentLeft;
 //   _detail.backgroundColor = [UIColor greenColor];
    _detail.editable = NO;
    _detail.text = _detailData;
    
    [self.alertview addSubview:_detail];
    
    
    
    NSInteger num =  _detailData.length / 13;     //获取文字有几行
    NSInteger yu = _detailData.length % 13;
    
    if (yu == 0)
    {
        num = num;
    }
    else
    {
        num = num + 1;
    }
    
    
    
    if (num == 1)
    {
        self.alertview.frame = CGRectMake(0, 0, 270, 90 + num * 40);
        self.alertview.center = self.center;
        
        
        [_detail mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.top.mas_equalTo(_tipLable).offset(50);
             make.left.mas_equalTo(self.alertview).offset(25);
             make.right.mas_equalTo(self.alertview).offset(-25);
             make.height.mas_equalTo(num * 38);
         }];
    }
    else if (num > 3)
    {
        self.alertview.frame = CGRectMake(0, 0, 270, 90 + num * 25);
        self.alertview.center = self.center;
        
        
        [_detail mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.top.mas_equalTo(_tipLable).offset(50);
             make.left.mas_equalTo(self.alertview).offset(25);
             make.right.mas_equalTo(self.alertview).offset(-25);
             make.height.mas_equalTo(num * 24);
         }];
    }
    else
    {
        self.alertview.frame = CGRectMake(0, 0, 270, 90 + num * 30);
        self.alertview.center = self.center;
        
        
        [_detail mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.top.mas_equalTo(_tipLable).offset(50);
             make.left.mas_equalTo(self.alertview).offset(25);
             make.right.mas_equalTo(self.alertview).offset(-25);
             make.height.mas_equalTo(num * 28);
         }];
    }
    
    
}


//确定按钮
- (void)confirmBtn
{
    [self.delegate Success];
}


- (void)cancelBtn
{
    [self cancleView];
}



- (void)blackClick
{
    [self cancleView];
}




- (void)cancleView
{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished)
     {
         [self removeFromSuperview];
         self.alertview = nil;
     }];
    
}



- (void)exChangeOut:(UIView *)changeOutView dur:(CFTimeInterval)dur
{
    CAKeyframeAnimation *animation;
    
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    animation.duration = dur;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 0.9)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    animation.timingFunction = [CAMediaTimingFunction functionWithName: @"easeInEaseOut"];
    [changeOutView.layer addAnimation:animation forKey:nil];
    
}



- (void)initWithTitle: (NSString *)titleData detail:(NSString *)detailData btnleft:(NSString *)btnleft btnright:(NSString *)btnright
{
    _titleData = titleData;
    _detailData = detailData;
    _cancelData = btnleft;
    _confirmData = btnright;
    
}






//用法

//- (void)loadAlertView:(NSString *)title contentStr:(NSString *)content btnNum:(NSString *)numOne btnNumTo:(NSString *)numTo
//{
//    
//    windowsView *alertView = [[windowsView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
//    
//    [alertView initWithTitle:title detail:content btnleft:numOne btnright:numTo];
//    
//    alertView.delegate = self;
//    
//    UIView * keywindow = [[UIApplication sharedApplication] keyWindow];
//    
//    [keywindow addSubview:alertView];
//    
//}








@end
