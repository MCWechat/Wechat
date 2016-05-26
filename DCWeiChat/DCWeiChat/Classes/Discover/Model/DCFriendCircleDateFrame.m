//
//  DCFriendCircleDateFrame.m
//  NewWeChat
//
//  Created by MornChan on 16/2/21.
//  Copyright © 2016年 MornChan. All rights reserved.
//
#define font [UIFont systemFontOfSize:13]
#define padding 10


#import "DCFriendCircleDateFrame.h"
#import "DCImageView.h"


@implementation DCFriendCircleDateFrame


- (void)setStatuses:(DCStatuses *)statuses
{
    _statuses = statuses;
    
    CGFloat iconWH = 40;
    
    self.iconFrame = CGRectMake(padding, padding * 2, iconWH, iconWH);
    
    
    
    CGFloat nameX = CGRectGetMaxX(self.iconFrame) + padding;
    
    CGFloat nameY = self.iconFrame.origin.y;
    
    CGSize nameMaxSize = {200,15};
    
    NSDictionary * arttri =  @{NSFontAttributeName:font};
    
    self.nameFrame  = (CGRect){{nameX, nameY},nameMaxSize};
    
    

    CGFloat messageX = nameX;
    
    CGFloat messageY = CGRectGetMaxY(self.nameFrame) + padding;

    CGSize messageMaxSize = {250,MAXFLOAT};
    
    CGSize messageFinalSize =[statuses.text boundingRectWithSize:messageMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:arttri context:nil].size;
    
    self.messageFrame = (CGRect){{messageX,messageY},messageFinalSize};
    
//    
    if (statuses.pic_urls.count) {
        
        NSLog(@"pic_url.count : %ld",statuses.pic_urls.count);
        
        CGFloat imageViewX = messageX;
        
        CGFloat imageViewY = CGRectGetMaxY(self.messageFrame) + padding;
        
        CGSize imageSize = [DCImageView sizeWithCount:(int)statuses.pic_urls.count];
        
        self.imageViewFrame = (CGRect){{imageViewX,imageViewY},imageSize};
                
        self.cellHeight = CGRectGetMaxY(self.imageViewFrame) + padding;
        

    }
    else self.cellHeight = CGRectGetMaxY(self.messageFrame) + padding;
}

@end
