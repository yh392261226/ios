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

#import "PartyRefuseViewController.h"

#import "ZLPhotoActionSheet.h"
#import "ZLDefine.h"

@interface PartyDomplainViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITextViewDelegate>
{
    NSMutableArray *dataArray;
    
    NSMutableArray *imageArray;
    
    NSMutableArray *nameArray;
    
    NSString *name;   //投诉原因的字段
    
    NSString *textDetail;    //投诉原因详情的数据
}


@property (nonatomic, strong)UICollectionView *collection;




@property (nonatomic, strong) NSArray<ZLSelectPhotoModel *> *lastSelectMoldels;

@end

@implementation PartyDomplainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addhead:@"我要投诉"];
    
    dataArray = [NSMutableArray array];
    
    
    imageArray = [NSMutableArray array];
    
    UIImage *image = [UIImage imageNamed:@"project_add"];
    [imageArray addObject:image];
    
    
    nameArray = [NSMutableArray array];
    [nameArray addObject:@"暗示健康的哈数据的卡萨丁"];
    [nameArray addObject:@"暗示健康萨丁"];
    [nameArray addObject:@"暗示健康的哈数据丁"];
    [nameArray addObject:@"暗示ad"];
    [nameArray addObject:@"暗示健康的"];
    [nameArray addObject:@"暗示健康的哈数据的卡萨丁aas"];
    
    
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
        
        cell.data.text = name;
        
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
        NSString *identifier = [NSString stringWithFormat:@"%ldcell", indexPath.row];
        
        [_collection registerClass:[PartyimageCollectionViewCell class] forCellWithReuseIdentifier:identifier];
        
        
        PartyimageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        
        
        cell.close.tag = indexPath.row + 400;
        
        [cell.close addTarget:self action:@selector(closeBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.image.image = [imageArray objectAtIndex:indexPath.row];
        
        
        if (indexPath.row == 0)
        {
            cell.close.hidden = YES;
        }
        
        
        
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
        
        UIAlertController *alertcontroller = [UIAlertController alertControllerWithTitle:nil message:@"选择问题" preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *returnAction = [UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleCancel handler:nil];
        
        [alertcontroller addAction:returnAction];
        
        
        for (int i = 0; i < nameArray.count; i++)
        {
            UIAlertAction *action = [UIAlertAction actionWithTitle:[nameArray objectAtIndex:i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
            {
                name = action.title;
                
                [self.collection reloadData];
            }];
            
            
            [alertcontroller addAction:action];
            
        }
        
        [self presentViewController:alertcontroller animated:YES completion:nil];
       
    }
    else if (indexPath.section == 3)
    {
        if (indexPath.item == 0)
        {
            if (imageArray.count >= 5)
            {
                [SVProgressHUD showInfoWithStatus:@"图片已够5张"];
            }
            else
            {
                ZLPhotoActionSheet *actionSheet = [[ZLPhotoActionSheet alloc] init];
                //设置照片最大选择数
                actionSheet.maxSelectCount = 5;
                [actionSheet showPhotoLibraryWithSender:self lastSelectPhotoModels:self.lastSelectMoldels completion:^(NSArray<UIImage *> * _Nonnull selectPhotos, NSArray<ZLSelectPhotoModel *> * _Nonnull selectPhotoModels)
                 {
                     
                     for (int i = 0; i < selectPhotos.count; i++)
                     {
                         
                         UIImage *image = [selectPhotos objectAtIndex:i];
                         
                         if (imageArray.count <= 5)
                         {
                             [imageArray addObject:image];
                         }
                         else
                         {
                             [SVProgressHUD showInfoWithStatus:@"图片至多上传5张"];
                         }
                         
                     }
                     
                     NSLog(@"%@", imageArray);
                     
                     [self.collection reloadData];
                     
                 }];

            }
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
        return CGSizeMake(SCREEN_WIDTH, 60);
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

    textDetail = textView.text;
    
    
}




//提交按钮
- (void)yesBtn
{
    if (name.length == 0)
    {
        [SVProgressHUD showInfoWithStatus:@"请选择投诉问题"];
    }
    else if (textDetail.length == 0)
    {
        [SVProgressHUD showInfoWithStatus:@"请填写描述您的投诉问题"];
    }
    else
    {
        [SVProgressHUD showInfoWithStatus:@"投诉成功"];
        [self performSelector:@selector(bbbbbb) withObject:nil afterDelay:1];
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    
    
}

- (void)bbbbbb
{
    [SVProgressHUD dismiss];
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

//删除图片按钮
- (void)closeBtn: (UIButton *)sender
{
    NSInteger i = sender.tag - 400;
    
    [imageArray removeObjectAtIndex:i];
    
    [self.collection reloadData];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
