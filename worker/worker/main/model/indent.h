//
//  indent.h
//  worker
//
//  Created by sd on 2017/10/13.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface selecdType : NSObject

@property (nonatomic, strong)NSString *bigType;       //分辨哪个section

@end


@interface firstModel : selecdType

@property (nonatomic, strong)NSString *type;             //分辨那个cell

@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSString *data;
@property (nonatomic, strong)NSString *name_id;


@property (nonatomic, strong)NSString *province_id;   //省市区ID
@property (nonatomic, strong)NSString *city_id;
@property (nonatomic, strong)NSString *district_id;

@end


@interface elseModel : selecdType

@property (nonatomic, strong)NSString *workerType;       //分辨那个cell

@property (nonatomic, strong)NSString *worker;
@property (nonatomic, strong)NSString *personNum;
@property (nonatomic, strong)NSString *money;


@property (nonatomic, strong)NSString *startTime;
@property (nonatomic, strong)NSString *endTime;
@property (nonatomic, strong)NSString *skill;      //工种ID

@property (nonatomic, strong)NSString *workerName;
@property (nonatomic, strong)NSString *placeData;

@end

@interface indent : NSObject

@end
