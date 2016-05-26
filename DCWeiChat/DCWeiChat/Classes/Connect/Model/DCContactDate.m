//
//  DCContactDate.m
//  NewWeChat
//
//  Created by MornChan on 16/2/14.
//  Copyright © 2016年 MornChan. All rights reserved.
//

#import "DCContactDate.h"
#import "DCMessageDate.h"

@interface DCContactDate()



@end


@implementation DCContactDate


- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_name forKey:@"DCContactDateName"];
    [aCoder encodeObject:_icon forKey:@"DCContactDateIcon"];
    [aCoder encodeObject:_time forKey:@"DCContactDateTime"];
    [aCoder encodeObject:_messageDate forKey:@"DCContactDateMessageDate"];

    
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    
    if (self = [super init]) {
        
        _name = [aDecoder decodeObjectForKey:@"DCContactDateName"];
        _icon = [aDecoder decodeObjectForKey:@"DCContactDateIcon"];
        _time= [aDecoder decodeObjectForKey:@"DCContactDateTime"];
        _messageDate = [aDecoder decodeObjectForKey:@"DCContactDateMessageDate"];
        
    }
    return self;
}




- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self == [super init]) {
        
        self.name = dict[@"name"];
        self.icon = dict[@"icon"];
        self.time = dict[@"time"];
        
        NSArray * messageDict = dict[@"message"];
        
        NSMutableArray * tarray = [NSMutableArray array];
        
        for (NSDictionary *dict in messageDict ) {
            
            DCMessageDate * mdict = [[DCMessageDate alloc]initWithDict:dict];
            
            [tarray addObject:mdict];
        }
        
        self.messageDate = tarray;
        
        
    }
    
    return self;
}


@end
