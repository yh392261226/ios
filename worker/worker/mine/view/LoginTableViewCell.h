//
//  LoginTableViewCell.h
//  worker
//
//  Created by 郭健 on 2017/8/9.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginTableViewCell : UITableViewCell

@property (nonatomic, strong)UIView *view;

@property (nonatomic, strong)UILabel *line;

@property (nonatomic, strong)UIImageView *User;
@property (nonatomic, strong)UIImageView *Password;

@property (nonatomic, strong)UITextField *textuser;
@property (nonatomic, strong)UITextField *textpassword;

@property (nonatomic, strong)UIButton *login;


@property (nonatomic, strong)UIButton *yanzhengma;

@property (nonatomic, strong)UILabel *label;


@end
