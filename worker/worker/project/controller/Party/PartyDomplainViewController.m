//
//  PartyDomplainViewController.m
//  worker
//
//  Created by 郭健 on 2017/9/6.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "PartyDomplainViewController.h"
#import "DomFirstCollectionViewCell.h"
#import "PartySecondCollectionViewCell.h"
#import "PartyThreeCollectionViewCell.h"
#import "headCollectionReusableView.h"
#import "PartyimageCollectionViewCell.h"

@interface PartyDomplainViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITextViewDelegate>
{
    NSMutableArray *dataArray;
    
    NSMutableArray *imageArray;
    
    
}


@property (nonatomic, strong)UICollectionView *collection;

@end

@implementation PartyDomplainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addhead:@"我要投诉"];
    
    dataArray = [NSMutableArray array];
    
    
    imageArray = [NSMutableArray array];
    [imageArray addObject:@"1"];
    
    
    
    [self collection];
}


//懒加载
- (UICollectionView *)collection
{
    if (!_collection)
    {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        
        _collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 65, SCREEN_WIDTH, SCREEN_HEIGHT - 65) collectionViewLayout:layout];
        
        _collection.backgroundColor = [UIColor whiteColor];
        
        _collection.delegate = self;
        _collection.dataSource = self;
        
        [_collection registerClass:[DomFirstCollectionViewCell class] forCellWithReuseIdentifier:@"firstcell"];
        
        [_collection registerClass:[PartySecondCollectionViewCell class] forCellWithReuseIdentifier:@"secondcell"];
        
        [_collection registerClass:[PartyThreeCollectionViewCell class] forCellWithReuseIdentifier:@"threecell"];
        
        [_collection registerClass:[PartyimageCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        
        [self.view addSubview:_collection];
        
    }
    
    return _collection;
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 4;
}



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 3)
    {
        return imageArray.count;
    }
    else
    {
        return 1;
    }
}



- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        DomFirstCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"firstcell" forIndexPath:indexPath];
        
   
        return cell;
    }
    else if (indexPath.section == 1)
    {
        PartySecondCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"secondcell" forIndexPath:indexPath];
        
    
        
        return cell;
    }
    else if (indexPath.section == 2)
    {
        PartyThreeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"threecell" forIndexPath:indexPath];
        
        cell.text.delegate = self;
        
        
        return cell;
    }
    else
    {
        PartyimageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
        
        
        
        
        return cell;
    }
    
    
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.1;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return CGSizeMake(SCREEN_WIDTH, 100);
    }
    else if (indexPath.section == 1)
    {
        return CGSizeMake(SCREEN_WIDTH, 40);
    }
    else if (indexPath.section == 2)
    {
        return CGSizeMake(SCREEN_WIDTH, 100);
    }
    else
    {
        return CGSizeMake(SCREEN_WIDTH / 3 - 3, 100);
    }
    
}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1)
    {
        [collectionView deselectItemAtIndexPath:indexPath animated:YES];
        
       
    }
    else if (indexPath.section == 3)
    {
        if (indexPath.item == 0)
        {
            
        }
    }
    
    
}



- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 3)
    {
        return CGSizeMake(SCREEN_WIDTH, 30);
    }
    else
    {
        return CGSizeZero;
    }
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    if (section == 3)
    {
        return CGSizeMake(SCREEN_WIDTH, 50);
    }
    else
    {
        return CGSizeZero;
    }
}



// 设置headerView和footerView的
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath

{
    UICollectionReusableView *reusableView = nil;
    
    
    [collectionView registerClass:[headCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionViewHeader"];
    
    
    [collectionView registerClass:[footCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"UICollectionViewFoot"];
    
    if (kind == UICollectionElementKindSectionHeader)
    {

        //定制头部视图的内容
        
        headCollectionReusableView *headerV = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionViewHeader"forIndexPath:indexPath];
        
        
        reusableView = headerV;
    }
    else if (kind == UICollectionElementKindSectionFooter)
    {
       footCollectionReusableView *headerV = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"UICollectionViewFoot"forIndexPath:indexPath];
        
        [headerV.yes addTarget:self action:@selector(yesBtn) forControlEvents:UIControlEventTouchUpInside];
        
        reusableView = headerV;
    }
    
    return reusableView;
}












- (void)textViewDidChange:(UITextView *)textView
{
    UILabel *label = [self.view viewWithTag:999];
    
    if (textView.text.length == 0)
    {
        label.hidden = NO;
    }
    else
    {
        label.hidden = YES;
    }

}




//提交按钮
- (void)yesBtn
{
    NSLog(@"tijiao");
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
