//
//  PartyDomplainViewController.h
//  worker
//
//  Created by 郭健 on 2017/9/6.
//  Copyright © 2017年 郭健. All rights reserved.
//





//甲方投诉乙方

#import "BaseViewController.h"

@interface PartyDomplainViewController : BaseViewController

@property (nonatomic, strong)NSString *icon;
@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSString *sex;
@property (nonatomic, strong)NSString *worker;     //工人id
@property (nonatomic, strong)NSString *number;
@property (nonatomic, strong)NSString *workerName;
//@property (nonatomic, strong)NSString *o_worker;


@property (nonatomic, strong)NSString *type;  //判断是对工人还是对雇主，    请求url不一样    2是雇主对工人  1是工人对雇主

@end
