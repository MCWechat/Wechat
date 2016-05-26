//
//  SinaOAuthDate.h
//  NewWeChat
//
//  Created by MornChan on 16/2/23.
//  Copyright © 2016年 MornChan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SinaOAuthDate : NSObject<NSCoding>


@property (nonatomic, copy) NSString *access_token;
// 如果服务器返回的数字很大, 建议用long long(比如主键, ID)
@property (nonatomic, assign) long long expires_in;
@property (nonatomic, assign) long long remind_in;
@property (nonatomic, assign) long long uid;


+ (instancetype)dateWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)loadOAuthDate;


@end
