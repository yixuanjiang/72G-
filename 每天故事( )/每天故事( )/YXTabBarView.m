//
//  YXTabBarView.m
//  每天故事
//
//  Created by 蒋毅轩 on 16/3/17.
//  Copyright © 2016年 蒋毅轩. All rights reserved.
//

#import "YXTabBarView.h"

@interface YXTabBarView ()

@property (nonatomic,strong)UIButton *selectedButton;

@end

@implementation YXTabBarView

- (void)addTabbarBtnWithNorImageName:(NSString *)norImageName selImageName:(NSString *)selImageName
{
    UIButton *button = [YXTabBarButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:norImageName] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:selImageName] forState:UIControlStateSelected];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    
    button.tag = self.subviews.count;
    [self addSubview:button];
    
    //设置按钮默认的选定状态
    if (button.tag == 0) {
        button.selected = YES;
        self.selectedButton = button;
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat btnW = self.bounds.size.width / self.subviews.count;
    CGFloat btnH = self.bounds.size.height;
    
    //自定义的tabbar添加按钮
    for (UIButton *btn in self.subviews) {
        btn.frame = CGRectMake(btnW * btn.tag, 0, btnW, btnH);
    }
}

//button点击方法
- (void)buttonClick:(UIButton *)sender
{
    if ([self.delagate respondsToSelector:@selector(tabbar:didSelectedFrom:to:)]) {
        [self.delagate tabbar:self didSelectedFrom:self.selectedButton.tag to:sender.tag];
    }
    self.selectedButton.selected = NO;
    sender.selected = YES;
    self.selectedButton = sender;
}

@end

@implementation YXTabBarButton

//图片高亮时候会调用这个方法
- (void)setHighlighted:(BOOL)highlighted
{
    //只要不调用父类的方法，按钮就不会有高度的效果
    //[super setHighlighted:highlighted];
}

@end