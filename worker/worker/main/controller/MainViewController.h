//
//  MainViewController.h
//  worker
//
//  Created by 郭健 on 2017/7/27.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MessDataDetail : NSObject

@property (nonatomic, strong)NSString *wm_title;
@property (nonatomic, strong)NSString *um_in_time;
@property (nonatomic, strong)NSString *wm_type;
@property (nonatomic, strong)NSString *wm_id;
@property (nonatomic, strong)NSString *um_id;
@property (nonatomic, strong)NSString *wm_desc;
@property (nonatomic, strong)NSString *um_status;    //状态， 判断已读未读

@end





@interface cityData : NSObject

@property (nonatomic, strong)NSString *r_id;
@property (nonatomic, strong)NSString *r_pid;
@property (nonatomic, strong)NSString *r_shortname;
@property (nonatomic, strong)NSString *r_name;
@property (nonatomic, strong)NSString *r_first;
@property (nonatomic, strong)NSString *r_hot;
@property (nonatomic, strong)NSString *r_status;


@end



@interface MainViewController : UIViewController

@end
