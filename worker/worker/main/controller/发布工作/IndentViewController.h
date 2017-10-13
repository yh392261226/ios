//
//  IndentViewController.h
//  worker
//
//  Created by sd on 2017/10/13.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "BaseViewController.h"

@interface IndentViewController : BaseViewController

@property (nonatomic)CGFloat longitudeWor;     //经度
@property (nonatomic)CGFloat latitudeWor;      //维度

@property (nonatomic, strong)NSMutableArray *postArray;   //上传服务器的数据
@property (nonatomic, strong)NSMutableArray *modelArray;   //支撑页面数据的数组


@end
