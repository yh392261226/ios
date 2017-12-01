//
//  TextViewController.m
//  worker
//
//  Created by ios_g on 2017/11/24.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "TextViewController.h"

@interface TextViewController ()<UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate>

@end

@implementation TextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.title = @"Test";
    self.navigationController.navigationBar.translucent = NO;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    tableView.backgroundColor = [UIColor whiteColor];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    self.originFrame = CGRectMake(0, 0, SCREEN_WIDTH, 199);
    
    self.headerView = [[UIView alloc] initWithFrame:self.originFrame];
    
    self.headerScrollView = [[UIScrollView alloc] initWithFrame:self.originFrame];
    
    [self.headerView addSubview:self.headerScrollView];
    
    self.imgView = [[UIImageView alloc] initWithFrame:self.originFrame];
    
    self.imgView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    self.imgView.contentMode = UIViewContentModeScaleAspectFill;
    self.imgView.image = [UIImage imageNamed:@"11111"];
    [self.headerScrollView addSubview:self.imgView];
    
    tableView.tableHeaderView = self.headerView;
    
    
    
    
}




- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = @"爱迪生";
    
    return cell;
}


#pragma mark ---- UIScrollView Delegate Method ----
- (void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint offset = scrollView.contentOffset;
    NSLog(@"offset: %f",offset.y);
    
    if (offset.y < 0)
    {
        CGFloat delta = 0.0f;
        CGRect rect = self.originFrame;
        delta = fabs(MIN(0.0f, offset.y));
        rect.origin.y -= delta;
        rect.size.height += delta;
        self.headerScrollView.frame = rect;
        self.headerView.clipsToBounds = NO;
        
    }
    else
    {
        CGRect frame = self.headerScrollView.frame;
        frame.origin.y = offset.y * 0.5;
        self.headerScrollView.frame = frame;
        self.headerView.clipsToBounds = YES;
        self.imgView.alpha = (frame.size.height - offset.y) / frame.size.height * 0.6 + 0.4;
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
