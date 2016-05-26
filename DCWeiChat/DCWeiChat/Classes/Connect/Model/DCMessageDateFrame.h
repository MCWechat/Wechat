//
//  DCMessageDateFrame.h
//  NewWeChat
//
//  Created by MornChan on 16/2/15.
//  Copyright © 2016年 MornChan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "DCMessageDate.h"


@interface DCMessageDateFrame : NSObject

@property (assign,nonatomic)CGRect iconFrame;

@property (assign,nonatomic)CGRect textFrame;

@property (assign,nonatomic)CGFloat cellHeight;

@property(strong,nonatomic) DCMessageDate * messageDate;

@end
