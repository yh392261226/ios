//
//  CraftTableViewCell.m
//  worker
//
//  Created by 郭健 on 2017/8/10.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "CraftTableViewCell.h"
#import "workerCollectionViewCell.h"

@implementation CraftTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        
        [self collection];
        
    }
    
    return self;
}




#pragma collectionView
- (UICollectionView *)collection
{
    if (!_collection)
    {
        UICollectionViewFlowLayout *layou = [[UICollectionViewFlowLayout alloc] init];
        
        _collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:layou];
        
        _collection.backgroundColor = [UIColor whiteColor];
        
        _collection.delegate = self;
        _collection.dataSource = self;
        
        [_collection registerClass:[workerCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        
        
        [self.contentView addSubview:_collection];
        
        
    }
    
    return _collection;
}




- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
   
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    workerCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.workerName.text = [self.dataArray objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(SCREEN_WIDTH / 4 - 4, 40);
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 2.0f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 2.0f;
}




















- (void)setDataArray:(NSMutableArray *)dataArray
{
    _dataArray = dataArray;
    
    NSInteger num = self.dataArray.count;
    
    NSInteger i = 0;
    
    if (num % 4 == 0)
    {
        i = num / 4;
    }
    else
    {
        i = num / 4 + 1;
    }
    
    self.contentView.frame = CGRectMake(0, 0, SCREEN_WIDTH, i * 40);
    
    
    
    [self.collection reloadData];

    
}



- (void)layoutSubviews
{
    [super layoutSubviews];
}







@end
