//
//  MineCellModel.h
//  好药师去买药
//
//  Created by 蒋毅轩 on 16/3/5.
//  Copyright (c) 2016年 蒋毅轩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MineCellModel : NSObject

@property (nonatomic,copy) NSString *icon;
@property (nonatomic,copy) NSString *text;
@property (nonatomic,copy) NSString *context;

- (instancetype)initWithIcon:(NSString *)icon text:(NSString *)text;
+ (instancetype)modelWithIcon:(NSString *)icon text:(NSString *)text;

@end
