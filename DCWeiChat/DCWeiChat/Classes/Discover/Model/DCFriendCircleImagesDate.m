//
//  DCFriendCircleImagesDate.m
//  NewWeChat
//
//  Created by MornChan on 16/2/21.
//  Copyright © 2016年 MornChan. All rights reserved.
//

#import "DCFriendCircleImagesDate.h"

@implementation DCFriendCircleImagesDate



- (instancetype)initWithDict:(NSDictionary * )dict
{
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dict];
        
    }
    return self;
}

+ (instancetype)imagesDateWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}


@end
