//
//  DCFriendCircleDateFrame.h
//  NewWeChat
//
//  Created by MornChan on 16/2/21.
//  Copyright © 2016年 MornChan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DCFriendCircleDate.h"
#import "DCStatuses.h"

@interface DCFriendCircleDateFrame : NSObject

@property(assign,nonatomic) CGRect iconFrame;

@property(assign,nonatomic) CGRect nameFrame;

@property(assign,nonatomic) CGRect messageFrame;

@property(assign,nonatomic) CGRect imageViewFrame;

@property(assign,nonatomic) CGFloat cellHeight;

//@property(strong,nonatomic) DCFriendCircleDate * date;

@property(strong,nonatomic) DCStatuses * statuses;


@end
