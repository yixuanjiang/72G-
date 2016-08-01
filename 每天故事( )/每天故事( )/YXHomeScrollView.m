//
//  YXHomeScrollView.m
//  每天故事
//
//  Created by 蒋毅轩 on 16/3/17.
//  Copyright © 2016年 蒋毅轩. All rights reserved.
//

#import "YXHomeScrollView.h"

@implementation YXHomeScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        //设置水平竖直的滚动条
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        //允许滚动
        self.pagingEnabled = YES;
        self.scrollEnabled = YES;
    }
    return self;
}

- (void)setUpscrollViewWithNum:(NSInteger)num
{    
    //设置滚动范围
    self.contentSize = CGSizeMake(self.frame.size.width *num, 0);
    
}

@end
