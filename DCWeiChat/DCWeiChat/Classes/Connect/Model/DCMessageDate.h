//
//  DCMessageDate.h
//  NewWeChat
//
//  Created by MornChan on 16/2/14.
//  Copyright © 2016年 MornChan. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(int, DCMessageType) {
    
    DCMessageTypeMe = 0,
    
    DCMessageTypeOther = 1


};
@interface DCMessageDate : NSObject<NSCoding>

@property(strong,nonatomic) NSString * message;

@property(assign,nonatomic) DCMessageType type;

@property(strong,nonatomic) NSString * icon;

@property(strong,nonatomic) NSString * voiceName;

-(instancetype)initWithDict:(NSDictionary *)dict;

- (id)initWithCoder:(NSCoder *)aDecoder;

-(void)encodeWithCoder:(NSCoder *)aCoder;


@end