//
//  PartyBinfoViewController.h
//  worker
//
//  Created by 郭健 on 2017/9/8.
//  Copyright © 2017年 郭健. All rights reserved.
//


//乙方信息
#import "BaseViewController.h"

@interface workerArrData : NSObject

@property (nonatomic, strong)NSString *s_id;

@property (nonatomic, strong)NSString *s_desc;
@property (nonatomic, strong)NSString *s_info;
@property (nonatomic, strong)NSString *s_name;
@property (nonatomic, strong)NSString *s_status;

@end


@interface PartyBinfoViewController : BaseViewController


@property (nonatomic, strong)NSString *u_id;

@end
