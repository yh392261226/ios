//
//  SYPasswordView.h
//  PasswordDemo
//
//  Created by aDu on 2017/2/6.
//  Copyright © 2017年 DuKaiShun. All rights reserved.
//

#import <UIKit/UIKit.h>



@protocol FirstNum <NSObject>


//返回编辑密码
- (void)password: (NSString *)num;


@end

@interface SYPasswordView : UIView<UITextFieldDelegate>


@property (nonatomic, weak)id <FirstNum> delegate;


@property (nonatomic, strong) UITextField *textField;

/**
 *  清除密码
 */
- (void)clearUpPassword;

@end
