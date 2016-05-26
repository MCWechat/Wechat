//
//  DCStatusesCache.h
//  NewWeChat
//
//  Created by MornChan on 16/2/24.
//  Copyright © 2016年 MornChan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCStatuses.h"

@interface DCStatusesCache : NSObject


+ (NSArray *)loadCache;
+(void)addCacheWithStatuses:(DCStatuses *)statuse;
@end
