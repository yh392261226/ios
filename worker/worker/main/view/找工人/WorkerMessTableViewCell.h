//
//  WorkerMessTableViewCell.h
//  worker
//
//  Created by 郭健 on 2017/8/2.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WorkerMessTableViewCell : UITableViewCell

@property (nonatomic, strong)UIView *backview;


@property (nonatomic, strong)UIImageView *IconBtn;
@property (nonatomic, strong)UILabel *title;
@property (nonatomic, strong)UILabel *introduce;
@property (nonatomic, strong)UILabel *details;
@property (nonatomic, strong)UIImageView *state;
@property (nonatomic, strong)UILabel *distance;
@property (nonatomic, strong)UIButton *favoriteBtn;


@end
