//
//  listTableView.h
//  Steel
//
//  Created by 郭健 on 2017/5/9.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol tpinfo <NSObject>

- (void)tempinfo: (NSInteger)info;

@end

@interface listTableView : UITableView<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong)id <tpinfo> deleage;

@property (nonatomic, strong)NSMutableArray *arr;

@end
