//
//  ServiceViewController.h
//  worker
//
//  Created by 郭健 on 2017/8/15.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "BaseViewController.h"


@interface ServiceData : NSObject


@property (nonatomic, strong)NSString *a_id;
@property (nonatomic, strong)NSString *a_title;
@property (nonatomic, strong)NSString *a_in_time;
@property (nonatomic, strong)NSString *a_link;
@property (nonatomic, strong)NSString *a_img;
@property (nonatomic, strong)NSString *a_top;
@property (nonatomic, strong)NSString *a_recommend;
@property (nonatomic, strong)NSString *a_desc;


@end



@interface ServiceViewController : BaseViewController
{
    UIWebView *webview;

}

@property (nonatomic, strong)NSString *type;   //0是服务条款过来，   1是登录页面过来

@end
