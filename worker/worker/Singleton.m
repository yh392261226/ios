//
//  Singleton.m
//  Steel
//
//  Created by 郭健 on 2017/6/27.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "Singleton.h"


@implementation Singleton

+ (Singleton *)instance
{
    static Singleton *obj = nil;
    
    @synchronized ([Singleton class])
    {
        if (obj == nil)
        {
            obj = [[Singleton alloc] init];
            
            NSString *str = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
            
            obj.dataPath = [NSString stringWithFormat:@"%@/workerList.db",str];
            
           
        
        }
    }
  
    return obj;
}




@end
