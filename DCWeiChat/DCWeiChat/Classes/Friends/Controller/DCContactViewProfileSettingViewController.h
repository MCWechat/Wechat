//
//  DCContactViewProfileSettingViewController.h
//  NewWeChat
//
//  Created by MornChan on 16/2/20.
//  Copyright © 2016年 MornChan. All rights reserved.
//

#import <UIKit/UIKit.h>


@class DCContactViewProfileSettingViewController;
@protocol DCContactViewDetailViewDelegate <NSObject>


@optional

- (void)detailView:(DCContactViewProfileSettingViewController *)detailViewController deleteBtnClickedWithIndexPath:(NSIndexPath *)indexPath;

@end
@interface DCContactViewProfileSettingViewController : UITableViewController

@property(weak,nonatomic)id<DCContactViewDetailViewDelegate>delegate;


@end
