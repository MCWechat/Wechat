//
//  DCContactViewDetailViewFirstCell.m
//  NewWeChat
//
//  Created by MornChan on 16/2/20.
//  Copyright © 2016年 MornChan. All rights reserved.
//

#import "DCContactViewDetailViewFirstCell.h"
@class DCContactViewDetailViewFirstCell;


@implementation DCContactViewDetailViewFirstCell


+ (instancetype) cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"cc";
    DCContactViewDetailViewFirstCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle]loadNibNamed:@"DCContactViewDetailViewFirstCell" owner:nil options:nil]lastObject];
        
    }
    
    return cell;

}

@end
