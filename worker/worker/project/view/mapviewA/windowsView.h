//
//  windowsView.h
//  worker
//
//  Created by 郭健 on 2017/9/11.
//  Copyright © 2017年 郭健. All rights reserved.
//






#import <UIKit/UIKit.h>


@protocol BtnSuccess <NSObject>

- (void)Success;

@end



@interface windowsView : UIView

@property (nonatomic)CGFloat lineNum;

@property (nonatomic, strong)UILabel *tipLable;

@property (nonatomic, strong)UIView *blackview;
@property (nonatomic, strong)UIView *alertview;


@property (nonatomic, strong)UITextView *detail;

@property (nonatomic, strong)UIButton *cancel;
@property (nonatomic, strong)UIButton *confirm;


@property (nonatomic, strong)UIView *line;


@property (nonatomic, strong)NSString *titleData;
@property (nonatomic, strong)NSString *detailData;
@property (nonatomic, strong)NSString *cancelData;
@property (nonatomic, strong)NSString *confirmData;


@property (nonatomic, weak)id <BtnSuccess> delegate;


- (void)initWithTitle: (NSString *)titleData detail:(NSString *)detailData btnleft:(NSString *)btnleft btnright:(NSString *)btnright;



@end
