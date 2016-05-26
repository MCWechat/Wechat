//
//  DCDiscoverViewSendTextController.h
//  NewWeChat
//
//  Created by MornChan on 16/2/25.
//  Copyright © 2016年 MornChan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DCDiscoverViewSendTextController;
@protocol DCDiscoverViewSenTextDelegate <NSObject>


@optional
- (void)sendTextWithController:(DCDiscoverViewSendTextController *)controller WithText:(NSString *)text;

@end

@interface DCDiscoverViewSendTextController : UIViewController

@property(weak,nonatomic)id<DCDiscoverViewSenTextDelegate>delegate;

@end
