//
//  YXMySql.m
//  每天故事( )
//
//  Created by 蒋毅轩 on 16/3/27.
//  Copyright © 2016年 蒋毅轩. All rights reserved.
//

#import "YXMySql.h"
#import "FMDatabase.h"

@implementation YXMySql

static FMDatabase *_db;

+ (void)initialize
{
    // 1.打开数据库
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"picCaches.db"];
    _db = [FMDatabase databaseWithPath:path];
    NSLog(@"%@",path);
    [_db open];
    
    // 2.创表
    [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS picCaches (id integer PRIMARY KEY, pic blob NOT NULL, maxid text NOT NULL);"];
}

+ (NSDictionary *)picCachesWithMaxid:(NSString *)maxid
{
    // 根据请求参数生成对应的查询SQL语句
    NSString *sql = @"SELECT * FROM picCaches ORDER BY maxid DESC LIMIT 1;";
    
    // 执行SQL
    FMResultSet *set = [_db executeQuery:sql];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    while (set.next) {
        NSData *statusData = [set objectForColumnName:@"pic"];
        NSArray *picArray = [NSKeyedUnarchiver unarchiveObjectWithData:statusData];
        dic[@"picArray"] = picArray;
        
        NSString *maxid = [set objectForColumnName:@"maxid"];        
        dic[@"maxid"] = maxid;
    }
    return dic;
}

+ (void)savePicCaches:(NSArray *)picCaches withMaxId:(NSString *)maxid
{
    // 要将一个对象存进数据库的blob字段,最好先转为NSData
    // 一个对象要遵守NSCoding协议,实现协议中相应的方法,才能转成NSData
    
        NSData *picData = [NSKeyedArchiver archivedDataWithRootObject:picCaches];
        [_db executeUpdateWithFormat:@"INSERT INTO picCaches(pic, maxid) VALUES (%@, %@);", picData, maxid];

}

@end
