//
//  YXTabBarView.h
//  每天故事
//
//  Created by 蒋毅轩 on 16/3/17.
//  Copyright © 2016年 蒋毅轩. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YXTabBarView;
@protocol YXTabBarDelagate <NSObject>

-(void)tabbar:(YXTabBarView *)tabbar didSelectedFrom:(NSInteger)from to:(NSInteger)to;

@end

@interface YXTabBarView : UIView

@property (nonatomic,weak) id<YXTabBarDelagate>delagate;

-(void)addTabbarBtnWithNorImageName:(NSString *)norImageName selImageName:(NSString *)selImageName;

@end

//自定义button
@interface YXTabBarButton : UIButton

@end