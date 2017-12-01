//
//  Singleton.h
//  Steel
//
//  Created by 郭健 on 2017/6/27.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginViewController.h"

@interface Singleton : NSObject <NSCopying, NSMutableCopying>
{
  
}

@property (nonatomic, strong)NSString *dataPath;
@property (nonatomic, strong)FMDatabaseQueue *queue;

@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)UIImage *icon;
@property (nonatomic, strong)NSString *sex;

+ (Singleton *)instance;


@end
