//
//  BaseViewController.h
//  worker
//
//  Created by 郭健 on 2017/7/26.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

//设置headtitle
- (void)addhead:(NSString *)title;

//设置右滑返回
- (void)slitherBack: (UINavigationController *)navi;


//返回
- (void)temp;

@end
