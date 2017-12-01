//
//  UserInfoModel.h
//  worker
//
//  Created by 郭健 on 2017/9/27.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UserAdreeData : NSObject

@property (nonatomic, strong)NSString *uei_province;
@property (nonatomic, strong)NSString *uei_city;
@property (nonatomic, strong)NSString *uei_area;
@property (nonatomic, strong)NSString *uei_address;
@property (nonatomic, strong)NSString *user_area_name;
@property (nonatomic, strong)NSString *uei_info;

@end




@interface UserInfoModel : NSObject

@property (nonatomic, strong)NSString *u_id;
@property (nonatomic, strong)NSString *u_name;
@property (nonatomic, strong)NSString *u_mobile;
@property (nonatomic, strong)NSString *u_phone;
@property (nonatomic, strong)NSString *u_sex;
@property (nonatomic, strong)NSString *u_in_time;
@property (nonatomic, strong)NSString *u_online;
@property (nonatomic, strong)NSString *u_status;
@property (nonatomic, strong)NSString *u_type;
@property (nonatomic, strong)NSString *u_task_status;
@property (nonatomic, strong)NSString *u_skills;
@property (nonatomic, strong)NSString *u_start;
@property (nonatomic, strong)NSString *u_credit;
@property (nonatomic, strong)NSString *u_top;
@property (nonatomic, strong)NSString *u_recommend;
@property (nonatomic, strong)NSString *u_jobs_num;
@property (nonatomic, strong)NSString *u_worked_num;
@property (nonatomic, strong)NSString *u_high_opinions;
@property (nonatomic, strong)NSString *u_low_opinions;
@property (nonatomic, strong)NSString *u_middle_opinions;
@property (nonatomic, strong)NSString *u_dissensions;
@property (nonatomic, strong)NSString *u_true_name;
@property (nonatomic, strong)NSString *u_idcard;
@property (nonatomic, strong)NSString *u_info;
@property (nonatomic, strong)NSString *u_img;
@property (nonatomic, strong)NSDictionary *area;
@property (nonatomic, strong)NSString *uei_province;
@property (nonatomic, strong)NSString *uei_city;
@property (nonatomic, strong)NSString *uei_area;
@property (nonatomic, strong)NSString *uei_address;

@end
