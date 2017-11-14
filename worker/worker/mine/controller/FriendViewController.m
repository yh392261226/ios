//
//  FriendViewController.m
//  worker
//
//  Created by 郭健 on 2017/8/21.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "FriendViewController.h"
#import <UShareUI/UShareUI.h>

@interface FriendViewController ()

@end

@implementation FriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self addhead:@"邀请好友"];
    
    [self slitherBack:self.navigationController];
    
    [self initView];
}

- (void)initView
{
    UIView *back = [[UIView alloc] initWithFrame:CGRectMake(0, 65, SCREEN_WIDTH, SCREEN_HEIGHT - 65)];
    
    back.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:back];
   
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(70, 130, SCREEN_WIDTH - 140, 60)];
    
    label.numberOfLines = 2;
    
    label.textColor = [UIColor grayColor];
    
    label.font = [UIFont systemFontOfSize:18];
    
    label.textAlignment = NSTextAlignmentCenter;
    
    label.text = @"邀请好友加入钢建众工app一起开启轻松的工作与生活!";
    
    [back addSubview:label];
    
    
    UIButton *friend = [UIButton buttonWithType:UIButtonTypeCustom];
    
    friend.frame = CGRectMake(120, 230, SCREEN_WIDTH - 240, 35);
    
    friend.backgroundColor = [myselfway stringTOColor:@"0xFC4154"];
    
    friend.layer.cornerRadius = 8;
    
    [friend setTitle:@"邀请好友" forState:0];
    
    friend.titleLabel.font = [UIFont systemFontOfSize:20];
    
    [friend setTitleColor:[UIColor whiteColor] forState:0];
    
    [friend addTarget:self action:@selector(friendBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [back addSubview:friend];
    
}

//邀请好友按钮
- (void)friendBtn: (id)sender
{
    //显示分享面板
    //        [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo)
    //        {
    //            // 根据获取的platformType确定所选平台进行下一步操作
    //        }];
    
    //如平台应用未安装，或平台应用不支持等会进行隐藏。 由于以上原因，在模拟器上部分平台会隐藏   ,,,  以下方法可设置平台顺序
    
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_Sina),@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_WechatSession)]];
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        // 根据获取的platformType确定所选平台进行下一步操作
        
        NSLog(@"分享");
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
