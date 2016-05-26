//
//  DCChatViewDetailController.h
//  NewWeChat
//
//  Created by MornChan on 16/2/14.
//  Copyright © 2016年 MornChan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DCChatViewController.h"
#import "DCContactDate.h"
#import "DCMessageDateFrame.h"
#import "DCMessageDate.h"
#import <AVFoundation/AVFoundation.h>

typedef void(^MessageBlock)(NSMutableArray * messageDate);

@class DCChatViewDetailController;

@protocol DCChatViewDetailDelegate <NSObject>

@optional

- (void)chatViewDetailController:(DCChatViewDetailController *)controller messageDate:(NSMutableArray *)messageDate;


@end




@interface DCChatViewDetailController : UIViewController

{
    //录音器
    AVAudioRecorder *recorder;
    //播放器
    AVAudioPlayer *player;
    NSDictionary *recorderSettingsDict;
    
    //定时器
    NSTimer *timer;
    //图片组
    NSMutableArray *volumImages;
    double lowPassResults;
    
    //录音名字
    NSString *playName;
}

@property(weak,nonatomic) id<DCChatViewDetailDelegate>delegate;

@property(strong,nonatomic) DCContactDate * contactDate;

@property(strong,nonatomic) NSMutableArray * messageDate;

@property(copy,nonatomic)MessageBlock messageBlock;

@end
