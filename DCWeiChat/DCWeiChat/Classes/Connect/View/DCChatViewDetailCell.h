//
//  DCChatViewDetailCell.h
//  NewWeChat
//
//  Created by MornChan on 16/2/14.
//  Copyright © 2016年 MornChan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DCMessageDate.h"
#import "DCMessageDateFrame.h"


@interface DCChatViewDetailCell : UITableViewCell

@property(strong,nonatomic) DCMessageDateFrame * messageDateFrame;

@property(strong,nonatomic) DCMessageDate * messsageDate;

@end
