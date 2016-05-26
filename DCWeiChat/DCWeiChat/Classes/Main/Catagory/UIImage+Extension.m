//
//  UIImage+Extension.m
//  NewWeChat
//
//  Created by MornChan on 16/2/16.
//  Copyright © 2016年 MornChan. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)


+ (UIImage *)resizableImage:(NSString *)name
{
    UIImage * image = [UIImage imageNamed:name];
    
    CGFloat width = image.size.width * 0.5;
    
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(width, width, width, width)];
}


@end
