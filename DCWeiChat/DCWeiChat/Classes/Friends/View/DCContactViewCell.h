//
//  DCContactViewCell.h
//  NewWeChat
//
//  Created by MornChan on 16/2/19.
//  Copyright © 2016年 MornChan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DCContactDetailDate.h"


@interface DCContactViewCell : UITableViewCell



@property(strong,nonatomic) DCContactDetailDate * contactDetailDate;



+ (instancetype)contactViewCellWithTableView:(UITableView *)tableView;


@end
