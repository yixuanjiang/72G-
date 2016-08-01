//
//  YXHomeNavigationScrollView.m
//  每天故事
//
//  Created by 蒋毅轩 on 16/3/17.
//  Copyright © 2016年 蒋毅轩. All rights reserved.
//

#import "YXHomeNavigationScrollView.h"

@implementation YXHomeNavigationScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        //设置水平竖直的滚动条
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.
        //允许滚动
        //self.pagingEnabled = YES;
        self.scrollEnabled = YES;
    }
    return self;
}

- (void)setUpscrollViewWithTitleArray:(NSArray *)titlesArray
{
    CGFloat labelW = 62;
    CGFloat labelH = 20;
    
    for (NSInteger i = 0; i < titlesArray.count; i++) {
        //设置滚动范围
        self.contentSize = CGSizeMake(labelW * titlesArray.count, 0);
        //初始化label
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(labelW * i, self.frame.size.height - 30, labelW, labelH)];
        label.font = [UIFont systemFontOfSize:15];
        label.textColor = [UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1.0];
        label.text = titlesArray[i];
        label.textAlignment = NSTextAlignmentCenter;
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick:)]];
        label.userInteractionEnabled = YES;
        label.tag = i;
        
        //label.backgroundColor = [UIColor colorWithRed:arc4random_uniform(100)/100.0 green:arc4random_uniform(100)/100.0 blue:arc4random_uniform(100)/100.0 alpha:1.0];
        [self addSubview:label];
    }
    
}


- (void)labelClick:(UITapGestureRecognizer *)tap
{
    // 取出被点击label的索引
    NSInteger index = tap.view.tag;
    
    if ([self.scrollDelegate respondsToSelector:@selector(homeNavigationScrollView:didSecletedIndex:)]) {
        [self.scrollDelegate homeNavigationScrollView:self didSecletedIndex:index];
    }
}

@end
