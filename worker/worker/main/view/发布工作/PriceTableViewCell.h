//
//  PriceTableViewCell.h
//  worker
//
//  Created by sd on 2017/10/14.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PriceTableViewCell : UITableViewCell


@property (nonatomic, strong)UIView *backview;
@property (nonatomic, strong)UILabel *money;
@property (nonatomic, strong)UILabel *text;
@property (nonatomic, strong)UILabel *time;
@property (nonatomic, strong)UIImageView *seleced;

@end
