//
//  SelecdCityViewController.h
//  worker
//
//  Created by 郭健 on 2017/7/28.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "BaseViewController.h"


@protocol tempCityN

- (void)cityNameT: (NSString *)city;


@end


@interface SelecdCityViewController : BaseViewController


@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, strong)NSString *cityN;  //当前定位的城市名称. 上一页传过来的
@property (nonatomic, strong)NSMutableArray *EnglishArray;

@property (nonatomic, strong)id <tempCityN> delegate;


@end
