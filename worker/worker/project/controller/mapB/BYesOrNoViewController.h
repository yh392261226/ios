//
//  BYesOrNoViewController.h
//  worker
//
//  Created by 郭健 on 2017/9/14.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "BaseViewController.h"


@interface AworkerListData : NSObject

@property (nonatomic, strong)NSString *s_id;
@property (nonatomic, strong)NSString *s_name;
@property (nonatomic, strong)NSString *s_info;
@property (nonatomic, strong)NSString *s_desc;
@property (nonatomic, strong)NSString *s_status;


@property (nonatomic, strong)NSString *s_image;


@end







@interface ABigDataModel :NSObject



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
@property (nonatomic, strong)NSString *t_desc;
@property (nonatomic, strong)NSString *t_adree;
@property (nonatomic, strong)NSString *u_high_opinions;

@property (nonatomic, strong)NSString *u_mobile;
@property (nonatomic, strong)NSString *u_sex;
@property (nonatomic, strong)NSString *u_true_name;
@property (nonatomic, strong)NSString *u_img;
@property (nonatomic, strong)NSString *relation;   //判断是否和任务有关系    >0  有关系，   =0  没关系
@property (nonatomic, strong)NSString *relation_type;   //具体什么关系       =0  洽谈中   =1  工作中

@property (nonatomic, strong)NSArray *t_workers;


@end




@interface AListDataModel :NSObject


@property (nonatomic, strong)NSString *o_id;
@property (nonatomic, strong)NSString *t_id;
@property (nonatomic, strong)NSString *u_id;
@property (nonatomic, strong)NSString *o_worker;
@property (nonatomic, strong)NSString *o_amount;
@property (nonatomic, strong)NSString *o_in_time;
@property (nonatomic, strong)NSString *o_last_edit_time;
@property (nonatomic, strong)NSString *o_status;
@property (nonatomic, strong)NSString *tew_id;
@property (nonatomic, strong)NSString *s_id;
@property (nonatomic, strong)NSString *o_confirm;
@property (nonatomic, strong)NSString *unbind_time;
@property (nonatomic, strong)NSString *o_pay;     //nsnumber
@property (nonatomic, strong)NSString *o_pay_time;
@property (nonatomic, strong)NSNumber *o_sponsor;



@property (nonatomic, strong)NSString *u_name;
@property (nonatomic, strong)NSString *u_mobile;
@property (nonatomic, strong)NSString *u_sex;
@property (nonatomic, strong)NSString *u_online;
@property (nonatomic, strong)NSString *u_status;
@property (nonatomic, strong)NSString *u_task_status;
@property (nonatomic, strong)NSString *u_start;
@property (nonatomic, strong)NSString *u_credit;
@property (nonatomic, strong)NSString *u_jobs_num;
@property (nonatomic, strong)NSString *u_recommend;
@property (nonatomic, strong)NSString *u_worked_num;
@property (nonatomic, strong)NSString *u_high_opinions;
@property (nonatomic, strong)NSNumber *u_low_opinions;     //nsnumber
@property (nonatomic, strong)NSString *u_middle_opinions;
@property (nonatomic, strong)NSNumber *u_dissensions;
@property (nonatomic, strong)NSString *u_true_name;
@property (nonatomic, strong)NSString *u_img;

@end


@interface AWorKeDataModel :NSObject


@property (nonatomic, strong)NSString *tew_id;
@property (nonatomic, strong)NSString *t_id;
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
@property (nonatomic, strong)NSNumber *remaining;     //nsnumber


@property (nonatomic, strong)NSMutableArray *orders;
@property (nonatomic, strong)NSMutableArray *ordersArray;

@end

@interface BYesOrNoViewController : BaseViewController

@property (nonatomic, strong)NSString *t_id;


@end
