//
//  DCChatViewSearchResultController.h
//  NewWeChat
//
//  Created by MornChan on 16/2/29.
//  Copyright © 2016年 MornChan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DCChatViewSearchResultController : UITableViewController

typedef NSArray * (^resultDate)();

@property(copy,nonatomic)resultDate restultdate;

@property(strong,nonatomic) NSArray * date;


@end
