//
//  MineCellModel.m
//  好药师去买药
//
//  Created by 蒋毅轩 on 16/3/5.
//  Copyright (c) 2016年 蒋毅轩. All rights reserved.
//

#import "MineCellModel.h"

@implementation MineCellModel

- (instancetype)initWithIcon:(NSString *)icon text:(NSString *)text
{
    if (self = [super init]) {
        self.icon = icon;
        self.text = text;
    }
    return self;
}

+ (instancetype)modelWithIcon:(NSString *)icon text:(NSString *)text
{
    return [[self alloc] initWithIcon:icon text:text];
}

@end
