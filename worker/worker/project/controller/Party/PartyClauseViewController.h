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

@property (nonatomic, strong)NSString *o_id;
@property (nonatomic, strong)NSString *t_id;

@property (nonatomic, strong)NSString *o_worker;
@property (nonatomic, strong)NSString *tew_id;
@property (nonatomic, strong)NSString *worName;
@property (nonatomic, strong)NSString *person;
@property (nonatomic, strong)NSString *money;
@property (nonatomic, strong)NSString *startTime;
@property (nonatomic, strong)NSString *endTime;
@property (nonatomic, strong)NSString *skill;

@end
