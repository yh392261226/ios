//
//  listTableView.m
//  Steel
//
//  Created by 郭健 on 2017/5/9.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "listTableView.h"
#import "mainlistTableViewCell.h"

@implementation listTableView


- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self)
    {
        
        self.scrollEnabled = NO;
        
        self.delegate = self;
        self.dataSource = self;
        
        [self registerClass:[mainlistTableViewCell class] forCellReuseIdentifier:@"cell"];
        
    }
    return self;
}






- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    mainlistTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.name.text = [_arr objectAtIndex:indexPath.row];
   
    
    if (index == indexPath)
    {
        cell.name.textColor = [UIColor redColor];
    }
    else
    {
        cell.name.textColor = [UIColor blackColor];
    }
    
    
    
    cell.name.tag = indexPath.row + 100;
    
    
    return cell;
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}





- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
 
    index = indexPath;
    
    [self reloadData];
    
    
    [self.deleage tempinfo:[NSIndexPath indexPathForRow:indexPath.row inSection:self.cellRow]];
}























@end
