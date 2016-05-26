//
//  DCFriendCircleCell.h
//  NewWeChat
//
//  Created by MornChan on 16/2/22.
//  Copyright © 2016年 MornChan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DCFriendCircleDateFrame;


@interface DCFriendCircleCell : UITableViewCell

@property(strong,nonatomic) DCFriendCircleDateFrame * dateFrame;

+ (instancetype)circleCellWithTableView:(UITableView *)tableView;


@end
