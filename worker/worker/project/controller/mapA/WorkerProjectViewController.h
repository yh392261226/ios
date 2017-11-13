//
//  WorkerProjectViewController.h
//  worker
//
//  Created by 郭健 on 2017/9/12.
//  Copyright © 2017年 郭健. All rights reserved.
//


//招工选择项目页面
#import "BaseViewController.h"



@protocol Invitesuccess <NSObject>

- (void)success;

@end




@interface WorkerProjectViewController : BaseViewController


@property (nonatomic, strong) id <Invitesuccess> delegate;

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong)NSString *worker_id;   //工人ID


@property (nonatomic, strong)NSString *gongzhongID;  // gongzhong 

@end
