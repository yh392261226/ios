//
//  PriceTableview.h
//  worker
//
//  Created by sd on 2017/10/14.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RedPrice : NSObject

@property (nonatomic, strong)NSString *b_id;
@property (nonatomic, strong)NSString *bt_id;
@property (nonatomic, strong)NSString *bd_id;
@property (nonatomic, strong)NSString *b_start_time;
@property (nonatomic, strong)NSString *b_end_time;
@property (nonatomic, strong)NSString *b_total;
@property (nonatomic, strong)NSString *b_offset;
@property (nonatomic, strong)NSString *b_status;
@property (nonatomic, strong)NSString *b_type;
@property (nonatomic, strong)NSString *b_author;
@property (nonatomic, strong)NSString *b_last_editor;
@property (nonatomic, strong)NSString *b_in_time;
@property (nonatomic, strong)NSString *b_last_edit_time;
@property (nonatomic, strong)NSString *b_amount;
@property (nonatomic, strong)NSString *b_info;
@property (nonatomic, strong)NSString *bd_serial;
@property (nonatomic, strong)NSString *bd_author;
@property (nonatomic, strong)NSString *bd_use_time;
@property (nonatomic, strong)NSString *bt_name;
@property (nonatomic, strong)NSString *bt_info;
@property (nonatomic, strong)NSString *bt_withdraw;


@property (nonatomic, strong)NSString *type;       //自己加的属性， 判断cell类型

@end



@interface PriceTableview : UITableView <UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *dataArray;
    
    NSIndexPath *index;
}

@end
