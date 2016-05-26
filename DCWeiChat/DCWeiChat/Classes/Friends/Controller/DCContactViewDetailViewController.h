//
//  DCContactViewDetailViewController.h
//  NewWeChat
//
//  Created by MornChan on 16/2/20.
//  Copyright © 2016年 MornChan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DCContactDetailDate.h"



@interface DCContactViewDetailViewController : UIViewController

@property(strong,nonatomic) DCContactDetailDate * contactDetailDate;

@property(strong,nonatomic) NSIndexPath * indexPath;

@end
