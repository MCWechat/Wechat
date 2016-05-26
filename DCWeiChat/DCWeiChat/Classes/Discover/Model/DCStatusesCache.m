//
//  DCStatusesCache.m
//  NewWeChat
//
//  Created by MornChan on 16/2/24.
//  Copyright © 2016年 MornChan. All rights reserved.
//

#import "DCStatusesCache.h"

#import "FMDB.h"
static FMDatabaseQueue * _queue;

@implementation DCStatusesCache


+ (NSString *)path

{
    return [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject]stringByAppendingPathComponent:@"statuese.sqlite"];
    
    
}

+ (void)removeAllCache
{
    _queue = [FMDatabaseQueue databaseQueueWithPath:[self path]];
    
    
}

+ (void)initialize
{
    _queue = [FMDatabaseQueue databaseQueueWithPath:[self path]];
    
    [_queue inDatabase:^(FMDatabase *db) {
        
        [db executeUpdate:@"create table if not exists t_table (id integer primary key autoincrement,idstr integer,statuse blob)"];
        
    }];
}

+(void)addCacheWithStatuses:(DCStatuses *)statuse;
{
    
    NSData * statuseData = [NSKeyedArchiver archivedDataWithRootObject:statuse];

    
        [_queue inDatabase:^(FMDatabase *db) {
            
            [db executeUpdate:@"insert into t_table (statuse,idstr) values (?,?)",statuseData,statuse.idstr];
            
        }];
    
}

+ (NSArray *)loadCache
{
    
    NSLog(@"path__%@",[self path]);
    NSMutableArray * tarray = [NSMutableArray array];
    
    [_queue inDatabase:^(FMDatabase *db) {
        
       FMResultSet * result = [db executeQuery:@"select * from t_table order by idstr desc"];
        
        while (result.next) {
            
            NSData * data = [result dataForColumn:@"statuse"];
            
            DCStatuses * statuses = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            
            [tarray addObject:statuses];
        }
        
    }];
    
    return tarray;

}

@end
