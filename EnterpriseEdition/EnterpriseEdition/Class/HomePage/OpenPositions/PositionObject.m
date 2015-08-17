//
//  PositionObject.m
//  EnterpriseEdition
//
//  Created by lyk on 15/7/22.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "PositionObject.h"

@implementation PositionObject
//单实例
+(id)shareInstance
{
    static PositionObject *instance = nil;
    static dispatch_once_t once;
    dispatch_once(&once,^{
        instance = [self new];
    });
    return instance;
}
//获取省市区的id
-(int)getProvinceOrCityOrAreas:(int)fid Name:(NSString*)name
{
    __block int cityId = 0;
    NSString *dbPath = [Util getSQLitePath];
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    if (![db open]) {
        NSLog(@"could not open db");
    }
    [db setShouldCacheStatements:YES];
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:dbPath];
    [queue inDatabase:^(FMDatabase *db){
        FMResultSet *rs = [db executeQuery:@"select * from t_city where fid = ? and name = ?",[NSNumber numberWithInt:fid],name];
        while ([rs next]) {
            cityId = [rs intForColumn:@"id"];
        }
        [rs close];
    }];
    return cityId;
}
// 获取行业的id
-(int)getIndustryIds:(int)fid Name:(NSString*)name
{
    __block int industryId = 0;
    NSString *dbPath = [Util getSQLitePath];
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    if (![db open]) {
        NSLog(@"could not open db");
    }
    [db setShouldCacheStatements:YES];
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:dbPath];
    [queue inDatabase:^(FMDatabase *db){
        FMResultSet *rs = [db executeQuery:@"select * from t_industry where fid = ? and name = ?",[NSNumber numberWithInt:fid],name];
        while ([rs next]) {
            industryId = [rs intForColumn:@"id"];
        }
        [rs close];
    }];
    return industryId;
    
}
// 获取职位名称的Ids
-(int)getJobTypeIds:(int)fid Name:(NSString*)name
{
    __block int jobtyepId = 0;
    NSString *dbPath = [Util getSQLitePath];
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    if (![db open]) {
        NSLog(@"could not open db");
    }
    [db setShouldCacheStatements:YES];
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:dbPath];
    [queue inDatabase:^(FMDatabase *db){
        FMResultSet *rs = [db executeQuery:@"select * from t_job_type where fid = ? and name = ?",[NSNumber numberWithInt:fid],name];
        while ([rs next]) {
            jobtyepId = [rs intForColumn:@"id"];
        }
        [rs close];
    }];
    return jobtyepId;

}
// 获取专业名称的Ids
-(int)getMajorIds:(int)fid Name:(NSString*)name
{
    __block int majorId = 0;
    NSString *dbPath = [Util getSQLitePath];
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    if (![db open]) {
        NSLog(@"could not open db");
    }
    [db setShouldCacheStatements:YES];
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:dbPath];
    [queue inDatabase:^(FMDatabase *db){
        FMResultSet *rs = [db executeQuery:@"select * from t_major where fid = ? and name = ?",[NSNumber numberWithInt:fid],name];
        while ([rs next]) {
            majorId = [rs intForColumn:@"id"];
        }
        [rs close];
    }];
    return majorId;
    
}

// 获取民族
-(NSString*)getNationStringById:(int)nationID
{
    __block NSString *nationString = @"汉族";
    NSString *dbPath = [Util getSQLitePath];
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    if (![db open]) {
        NSLog(@"could not open db");
    }
    [db setShouldCacheStatements:YES];
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:dbPath];
    [queue inDatabase:^(FMDatabase *db){
        FMResultSet *rs = [db executeQuery:@"select * from t_nation where id = ?",[NSNumber numberWithInt:nationID]];
        while ([rs next]) {
            nationString = [rs stringForColumn:@"name"];
        }
        [rs close];
    }];
    return nationString;

}
-(int)getIndustryIdsByName:(NSString *)name
{
    __block int industryId = 0;
    NSString *dbPath = [Util getSQLitePath];
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    if (![db open]) {
        NSLog(@"could not open db");
    }
    [db setShouldCacheStatements:YES];
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:dbPath];
    [queue inDatabase:^(FMDatabase *db){
        FMResultSet *rs = [db executeQuery:@"select * from t_industry where name = ?",name];
        while ([rs next]) {
            industryId = [rs intForColumn:@"id"];
        }
        [rs close];
    }];
    return industryId;

}
-(int)getJobTypeIdsByName:(NSString *)name
{
    __block int jobtyepId = 0;
    NSString *dbPath = [Util getSQLitePath];
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    if (![db open]) {
        NSLog(@"could not open db");
    }
    [db setShouldCacheStatements:YES];
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:dbPath];
    [queue inDatabase:^(FMDatabase *db){
        FMResultSet *rs = [db executeQuery:@"select * from t_job_type where name = ?",name];
        while ([rs next]) {
            jobtyepId = [rs intForColumn:@"id"];
        }
        [rs close];
    }];
    return jobtyepId;

}
@end
