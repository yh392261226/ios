//
//  DressingViewController.h
//  worker
//
//  Created by 郭健 on 2017/8/16.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "BaseViewController.h"

@protocol DreeVal

- (void)dreessVal: (NSString *)name nameTy:(NSString *)type adree:(NSString *)adree;   //筛选条件回传上一页

@end



@interface DressingViewController : BaseViewController

@property (nonatomic, strong)UIWindow *window;
@property (nonatomic, strong)id <DreeVal> delegate;

@end
