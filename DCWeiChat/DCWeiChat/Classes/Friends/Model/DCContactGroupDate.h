//
//  DCContactDetailDate.h
//  NewWeChat
//
//  Created by MornChan on 16/2/19.
//  Copyright © 2016年 MornChan. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DCContactDetailDate.h"
@interface DCContactGroupDate : NSObject




@property(strong,nonatomic) NSString * group;

@property(strong,nonatomic) NSMutableArray * users;




-(instancetype)initWithDict:(NSDictionary * )dict;

+(instancetype)ContactGroupDateWithDict:(NSDictionary *)dict;


@end
