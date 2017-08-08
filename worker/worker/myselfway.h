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





@end
