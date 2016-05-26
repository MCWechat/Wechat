//
//  DCContactViewDetailViewThirdCell.m
//  NewWeChat
//
//  Created by MornChan on 16/2/20.
//  Copyright © 2016年 MornChan. All rights reserved.
//

#import "DCContactViewDetailViewThirdCell.h"

@implementation DCContactViewDetailViewThirdCell



+ (instancetype)cellWithTableView : (UITableView *) tableView
{
    static NSString *ID = @"cc";
    DCContactViewDetailViewThirdCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle]loadNibNamed:@"DCContactViewDetailViewThirdCell" owner:nil options:nil]lastObject];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;
}
@end
