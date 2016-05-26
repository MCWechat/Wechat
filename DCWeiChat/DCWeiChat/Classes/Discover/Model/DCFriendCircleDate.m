//
//  DCFriendCircleDate.m
//  NewWeChat
//
//  Created by MornChan on 16/2/21.
//  Copyright © 2016年 MornChan. All rights reserved.
//

#import "DCFriendCircleDate.h"
#import "DCFriendCircleImagesDate.h"

@implementation DCFriendCircleDate



-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        
        
        self.name = dict[@"name"];
        self.icon = dict[@"icon"];
        self.message = dict[@"message"];
        self.source = dict[@"source"];
        NSArray * array = dict[@"images"];
        
        NSMutableArray * tarray = [NSMutableArray array];
        
        for (NSDictionary * dict in array) {
            
            DCFriendCircleImagesDate * imageDate = [[DCFriendCircleImagesDate alloc]initWithDict:dict];
            
            [tarray addObject:imageDate];
        }
        
        self.images = tarray;
    }
    return self;
}

+(instancetype)dateWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
    
}

@end
