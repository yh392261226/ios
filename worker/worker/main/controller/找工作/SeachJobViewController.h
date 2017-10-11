//
//  SeachJobViewController.h
//  worker
//
//  Created by 郭健 on 2017/8/3.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "BaseViewController.h"

@interface jobListData : NSObject

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
@property (nonatomic, strong)NSString *t_desc;

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
@property (nonatomic, strong)NSString *favorate;

@property (nonatomic, strong)NSString *t_imageUrl;
@end


@interface SeachJobViewController : BaseViewController

@end
