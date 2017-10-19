//
//  DressingWorkerViewController.h
//  worker
//
//  Created by 郭健 on 2017/8/16.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "BaseViewController.h"


@protocol TransmitVal


- (void)DressWorkerData:(NSString *)name adree:(NSString *)adree proData:(NSString *)proData proMoney:(NSString *)proMoney proTime:(NSString *)proTime proType:(NSString *)proType proWorker:(NSString *)proWorker;


@end


@interface DressingWorkerViewController : BaseViewController



@property (nonatomic, strong) id <TransmitVal> delegate;



@end
