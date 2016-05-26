//
//  DCContactDetailDate.m
//  NewWeChat
//
//  Created by MornChan on 16/2/19.
//  Copyright © 2016年 MornChan. All rights reserved.
//

#import "DCContactGroupDate.h"

@implementation DCContactGroupDate




-(instancetype)initWithDict:(NSDictionary * )dict
{
    if (self = [super init]) {
        self.group = dict[@"group"];
        
        NSArray * users = dict[@"users"];
        
        NSMutableArray * tarray = [NSMutableArray array];
        
        for (NSDictionary * dict in users) {
            
            DCContactDetailDate * contactDetialDate = [DCContactDetailDate contactDetailDateWithDict:dict];
            
            [tarray addObject:contactDetialDate];
        }
        
        self.users = tarray;
        
    }
    return self;
    
}

+(instancetype)ContactGroupDateWithDict:(NSDictionary *)dict
{
    return  [[self alloc]initWithDict:dict];
}




@end
