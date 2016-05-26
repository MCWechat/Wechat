//
//  DCUsers.m
//  NewWeChat
//
//  Created by MornChan on 16/2/23.
//  Copyright © 2016年 MornChan. All rights reserved.
//

#import "DCUsers.h"

@implementation DCUsers


- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeObject:_name forKey:@"name"];
    [aCoder encodeObject:_profile_image_url forKey:@"profile_image_url"];
    
    
}
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        _name = [aDecoder decodeObjectForKey:@"name"];
        _profile_image_url = [aDecoder decodeObjectForKey:@"profile_image_url"];
        
    }
    return self;
}

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        
        self.name = dict[@"name"];
        
        self.profile_image_url= dict[@"profile_image_url"];
        
        
    }
    return self;
}
+ (instancetype)usersWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}
@end
