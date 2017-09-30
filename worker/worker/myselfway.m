//
//  myselfway.m
//  worker
//
//  Created by 郭健 on 2017/7/26.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "myselfway.h"

@implementation myselfway

+ (UIColor *) stringTOColor:(NSString *)str

{
    if (!str || [str isEqualToString:@""])
    {
        return nil;
    }
    
    unsigned red,green,blue;
    
    NSRange range;
    
    range.length = 2;
    
    range.location = 2;
    
    [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&red];
    
    range.location = 4;
    
    [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&green];
    
    range.location = 6;
    
    [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&blue];
    
    UIColor *color= [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:1];
    
    return color;
    
}


+ (void)initHeadView: (UIView *)backview title:(NSString *)titleText
{
    backview.backgroundColor = [myselfway stringTOColor:@"0xF3F3F3"];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    
    view.backgroundColor = [myselfway stringTOColor:@"0x3E9FEA"];
    
    [backview addSubview:view];
    
    UILabel *headlabel = [[UILabel alloc] init];
    
    headlabel.text = titleText;
    
    [headlabel setTextColor:[UIColor whiteColor]];
    
    headlabel.textAlignment = NSTextAlignmentCenter;
    
    headlabel.font = [UIFont systemFontOfSize:17];
    
    [backview addSubview:headlabel];
    
    [headlabel mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.center.equalTo(backview);
         make.bottom.mas_equalTo(view).offset(-7);
         make.height.mas_equalTo(30);
         make.width.mas_equalTo(200);
     }];
    
   

}


+ (NSDictionary *)entityToDictionary:(id)entity
{
    
    Class clazz = [entity class];
    u_int count;
    
    objc_property_t* properties = class_copyPropertyList(clazz, &count);
    NSMutableArray* propertyArray = [NSMutableArray arrayWithCapacity:count];
    NSMutableArray* valueArray = [NSMutableArray arrayWithCapacity:count];
    
    for (int i = 0; i < count ; i++)
    {
        objc_property_t prop = properties[i];
        const char* propertyName = property_getName(prop);
        
        [propertyArray addObject:[NSString stringWithCString:propertyName encoding:NSUTF8StringEncoding]];
        
        
        id value =  [entity performSelector:NSSelectorFromString([NSString stringWithUTF8String:propertyName])];
        if(value == nil)
            [valueArray addObject:[NSNull null]];
        else {
            [valueArray addObject:value];
        }
        //        NSLog(@"%@",value);
    }
    
    free(properties);
    
    NSDictionary* returnDic = [NSDictionary dictionaryWithObjects:valueArray forKeys:propertyArray];
    
    
    return returnDic;
}



//十六进制转二进制
+ (NSString *)getBinaryByhex:(NSString *)hex
{
    NSMutableDictionary  *hexDic = [[NSMutableDictionary alloc] init];
    
    hexDic = [[NSMutableDictionary alloc] initWithCapacity:16];
    
    [hexDic setObject:@"0000" forKey:@"0"];
    
    [hexDic setObject:@"0001" forKey:@"1"];
    
    [hexDic setObject:@"0010" forKey:@"2"];
    
    [hexDic setObject:@"0011" forKey:@"3"];
    
    [hexDic setObject:@"0100" forKey:@"4"];
    
    [hexDic setObject:@"0101" forKey:@"5"];
    
    [hexDic setObject:@"0110" forKey:@"6"];
    
    [hexDic setObject:@"0111" forKey:@"7"];
    
    [hexDic setObject:@"1000" forKey:@"8"];
    
    [hexDic setObject:@"1001" forKey:@"9"];
    
    [hexDic setObject:@"1010" forKey:@"A"];
    
    [hexDic setObject:@"1011" forKey:@"B"];
    
    [hexDic setObject:@"1100" forKey:@"C"];
    
    [hexDic setObject:@"1101" forKey:@"D"];
    
    [hexDic setObject:@"1110" forKey:@"E"];
    
    [hexDic setObject:@"1111" forKey:@"F"];
    
    NSMutableString *binaryString=[[NSMutableString alloc] init];
    
    for (int i=0; i<[hex length]; i++) {
        
        NSRange rage;
        
        rage.length = 1;
        
        rage.location = i;
        
        NSString *key = [hex substringWithRange:rage];
        
        //NSLog(@"%@",[NSString stringWithFormat:@"%@",[hexDic objectForKey:key]]);
        
        binaryString = [NSString stringWithFormat:@"%@%@",binaryString,[NSString stringWithFormat:@"%@",[hexDic objectForKey:key]]];
        
    }
    
    //NSLog(@"转化后的二进制为:%@",binaryString);
    
    return binaryString;
    
}

@end
