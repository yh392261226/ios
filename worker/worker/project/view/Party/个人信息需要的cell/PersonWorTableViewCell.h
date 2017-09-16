//
//  PersonWorTableViewCell.h
//  worker
//
//  Created by 郭健 on 2017/9/8.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonWorTableViewCell : UITableViewCell
{
    int number;
}

@property (nonatomic, strong)UILabel *workerName;



@property (nonatomic, strong)NSMutableArray *dataArray;

@end
