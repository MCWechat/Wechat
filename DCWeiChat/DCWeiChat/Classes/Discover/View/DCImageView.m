//
//  DCImageView.m
//  NewWeChat
//
//  Created by MornChan on 16/2/23.
//  Copyright © 2016年 MornChan. All rights reserved.
//


#define photoWH1x  70
#define photoWH2x  90
#define photoW3x  150
#define photoH3x  150


#define padding  5

#import "DCImageView.h"
#import "DCImage.h"
#import "UIImageView+WebCache.h"
#import "MJPhotoView.h"
#import "MJPhotoBrowser.h"


@implementation DCImageView



-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.userInteractionEnabled = YES;
        
        
        for (int i=0; i<9; i++) {
            
            
            UIImageView * imageView = [[UIImageView alloc]init];
            
            imageView.contentMode = UIViewContentModeScaleToFill;
            
            imageView.userInteractionEnabled = YES;
            
            UITapGestureRecognizer * gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageTap:)];
            
            gesture.numberOfTapsRequired = 1;
            
            gesture.numberOfTouchesRequired = 1;
        
            [imageView addGestureRecognizer:gesture];
            
            imageView.tag = i;
            
            [self addSubview:imageView];
            
        }
        
    }
    
    return self;
}

- (void)imageTap:(UITapGestureRecognizer *)recognizer
{
    
    NSLog(@"tap");
    NSMutableArray * myPhotos = [NSMutableArray array];
    for (int i = 0; i<self.photos.count; i++) {
        
        MJPhoto * mjPhoto = [[MJPhoto alloc]init];
        
        mjPhoto.srcImageView = self.subviews[i];
        
        DCImage * image = self.photos[i];

        mjPhoto.url = [NSURL URLWithString:image.large_pic];
        
        [myPhotos addObject:mjPhoto];
    }
    
    MJPhotoBrowser * browswer = [[MJPhotoBrowser alloc]init];
    
    browswer.currentPhotoIndex = recognizer.view.tag;
    
    browswer.photos = myPhotos;
    
    [browswer show];
    
}

- (void)setPhotos:(NSArray *)photos
{
    _photos = photos;
    
    CGFloat photoX,photoY;
    
    if (photos.count == 4) {
        
        for (int i = 0; i < photos.count; i++) {
            
            DCImage * image = photos[i];
            
            UIImageView * imageView = self.subviews[i];

            [imageView sd_setImageWithURL:[NSURL URLWithString:image.thumbnail_pic] placeholderImage:nil];
            
            imageView.hidden = NO;
            
            int clo = i / 2;

            int row = i % 2;
            
            photoX =  padding + row *(photoWH2x + padding) ;
            
            photoY =  padding + clo * (photoWH2x + padding);
            
            imageView.frame = CGRectMake(photoX,photoY,photoWH2x,photoWH2x);
        }
        
    }
    
    
    
     else
     {
        for (int i = 0; i<photos.count; i++) {
        
        DCImage * image = photos[i];
        
        UIImageView * imageView = self.subviews[i];
        
        imageView.hidden = NO;
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:image.thumbnail_pic] placeholderImage:nil];
        
        int clo = i / 3;
        
        int row = i % 3;
        
        photoX =  padding + row *(photoWH1x + padding);
        
        photoY =  padding + clo * (photoWH1x + padding);
        
        
        if (photos.count == 1) {
            
            imageView.clipsToBounds = NO;

            imageView.frame = CGRectMake(photoX, photoY, photoW3x + padding, photoH3x + padding);
            
        }
        else imageView.frame = CGRectMake(photoX,photoY,photoWH1x ,photoWH1x);}
    
     }
    
    
}

+ (CGSize)sizeWithCount:(int)count
{

    if (count == 1) {
        
        return CGSizeMake(photoW3x +padding, photoH3x + padding);
        
    }
    

    if (count== 3) {
        
        return  CGSizeMake(photoWH1x * 3 + padding * 4, photoWH1x + padding );
    }
    
    if (count == 4) {
        
        return CGSizeMake(photoWH2x * 2 + padding, photoWH2x * 2 + padding * 3);
    }
    
    
    if (count== 6) {
        
        return  CGSizeMake(photoWH1x * 3 + padding * 4, photoWH1x * 2 + padding * 4 );
    }
    
    int cloum = count/3;
    
    cloum+=1;

    
    return  CGSizeMake(photoWH1x * 3 + padding * 4, cloum * (padding + photoWH1x) + padding );
    
}


@end
