//
//  ThreeCityViewController.h
//  worker
//
//  Created by 郭健 on 2017/9/25.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "BaseViewController.h"

@protocol cityNumber


//获取省市区ID
- (void)post3Level: (NSString *)city_id1 city_name1:(NSString *)name city_id2:(NSString *)city_id city_name2:(NSString *)city_name2 city_id2:(NSString *)city_id2 city_name3:(NSString *)city_name3;

@end

@interface ThreeCityViewController : BaseViewController

@property (nonatomic, weak)id <cityNumber> delegate;

@end
