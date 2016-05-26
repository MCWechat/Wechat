//
//  DCImage.m
//  NewWeChat
//
//  Created by MornChan on 16/2/23.
//  Copyright © 2016年 MornChan. All rights reserved.
//

#import "DCImage.h"

@implementation DCImage

- (NSMutableString *)large_pic
{
    if (!_large_pic) {
        
        _large_pic = [[NSMutableString alloc]initWithString:self.thumbnail_pic];
        
        NSRange range = [_large_pic rangeOfString:@"thumbnail"];
        
        [_large_pic replaceCharactersInRange:range withString:@"large"];
        
    }
    
        return _large_pic;
        
}

//+ (NSString *)returnLargePicWithThum:(NSString *)thumb_url
//{
//    NSMutableString * mstring = [[NSMutableString alloc]initWithString:thumb_url];
//    
//    NSRange range = [thumb_url rangeOfString:@"thumbnail"];
//    
//    [mstring replaceCharactersInRange:range withString:@"large"];
//    
//    return mstring;
//
//}
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_thumbnail_pic forKey:@"thumbnail_pic"];
    
}
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        _thumbnail_pic = [aDecoder decodeObjectForKey:@"thumbnail_pic"];
        _large_pic = [aDecoder decodeObjectForKey:@"large_pic"];
    }
    return self;
    
}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        
        self.thumbnail_pic = dict[@"thumbnail_pic"];
        self.large_pic = dict[@"large_pic"];
        
    }
    return self;
    
}
+ (instancetype)imageWithDict:(NSDictionary *)dict
{
    
    return [[self alloc]initWithDict:dict];
}

@end
