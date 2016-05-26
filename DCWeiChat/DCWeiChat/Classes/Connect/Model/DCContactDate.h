//
//  DCContactDate.h
//  NewWeChat
//
//  Created by MornChan on 16/2/14.
//  Copyright © 2016年 MornChan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCMessageDate.h"
@interface DCContactDate : NSObject <NSCoding>


@property(strong,nonatomic) NSString * name;

@property(strong,nonatomic) NSString * icon;

@property(strong,nonatomic) NSString * time;

@property(strong,nonatomic) NSMutableArray * messageDate;

- (instancetype)initWithDict:(NSDictionary *)dict;


- (void)encodeWithCoder:(NSCoder *)aCoder;

- (id)initWithCoder:(NSCoder *)aDecoder;

@end
