//
//  WorkerProTableViewCell.h
//  worker
//
//  Created by 郭健 on 2017/9/12.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WorkerProTableViewCell : UITableViewCell

@property (nonatomic, strong)UIButton *rightBtn;
@property (nonatomic, strong)UILabel *text;          //每次只能选择一个项目




@property (nonatomic, strong)UIView *backview;


@property (nonatomic, strong)UIImageView *IconBtn;
@property (nonatomic, strong)UILabel *title;
@property (nonatomic, strong)UILabel *introduce;
@property (nonatomic, strong)UILabel *details;
@property (nonatomic, strong)UIImageView *state;
@property (nonatomic, strong)UILabel *distance;
@property (nonatomic, strong)UIButton *favoriteBtn;

@property (nonatomic, strong)UIView *line;

@end
