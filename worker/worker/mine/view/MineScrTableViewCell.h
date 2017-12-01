//
//  MineScrTableViewCell.h
//  worker
//
//  Created by 郭健 on 2017/8/1.
//  Copyright © 2017年 郭健. All rights reserved.
//

@protocol temIndex <NSObject>

- (void)tempVal: (NSInteger)val;

@end



#import <UIKit/UIKit.h>


@interface MineScrTableViewCell : UITableViewCell<UIScrollViewDelegate>

@property (nonatomic, strong)UIScrollView *scrollview;

@property (nonatomic, strong)NSMutableArray *dataArray;  //图片数组
@property (nonatomic, strong)NSMutableArray *nameArray;  //名称数组


@property (nonatomic, strong)UIButton *button;   //按钮
@property (nonatomic, strong)UIImageView *image;
@property (nonatomic, strong)UILabel *label;  


@property (nonatomic, weak)id <temIndex> delegate;


@end
