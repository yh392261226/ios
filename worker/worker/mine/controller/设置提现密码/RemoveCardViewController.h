//
//  RemoveCardViewController.h
//  worker
//
//  Created by 郭健 on 2017/8/31.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "BaseViewController.h"

@interface RemoveCardViewController : BaseViewController


@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSString *card;





@property (nonatomic, strong)NSString *yanzhengmaNum;   //验证码，用于后面网络请求

@end
