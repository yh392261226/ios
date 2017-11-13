//
//  WorkerMessViewController.h
//  worker
//
//  Created by 郭健 on 2017/8/2.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "BaseViewController.h"

@interface WorkerMessViewController : BaseViewController

@property (nonatomic)CGFloat longitude;    //经度
@property (nonatomic)CGFloat latitude;     //纬度

@property (nonatomic, strong)NSString *city_id;  //城市ID
@property (nonatomic, strong)NSString *worker_ID;  //工种ID


@property (nonatomic, strong)NSString *workerName;   //工种名， 传给下一页详情里面显示

@end
