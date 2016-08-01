//
//  YXHomeNavigationScrollView.h
//  每天故事
//
//  Created by 蒋毅轩 on 16/3/17.
//  Copyright © 2016年 蒋毅轩. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YXHomeNavigationScrollView;
@protocol YXHomeNavigationScrollViewDelagate <NSObject>
//发布一个代理协议
- (void)homeNavigationScrollView:(YXHomeNavigationScrollView *)homeNavigationScrollView didSecletedIndex:(NSInteger)index;

@end

@interface YXHomeNavigationScrollView : UIScrollView

@property (nonatomic,weak) id<YXHomeNavigationScrollViewDelagate>scrollDelegate;

- (void)setUpscrollViewWithTitleArray:(NSArray *)titlesArray;

@end
