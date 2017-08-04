//
//  TabbarView.h
//  worker
//
//  Created by 郭健 on 2017/7/27.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TabbarView : UIView

@property (nonatomic, strong)UIView *MainView;
@property (nonatomic, strong)UIButton *MainIcon;
@property (nonatomic, strong)UILabel *Maintitle;

@property (nonatomic, strong)UIView *JobView;
@property (nonatomic, strong)UIButton *JobIcon;
@property (nonatomic, strong)UILabel *jobtitle;

@property (nonatomic, strong)UIView *MessView;
@property (nonatomic, strong)UIButton *MessIcon;
@property (nonatomic, strong)UILabel *Messtitle;

@property (nonatomic, strong)UIView *MineView;
@property (nonatomic, strong)UIButton *MineIcon;
@property (nonatomic, strong)UILabel *Minetitle;


@property (nonatomic, strong)UIView *line;


@end
