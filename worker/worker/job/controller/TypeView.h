//
//  TypeView.h
//  worker
//
//  Created by 郭健 on 2017/8/8.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import <UIKit/UIKit.h>



@protocol temIndex <NSObject>

- (void)tempVal: (NSInteger)type;

@end

@interface TypeView : UIView


@property (nonatomic, weak)id <temIndex> delegate;

@property (nonatomic, strong)NSMutableArray *nameArray;

@property (nonatomic, strong)UIButton *btn;
@property (nonatomic, strong)UILabel *name;

@end
