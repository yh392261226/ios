//
//  myselfway.h
//  worker
//
//  Created by 郭健 on 2017/7/26.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface myselfway : NSObject

//16进制设置颜色
+ (UIColor *) stringTOColor:(NSString *)str;

//设置navi主页的headview
+ (void)initHeadView: (UIView *)backview title:(NSString *)titleText;

//类的对象转成字典对象
+ (NSDictionary *)entityToDictionary:(id)entity;

//十六进制转二进制
+ (NSString *)getBinaryByhex:(NSString *)hex;

//获取本地用户，判断是否登录
+ (NSString *)userPath;

//输入两个时间戳，获取差值
+ (long long)getDurationStartTime:(NSString *)startTime endTime:(NSString *)endTime;

//时间戳转化时间
+ (NSString *)timeWithTimeIntervalString:(NSString *)timeString;

//字典转json
+ (NSString *)convertToJsonData:(NSDictionary *)dict;

//数组转json
+ (NSString *)arrayToJSONString:(NSArray *)array;

//字典转成字符串
+ (NSString *)dictionaryToJson:(NSDictionary *)dic;

+ (NSString *)dealWithParam:(NSDictionary *)param;

@end
