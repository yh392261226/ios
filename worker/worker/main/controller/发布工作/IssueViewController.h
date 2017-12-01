//
//  IssueViewController.h
//  worker
//
//  Created by 郭健 on 2017/8/9.
//  Copyright © 2017年 郭健. All rights reserved.
//



#import "BaseViewController.h"



@interface IssueViewController : BaseViewController
{
    NSString *p_Name;
    NSString *p_info;
    NSString *p_proType;
    NSString *p_province;
    NSString *p_city;
    NSString *p_area;
    NSString *p_adree;
}



@property (nonatomic)CGFloat longitudeWor;     //经度
@property (nonatomic)CGFloat latitudeWor;      //维度



@end

