//
//  DCImageView.h
//  NewWeChat
//
//  Created by MornChan on 16/2/23.
//  Copyright © 2016年 MornChan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DCImageView : UIView

@property(strong,nonatomic) NSArray * photos;

@property(assign,nonatomic) CGSize imageViewSize;


//+ (CGSize)imageViewSizeWithPhotos:(NSArray *)photos;
+ (CGSize)sizeWithCount:(int)count;
@end
