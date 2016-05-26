//
//  DCChatViewCell.h
//  NewWeChat
//
//  Created by MornChan on 16/2/14.
//  Copyright © 2016年 MornChan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DCContactDate;

@interface DCChatViewCell : UITableViewCell

@property(strong,nonatomic) DCContactDate * date;

+ (instancetype)chatViewCellWithTableView:(UITableView *)tableView;

@end
