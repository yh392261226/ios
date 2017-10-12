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
            
            //创建一个默认账号
            
            NSFileManager *fileManager = [[NSFileManager alloc] init];
            
            NSString *pathDocuments = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
            
            NSString *dataPath = [NSString stringWithFormat:@"%@/User", pathDocuments];
            
            obj.dataPath = [NSString stringWithFormat:@"%@/defaultUser", dataPath];
            
            // 判断文件夹是否存在，如果不存在，则创建
            if (![[NSFileManager defaultManager] fileExistsAtPath:obj.dataPath])
            {
                [fileManager createDirectoryAtPath:obj.dataPath withIntermediateDirectories:YES attributes:nil error:nil];
            }
            else
            {
                
            }
            
           
        
        }
    }
  
    return obj;
}




@end
