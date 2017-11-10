//
//  SetViewController.m
//  worker
//
//  Created by 郭健 on 2017/8/14.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "SetViewController.h"
#import "SetTableViewCell.h"
#import "MessageViewController.h"
#import "BoundPhoneViewController.h"
#import "WeViewController.h"

@interface SetViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *dataArray;
}


@property (nonatomic, strong)UITableView *tableview;

@end

@implementation SetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    dataArray = [NSMutableArray arrayWithObjects:@"清除缓存", @"消息提示",@"关于我们", nil];
    
    [self addhead:@"设置"];
    
    [self slitherBack:self.navigationController];
    
    [self tableview];
    
}



#pragma tableview 代理方法

- (UITableView *)tableview
{
    if (!_tableview)
    {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStyleGrouped];
        
        [_tableview registerClass:[SetTableViewCell class] forCellReuseIdentifier:@"cell"];
        
        _tableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.1)];
        _tableview.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.1)];
        
        
        _tableview.backgroundColor = [myselfway stringTOColor:@"0xC4CED3"];
        
        _tableview.delegate = self;
        _tableview.dataSource = self;
        
        [self.view addSubview:_tableview];
    }
    
    return _tableview;
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return dataArray.count;
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    SetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
//    if (indexPath.section == 0)
//    {
//        NSString *str = @"15840344241";
//
//        cell.data.text = [str stringByReplacingCharactersInRange:NSMakeRange(3, 4)  withString:@"****"];
//    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    cell.name.text = [dataArray objectAtIndex:indexPath.section];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 2)
    {
        return 70;
    }
    else
    {
        return 0.1;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    self.hidesBottomBarWhenPushed = YES;

    if (indexPath.section == 1)
    {
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0f)
        {
            UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];

            if (UIUserNotificationTypeNone == setting.types)
            {
                NSLog(@"推送关闭");

                MessageViewController *temp = [[MessageViewController alloc] init];

                [self.navigationController pushViewController:temp animated:YES];


            }
            else
            {
                NSLog(@"推送打开");
            }
        }
        else
        {
            UIRemoteNotificationType type = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];

            if(UIRemoteNotificationTypeNone == type)
            {
                NSLog(@"推送关闭");
            }
            else
            {
                NSLog(@"推送打开");
            }
        }
    }
    
    
    
    
    
    
    
//    else if (indexPath.section == 0)
//    {
//        BoundPhoneViewController *temp = [[BoundPhoneViewController alloc] init];
//
//        [self.navigationController pushViewController:temp animated:YES];
//    }
    else if (indexPath.section == 2)
    {
        WeViewController *temp = [[WeViewController alloc] init];
        
        [self.navigationController pushViewController:temp animated:YES];
    }
    else
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"是否清空全部缓存?" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action)
                          {
                              
                          }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                          {
                            
                              
                          }]];
        
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    
}



- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footview = [[UIView alloc] init];
    
    if (section == 2)
    {
        UIButton *save = [UIButton buttonWithType:UIButtonTypeSystem];
        
        [save setTitle:@"退出登录" forState:UIControlStateNormal];
        
        [save addTarget:self action:@selector(Escbtn) forControlEvents:UIControlEventTouchUpInside];
        
        save.backgroundColor = [myselfway stringTOColor:@"0x2E84F8"];
        
        save.layer.cornerRadius = 5;
        
        save.frame = CGRectMake(15, 20, SCREEN_WIDTH - 30, 40);
        
        save.tintColor = [UIColor whiteColor];
        
        [footview addSubview:save];
    }
    
    
    return footview;
   
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    
    
    return view;
}

#pragma 自己定义的方法

//退出登录
- (void)Escbtn
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确认安全退出？" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action)
                      {
                          
                      }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                      {
                          
                          //多用户登录缓存使用
                          
//                          NSString *pathDocuments = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//
//                          [Singleton instance].dataPath = [NSString stringWithFormat:@"%@/User", pathDocuments];
//
//                          NSString *path = [[Singleton instance].dataPath stringByAppendingPathComponent:@"userName.plist"];
//
//                          NSMutableArray *arr = [NSMutableArray arrayWithContentsOfFile:path];
//
//                          NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//
//                          [dic setValue:@"defaultUser" forKey:@"phone"];
//
//                          [arr insertObject:dic atIndex:0];
//
//                          [arr writeToFile:path atomically:YES];
                          
                          
                          [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"u_id"];
                          
                          [self.delegate Sussecc];
                          
                          
                          [self.navigationController popViewControllerAnimated:YES];
                          
                      }]];
    
    
    [self presentViewController:alert animated:YES completion:nil];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
