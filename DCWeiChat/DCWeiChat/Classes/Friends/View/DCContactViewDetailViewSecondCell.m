//
//  DCContactViewDetailViewSecondCell.m
//  NewWeChat
//
//  Created by MornChan on 16/2/20.
//  Copyright © 2016年 MornChan. All rights reserved.
//

#import "DCContactViewDetailViewSecondCell.h"
@class DCContactViewDetailViewSecondCell;

@implementation DCContactViewDetailViewSecondCell



+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"cc";
    DCContactViewDetailViewSecondCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle]loadNibNamed:@"DCContactViewDetailViewSecondCell" owner:nil options:nil]lastObject];
        
    }
    
    return cell;
}
@end
