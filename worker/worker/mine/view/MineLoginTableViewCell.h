//
//  MineLoginTableViewCell.h
//  worker
//
//  Created by 郭健 on 2017/8/1.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineLoginTableViewCell : UITableViewCell

@property (nonatomic, strong)UIImageView *IconImage;  //头像

@property (nonatomic, strong)UIButton *loginBtn;      //登录按钮

@property (nonatomic, strong)UILabel *introduce;      //开启轻松生活字样

@property (nonatomic, strong)UILabel *userName;       //用户名称

@property (nonatomic, strong)UIImageView *userImage;  //用户性别

@property (nonatomic, strong)UIImageView *isstate;    //用户信息状态

@property (nonatomic, strong)UIImageView *typeButton;  //用户状态开关按钮

@end
