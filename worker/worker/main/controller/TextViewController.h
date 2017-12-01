//
//  TextViewController.h
//  worker
//
//  Created by ios_g on 2017/11/24.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "BaseViewController.h"

@interface TextViewController : BaseViewController


@property (nonatomic, strong) UIImageView       *imgView;
@property (nonatomic, strong) UIScrollView      *headerScrollView;
@property (nonatomic, strong) UIView            *headerView;

@property (nonatomic, assign) CGRect            originFrame;

@end
