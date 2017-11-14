//
//  LoginViewController.h
//  worker
//
//  Created by 郭健 on 2017/8/7.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol loginSussecc <NSObject>

- (void)Sussecc;

@end


@interface LoginViewController : UIViewController


@property (nonatomic, strong)id <loginSussecc> delegate;

@end
