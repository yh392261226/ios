//
//  EditCraftTableViewCell.h
//  worker
//
//  Created by 郭健 on 2017/8/14.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol temIndex <NSObject>

- (void)tempValNum: (NSInteger)info;

@end




@interface EditCraftTableViewCell : UITableViewCell<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong)id <temIndex> delegate;


@property (nonatomic, strong)NSMutableArray *dataArray;


@property (nonatomic, strong)UICollectionView *collection;

@end
