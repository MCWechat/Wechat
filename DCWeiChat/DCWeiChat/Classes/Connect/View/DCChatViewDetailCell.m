//
//  DCChatViewDetailCell.m
//  NewWeChat
//
//  Created by MornChan on 16/2/14.
//  Copyright © 2016年 MornChan. All rights reserved.
//

#import "DCChatViewDetailCell.h"
#import "UIImage+Extension.h"
#import <AVFoundation/AVFoundation.h>
@class DCMessageDate;

@interface DCChatViewDetailCell ()

@property(weak,nonatomic)UIButton * textView;

@property(weak,nonatomic)UIImageView * iconView;

@property(strong,nonatomic) AVAudioPlayer * player;


@end

@implementation DCChatViewDetailCell



- (AVAudioPlayer *)player
{
    if (_player == nil) {
        
        _player = [[AVAudioPlayer alloc]init];
    }
    return _player;
}
- (void)setMessageDateFrame:(DCMessageDateFrame *)messageDateFrame
{
 
    _messageDateFrame = messageDateFrame;
    
    DCMessageDate * msgd = messageDateFrame.messageDate;
    
    self.iconView.image = [UIImage imageNamed:self.messageDateFrame.messageDate.icon];
    self.iconView.frame = self.messageDateFrame.iconFrame;
    
    
    [self.textView setTitle: messageDateFrame.messageDate.message
                   forState:UIControlStateNormal];
    [self.textView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    self.textView.frame = messageDateFrame.textFrame;
    if (msgd.type == DCMessageTypeMe) {
        
        [self.textView setBackgroundImage:[UIImage resizableImage:@"chat_send_nor"] forState:UIControlStateNormal];
        [self.textView setBackgroundImage:[UIImage resizableImage:@"chat_send_pre"] forState:UIControlStateSelected];
        
    }
    else
    {
        [self.textView setBackgroundImage:[UIImage resizableImage:@"chat_recive_nor"] forState:UIControlStateNormal];
        [self.textView setBackgroundImage:[UIImage resizableImage:@"chat_recive_pre"] forState:UIControlStateSelected];
    }
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
        
    {
        self.backgroundColor = [UIColor clearColor];
        
        UIImageView * iconView = [[UIImageView alloc]init];
        UIButton * textView = [[UIButton alloc]init];
        
        [textView addTarget:self action:@selector(playVoice) forControlEvents:UIControlEventTouchUpInside];
        
        textView.titleLabel.numberOfLines = 0;
        textView.titleLabel.font = [UIFont systemFontOfSize:13];
        textView.contentEdgeInsets = UIEdgeInsetsMake(10, 15, 10, 15);
        
        [self.contentView addSubview:iconView];
        [self.contentView addSubview:textView];
        
        self.textView = textView;
        self.iconView = iconView;

        
    }
    
    return self;
}

- (void)playVoice
{
    
    NSError *playerError;
    DCMessageDate * messageDate = self.messageDateFrame.messageDate;
    

    
    //播放
    self.player = nil;
    
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL URLWithString:messageDate.voiceName] error:&playerError];
    
    self.player.volume = 1.0f;
    
    if (self.player == nil)
    {
        NSLog(@"ERror creating player: %@", [playerError description]);
    }else{
        [self.player play];
    }

    
}




@end
