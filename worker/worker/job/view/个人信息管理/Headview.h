//
//  Headview.h
//  worker
//
//  Created by 郭健 on 2017/8/9.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol temIndexNum <NSObject>

- (void)tempval: (NSInteger)type;

@end

@interface Headview : UIView


@property (nonatomic, weak)id <temIndexNum> delegate;

@property (nonatomic, strong)NSMutableArray *dataArray;



@property (nonatomic, strong)UIImageView *Icon;
@property (nonatomic, strong)UIButton *btnIcon;

@property (nonatomic, strong)UIImageView *logoimage;
@property (nonatomic, strong)UILabel *introduce;


@property (nonatomic, strong)UIView *line;



@property (nonatomic, strong)UIButton *btn;
@property (nonatomic, strong)UILabel *name;



@end
