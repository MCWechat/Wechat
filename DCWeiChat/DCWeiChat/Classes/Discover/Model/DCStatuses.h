//
//  DCStatuses.h
//  NewWeChat
//
//  Created by MornChan on 16/2/23.
//  Copyright © 2016年 MornChan. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DCUsers;

@interface DCStatuses : NSObject<NSCoding>

@property(strong,nonatomic) NSString * text;

@property(strong,nonatomic) NSString *thumbnail_pic;

@property(strong,nonatomic) NSString * bmiddle_pic;

@property(strong,nonatomic) DCUsers * user;

@property(strong,nonatomic) NSArray * pic_urls;

@property(strong,nonatomic) NSString *  idstr;

//@property(strong,nonatomic) NSArray * comments;


- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)statusesWithDict:(NSDictionary *)dict;




@end
