//
//  SetViewController.h
//  worker
//
//  Created by 郭健 on 2017/8/14.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "BaseViewController.h"

@protocol loginSussecc <NSObject>

- (void)Sussecc;

@end

@interface SetViewController : BaseViewController


@property (nonatomic, strong)id <loginSussecc> delegate;

@end
