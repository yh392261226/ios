//
//  RechargeViewController.h
//  worker
//
//  Created by 郭健 on 2017/8/7.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "BaseViewController.h"

@interface wechatGet : NSObject

@property (nonatomic, strong)NSString *appId;
@property (nonatomic, strong)NSString *timeStamp;
@property (nonatomic, strong)NSString *nonceStr;
@property (nonatomic, strong)NSString *partnerid;    
@property (nonatomic, strong)NSString *package;
@property (nonatomic, strong)NSString *prepay_id;
@property (nonatomic, strong)NSString *paySign;
@property (nonatomic, strong)NSString *signType;

@end

@interface RechargeViewController : BaseViewController

@end
