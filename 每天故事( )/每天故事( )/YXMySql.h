//
//  YXMySql.h
//  每天故事( )
//
//  Created by 蒋毅轩 on 16/3/27.
//  Copyright © 2016年 蒋毅轩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YXMySql : NSObject
/**
 *  根据请求参数去沙盒中加载缓存的微博数据
 *
 *  @param params 请求参数
 */
+ (NSDictionary *)picCachesWithMaxid:(NSString *)maxid;

/**
 *  存储微博数据到沙盒中
 *
 *  @param statuses 需要存储的微博数据
 */
+ (void)savePicCaches:(NSArray *)picCaches withMaxId:(NSString *)maxid;
@end
