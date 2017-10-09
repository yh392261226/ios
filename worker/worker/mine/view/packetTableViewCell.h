//
//  packetTableViewCell.h
//  worker
//
//  Created by sd on 2017/9/30.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface packetTableViewCell : UITableViewCell

@property (nonatomic, strong)UILabel *money;
@property (nonatomic, strong)UILabel *text;
@property (nonatomic, strong)UILabel *time;
@property (nonatomic, strong)UIView *line;
@property (nonatomic, strong)UIButton *drawMoney;

@end
