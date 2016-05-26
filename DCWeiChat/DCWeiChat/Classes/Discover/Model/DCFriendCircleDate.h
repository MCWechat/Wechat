//
//  DCFriendCircleDate.h
//  NewWeChat
//
//  Created by MornChan on 16/2/21.
//  Copyright © 2016年 MornChan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCFriendCircleDate : NSObject

@property(strong,nonatomic) NSString * name;

@property(strong,nonatomic) NSString * icon;

@property(strong,nonatomic) NSString * message;

@property(strong,nonatomic) NSString * source;

@property(strong,nonatomic) NSArray * images;


-(instancetype)initWithDict:(NSDictionary *)dict;

+(instancetype)dateWithDict:(NSDictionary *)dict;

@end
