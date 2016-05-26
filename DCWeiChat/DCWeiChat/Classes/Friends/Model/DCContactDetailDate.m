//
//  DCContactDetailDate.m
//  NewWeChat
//
//  Created by MornChan on 16/2/19.
//  Copyright © 2016年 MornChan. All rights reserved.
//

#import "DCContactDetailDate.h"

@implementation DCContactDetailDate

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dict];
        
    }
    
    return self;
}

+ (instancetype)contactDetailDateWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
    
}
@end
