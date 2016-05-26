//
//  DCMessageDateFrame.m
//  NewWeChat
//
//  Created by MornChan on 16/2/15.
//  Copyright © 2016年 MornChan. All rights reserved.
//
#define iconPadding 10

#define textPadding 20

#define font [UIFont systemFontOfSize:13]

#import "DCMessageDateFrame.h"
#import "DCMessageDate.h"
@class DCMessageDate;

@implementation DCMessageDateFrame



-(void)setMessageDate:(DCMessageDate *)messageDate
{
    
    _messageDate = messageDate;
    
    //头像位置
    CGFloat screenWith = [UIScreen mainScreen].bounds.size.width;
    
    CGFloat iconX,iconY = iconPadding,iconW,iconH;iconW = iconH = 40;
    
    if (messageDate.type == DCMessageTypeOther) {
        
        iconX = iconY;
        
        self.iconFrame = CGRectMake(iconX, iconY, iconW, iconH);
        
    }
    else
    {
        iconX = screenWith - iconW - iconPadding;
        
        self.iconFrame = CGRectMake(iconX, iconY, iconW, iconH);
        
    }
    
    //正文位置
    CGFloat textY = iconY;
    
    CGSize textMaxSize = CGSizeMake(180, MAXFLOAT);
    
    NSDictionary * arttri =  @{NSFontAttributeName:font};
    CGSize textRealSize =[messageDate.message boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:arttri context:nil].size;
    
    CGSize textFinalSize = CGSizeMake(textRealSize.width + 2 * textPadding, textRealSize.height + 2 *textPadding);
    
    
    CGFloat textX = (messageDate.type == DCMessageTypeOther ) ? CGRectGetMaxX(_iconFrame) + iconPadding  :
    CGRectGetMinX(_iconFrame) - iconPadding -textFinalSize.width;
        
    _textFrame = (CGRect){{textX,textY},textFinalSize};

    _cellHeight = CGRectGetMaxY(_textFrame) + textPadding;
    
    
    
    
    
    
    
}


@end
