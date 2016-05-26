//
//  DCUsers.h
//  NewWeChat
//
//  Created by MornChan on 16/2/23.
//  Copyright © 2016年 MornChan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCUsers : NSObject<NSCoding>

@property(strong,nonatomic) NSString * name;

@property(strong,nonatomic) NSString * profile_image_url;


- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)usersWithDict:(NSDictionary *)dict;

@end
