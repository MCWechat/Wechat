//
//  DCStatuses.m
//  NewWeChat
//
//  Created by MornChan on 16/2/23.
//  Copyright © 2016年 MornChan. All rights reserved.
//

#import "DCStatuses.h"
#import "DCImage.h"
#import "DCUsers.h"
@class DCImage;

@implementation DCStatuses


- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_text forKey:@"text"];
    [aCoder encodeObject:_thumbnail_pic forKey:@"thumbnail_pic"];
    [aCoder encodeObject:_user forKey:@"user"];
    [aCoder encodeObject:_bmiddle_pic forKey:@"bmiddle_pic"];
    [aCoder encodeObject:_pic_urls forKey:@"pic_urls"];
    [aCoder encodeObject:_idstr forKey:@"idstr"];

    
}
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        
        _text = [aDecoder decodeObjectForKey:@"text"];
        _thumbnail_pic = [aDecoder decodeObjectForKey:@"thumbnail_pic"];
        _user = [aDecoder decodeObjectForKey:@"user"];
        _bmiddle_pic = [aDecoder decodeObjectForKey:@"bmiddle_pic"];
        _pic_urls = [aDecoder decodeObjectForKey:@"pic_urls"];
        _idstr = [aDecoder decodeObjectForKey:@"idstr"];
        
        

        
    }
    return self;
}

//- (NSDictionary *)objectClassInArray
//{
//    return @{@"pic_urls" : [DCImage class]};
//}



- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        
        self.text = dict[@"text"];
        
//        NSDictionary * dict = dict[@"user"];
        self.idstr = dict[@"idstr"];

        DCUsers * users = [DCUsers usersWithDict:dict[@"user"]];
        
        self.user = users;
        
        NSArray * array = dict[@"pic_urls"];
        
        NSMutableArray * tarray = [NSMutableArray array];
        
        for (NSDictionary * dict  in array) {
            
            DCImage * image = [DCImage imageWithDict:dict];
            
            [tarray addObject:image];
            
        }
        self.pic_urls = tarray;
        
    }
    return self;
    
}
+ (instancetype)statusesWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
    
}



@end
