//
//  DCFriendCircleImagesDate.h
//  NewWeChat
//
//  Created by MornChan on 16/2/21.
//  Copyright © 2016年 MornChan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCFriendCircleImagesDate : NSObject

@property(strong,nonatomic) NSString * image;



- (instancetype)initWithDict:(NSDictionary * )dict;

+ (instancetype)imagesDateWithDict:(NSDictionary *)dict;


@end
