//
//  PartyClauseViewController.h
//  worker
//
//  Created by 郭健 on 2017/9/8.
//  Copyright © 2017年 郭健. All rights reserved.
//


//甲方开工条款
#import "BaseViewController.h"


@protocol workerSeccuss <NSObject>

- (void)secuuss;

@end


@interface PartyClauseViewController : BaseViewController

@property (nonatomic, strong)id <workerSeccuss> delegate;

@end
