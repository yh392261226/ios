//
//  MineMoneyTableViewCell.h
//  worker
//
//  Created by 郭健 on 2017/8/1.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol temIndexMoney <NSObject>

- (void)temMoney: (NSInteger)index;

@end

@interface MineMoneyTableViewCell : UITableViewCell

@property (nonatomic, strong)id <temIndexMoney> delegate;

@property (nonatomic, strong)NSMutableArray *dataArray;

@property (nonatomic, strong)UIButton *button;

@property (nonatomic, strong)UIImageView *image;

@end
