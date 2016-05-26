//
//  DCDiscoverViewFriendCircleController.h
//  NewWeChat
//
//  Created by MornChan on 16/2/21.
//  Copyright © 2016年 MornChan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DCDiscoverViewFriendCircleController;

@protocol DCDiscoverViewFriendCircleDelegate<NSObject>


@optional
-(void)friendCircleDidScrollWithController:(DCDiscoverViewFriendCircleController *)controller;

@end

@interface DCDiscoverViewFriendCircleController : UIViewController
@property(weak,nonatomic) id<DCDiscoverViewFriendCircleDelegate>delegate;


@end
