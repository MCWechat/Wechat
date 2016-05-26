//
//  DCSelectPhotosView.m
//  NewWeChat
//
//  Created by MornChan on 16/3/2.
//  Copyright © 2016年 MornChan. All rights reserved.
//

#define photoWH1x  72
#define padding  6
//@class MLSelectPhotoPickerViewController;

#import "DCSelectPhotosView.h"
#import "MLSelectPhotoPickerViewController.h"


@implementation DCSelectPhotosView


-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        
        
        for (int i=0; i<9; i++) {
            
            
            UIImageView * imageView = [[UIImageView alloc]init];
            
            imageView.contentMode = UIViewContentModeScaleToFill;
                        
            imageView.userInteractionEnabled = YES;
            
            imageView.hidden = YES;

            [self addSubview:imageView];
            
        }

}
    return self;
}

- (void)imageTap:(UITapGestureRecognizer *)recognizer
{
    
    
}

- (void)addPhotoWithPhotos:(NSArray *)photos
{
    CGFloat photoX,photoY;
    
        for (int i = 0; i < photos.count; i++) {
            
            UIImage * image = photos[i];
            
            UIImageView * imageView = self.subviews[i];
            
            imageView.image = image;
            
            imageView.hidden = NO;
            
            int clo = i / 4;
            
            int row = i % 4;
            
            photoX =  padding + row *(photoWH1x + padding) ;
            
            photoY =  padding + clo * (photoWH1x + padding);
            
            imageView.frame = CGRectMake(photoX,photoY,photoWH1x,photoWH1x);
        }
}

+ (CGSize)sizeWithCount:(int)photosCount

{
    CGRect  rect =  [UIScreen mainScreen].bounds;
    
    if (photosCount < 4) {
        
        return CGSizeMake(rect.size.width , photoWH1x + padding * 2);
    }
    else if (photosCount >7)
    {
        return CGSizeMake(rect.size.width , photoWH1x * 3 + padding * 4);
    }
    
    return CGSizeMake(rect.size.width, photoWH1x * 2 + padding * 3);
}



@end
