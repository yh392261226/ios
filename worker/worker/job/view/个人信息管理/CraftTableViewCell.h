//
//  CraftTableViewCell.h
//  worker
//
//  Created by 郭健 on 2017/8/10.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CraftTableViewCell : UITableViewCell <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>



@property (nonatomic, strong)NSMutableArray *dataArray;


@property (nonatomic, strong)UICollectionView *collection;


@end
