//
//  packetViewController.m
//  worker
//
//  Created by sd on 2017/9/30.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "packetViewController.h"
#import "packetTableViewCell.h"

@interface packetViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *dataArray;
}

@property (nonatomic, strong)UITableView *tableview;

@end

@implementation packetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addhead:@"我的红包"];
    
    dataArray = [NSMutableArray array];
    
    [self tableview];
    
}


- (UITableView *)tableview
{
    if (!_tableview)
    {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 65, SCREEN_WIDTH, SCREEN_HEIGHT - 65) style:UITableViewStylePlain];
        
        _tableview.delegate = self;
        _tableview.dataSource = self;
        
        [_tableview registerClass:[packetTableViewCell class] forCellReuseIdentifier:@"cell"];
        
        [self.view addSubview:_tableview];
        
    }
    
    return _tableview;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return  dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    packetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    
    
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}























- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
