//
//  AYesOrNoViewController.h
//  worker
//
//  Created by 郭健 on 2017/9/13.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "BaseViewController.h"

@interface AYesOrNoViewController : BaseViewController

@property (nonatomic, strong)NSString *worU_id;   //工人ID
//@property (nonatomic, strong)NSString *worS_id;   //工种ID    没用， 写错了
@property (nonatomic, strong)NSString *worName;   //工人ID


@property (nonatomic, strong)NSString *o_id;
@property (nonatomic, strong)NSString *t_id;

@property (nonatomic, strong)NSString *tew_id;
@property (nonatomic, strong)NSString *o_worker;
@property (nonatomic, strong)NSString *s_id;
@property (nonatomic, strong)NSString *o_confirm;         //用以下两个字段判断工人是否回复了该条订单
@property (nonatomic, strong)NSString *o_status;



@property (nonatomic, strong)NSString *worNameMM;
@property (nonatomic, strong)NSString *person;
@property (nonatomic, strong)NSString *money;
@property (nonatomic, strong)NSString *startTime;
@property (nonatomic, strong)NSString *endTime;
@property (nonatomic, strong)NSString *skill;






@end
