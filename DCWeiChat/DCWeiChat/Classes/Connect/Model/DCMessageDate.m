//
//  DCMessageDate.m
//  NewWeChat
//
//  Created by MornChan on 16/2/14.
//  Copyright © 2016年 MornChan. All rights reserved.
//


#import "DCMessageDate.h"

@implementation DCMessageDate

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_message forKey:@"DCMessageDateMessage"];
    [aCoder encodeInt:_type forKey:@"DCMessageDateType"];
    [aCoder encodeObject:_icon forKey:@"DCMessageDateIcon"];
    //    [aCoder encodeObject:_messageDate forKey:@"DCContactDateMessageDate"];
    
    
    
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    
    if (self = [super init]) {
        
        _message = [aDecoder decodeObjectForKey:@"DCMessageDateMessage"];
        _type = [aDecoder decodeIntForKey:@"DCMessageDateType"];
        _icon = [aDecoder decodeObjectForKey:@"DCMessageDateIcon"];
        //        self = [aDecoder decodeObjectForKey:@"DCContactDateMessageDate"];
        
        
    }
    return self;
}


-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self == [super init]) {
        
//        self.message = dict[@"message"];
//        
//        self.messageType = dict[@"type"];
        [self setValuesForKeysWithDictionary:dict];
        

    
    }
    
    return self;
}


@end
