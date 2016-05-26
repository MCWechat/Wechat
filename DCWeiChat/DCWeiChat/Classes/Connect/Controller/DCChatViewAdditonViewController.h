//
//  DCChatViewAdditonViewController.h
//  NewWeChat
//
//  Created by MornChan on 16/2/14.
//  Copyright © 2016年 MornChan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DCChatViewAdditonViewController;

@protocol DCChatViewAdditonViewDelegate <NSObject>


@optional
-(void)scanQRBtnClickWithController:(DCChatViewAdditonViewController *)controller;

@end

@interface DCChatViewAdditonViewController : UITableViewController

@property(strong,nonatomic) id<DCChatViewAdditonViewDelegate>delegate;

@end
