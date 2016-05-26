//
//  DCContactDetailDate.h
//  NewWeChat
//
//  Created by MornChan on 16/2/19.
//  Copyright © 2016年 MornChan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCContactDetailDate : NSObject


@property(strong,nonatomic) NSString * icon;

@property(strong,nonatomic) NSString * idname;

@property(strong,nonatomic) NSString * region;

@property(strong,nonatomic) NSString * name;


- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)contactDetailDateWithDict:(NSDictionary *)dict;


@end
