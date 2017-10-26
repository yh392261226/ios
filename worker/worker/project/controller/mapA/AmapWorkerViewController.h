//
//  AmapWorkerViewController.h
//  worker
//
//  Created by 郭健 on 2017/9/11.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "BaseViewController.h"

@interface missionData : NSObject

@property (nonatomic, strong)NSString *t_id;
@property (nonatomic, strong)NSString *t_title;
@property (nonatomic, strong)NSString *t_info;
@property (nonatomic, strong)NSString *t_amount;
@property (nonatomic, strong)NSString *t_duration;
@property (nonatomic, strong)NSString *t_edit_amount;
@property (nonatomic, strong)NSString *t_amount_edit_times;
@property (nonatomic, strong)NSString *t_posit_x;
@property (nonatomic, strong)NSString *t_posit_y;
@property (nonatomic, strong)NSString *t_author;

@property (nonatomic, strong)NSString *t_in_time;
@property (nonatomic, strong)NSString *t_last_edit_time;
@property (nonatomic, strong)NSString *t_last_editor;
@property (nonatomic, strong)NSString *t_status;

@property (nonatomic, strong)NSString *t_phone;
@property (nonatomic, strong)NSString *t_phone_status;
@property (nonatomic, strong)NSString *t_type;
@property (nonatomic, strong)NSString *t_storage;
@property (nonatomic, strong)NSString *bd_id;
@property (nonatomic, strong)NSString *favorate;
@property (nonatomic, strong)NSString *u_img;



@property (nonatomic, strong)NSString *tew_id;
@property (nonatomic, strong)NSString *tew_skills;
@property (nonatomic, strong)NSString *tew_worker_num;
@property (nonatomic, strong)NSString *tew_price;
@property (nonatomic, strong)NSString *tew_start_time;
@property (nonatomic, strong)NSString *tew_end_time;
@property (nonatomic, strong)NSString *r_province;
@property (nonatomic, strong)NSString *r_city;
@property (nonatomic, strong)NSString *r_area;
@property (nonatomic, strong)NSString *tew_address;
@property (nonatomic, strong)NSString *tew_lock;



@end

@interface AmapWorkerViewController : BaseViewController

@property (nonatomic, strong)NSString *worker_id;


@property (nonatomic, strong)NSString *workerNN;  //工种名称
@property (nonatomic, strong)NSString *skills_id;   //工种id

@end
