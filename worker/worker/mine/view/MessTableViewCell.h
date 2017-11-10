//
//  MessTableViewCell.h
//  worker
//
//  Created by 郭健 on 2017/8/3.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessTableViewCell : UITableViewCell

@property (nonatomic, strong)UILabel *title;
@property (nonatomic, strong)UILabel *time;
@property (nonatomic, strong)UILabel *detail;

@property (nonatomic, strong)UILabel *look;


@property (nonatomic, strong)UIImageView *svp;   //红点

@end
