//
//  DCSelectPhotosView.h
//  NewWeChat
//
//  Created by MornChan on 16/3/2.
//  Copyright © 2016年 MornChan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DCSelectPhotosView : UIView


- (void)addPhotoWithPhotos:(NSArray *)photos;


+ (CGSize)sizeWithCount:(int)photosCount;


@end
