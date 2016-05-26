//
//  DCImage.h
//  NewWeChat
//
//  Created by MornChan on 16/2/23.
//  Copyright © 2016年 MornChan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCImage : NSObject<NSCoding>

@property(strong,nonatomic) NSString *thumbnail_pic;

@property(strong,nonatomic) NSMutableString * large_pic;

//+ (NSString *)returnLargePicWithThum:(NSString *)thumb_url;
- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)imageWithDict:(NSDictionary *)dict;

@end
