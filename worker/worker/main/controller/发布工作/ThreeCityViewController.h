//
//  ThreeCityViewController.h
//  worker
//
//  Created by 郭健 on 2017/9/25.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "BaseViewController.h"

@protocol cityNumber

- (void)tempCityNum: (NSString *)city_id city_name:(NSString *)name;

@end

@interface ThreeCityViewController : BaseViewController

@property (nonatomic, weak)id <cityNumber> delegate;

@end
