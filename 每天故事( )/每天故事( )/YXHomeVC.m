//
//  YXHomeVC.m
//  每天故事
//
//  Created by 蒋毅轩 on 16/3/17.
//  Copyright © 2016年 蒋毅轩. All rights reserved.
//

#import "YXHomeVC.h"
#import "YXHomeScrollView.h"
#import "YXNavigationController.h"
#import "YXHomeNavigationScrollView.h"
#import "YXHomeTableViewController.h"
#import "YXChannelView.h"
#import "YXLabelTableViewController.h"

@interface YXHomeVC () <YXHomeNavigationScrollViewDelagate,UIScrollViewDelegate>
@property (nonatomic,strong) UIButton *selectedButton;

@property (nonatomic,strong)YXHomeScrollView *homeScrollerView;
@property (nonatomic,strong)YXHomeNavigationScrollView *naviScrollerView;

@property (nonatomic,strong) YXChannelView *channelView;
//标题
@property (nonatomic,strong) NSMutableArray *titlesArray;

@end

@implementation YXHomeVC

#pragma mark - 懒加载标题
- (NSMutableArray *)titlesArray
{
    if (!_titlesArray) {
        _titlesArray = [NSMutableArray array];
    }
    return _titlesArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //添加两个默认的标题
    [self.titlesArray addObject:@"推荐"];
    [self.titlesArray addObject:@"关注"];
    
    //添加子控制器
    [self setUpChildVcWithNum:self.titlesArray.count];

    //初始化导航栏的滚动视图
    YXHomeNavigationScrollView *naviScrollerView = [[YXHomeNavigationScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    naviScrollerView.scrollDelegate = self;
    [naviScrollerView setUpscrollViewWithTitleArray:self.titlesArray];
    self.navigationItem.titleView = naviScrollerView;
    self.naviScrollerView = naviScrollerView;
    
    //初始化滚动视图
    YXHomeScrollView *homeScrollerView = [[YXHomeScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    homeScrollerView.delegate = self;
    [homeScrollerView setUpscrollViewWithNum:self.titlesArray.count];
    [self.view addSubview:homeScrollerView];
    self.homeScrollerView = homeScrollerView;
    
    //添加默认的第一个界面
    UITableViewController *tableVc = self.childViewControllers[0];
    tableVc.tableView.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height);
    [self.homeScrollerView addSubview:tableVc.tableView];
    
    //设置第一个默认label的字体大小
    UILabel *label = self.naviScrollerView.subviews[0];
    label.font = [UIFont systemFontOfSize:20];
    label.textColor = [UIColor whiteColor];
    
    //添加右侧的频道管理按钮
    [self setUpRightButton];
    
    //显示频道控制器
    self.channelView = [[YXChannelView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64)];
}

#pragma mark - YXHomeNavigationScrollViewDelagate
- (void)homeNavigationScrollView:(YXHomeNavigationScrollView *)homeNavigationScrollView didSecletedIndex:(NSInteger)index
{
    [self.homeScrollerView setContentOffset:CGPointMake(self.view.frame.size.width * index, 0) animated:YES];
}

#pragma mark - 添加子控制器
- (void)setUpChildVcWithNum:(NSInteger)tableVcNum
{
    //首页控制器
    YXHomeTableViewController *tableVc1 = [[YXHomeTableViewController alloc] init];
    tableVc1.tableView.backgroundColor = [UIColor colorWithRed:arc4random_uniform(100)/100.0 green:arc4random_uniform(100)/100.0 blue:arc4random_uniform(100)/100.0 alpha:1.0];
    [self addChildViewController:tableVc1];
    
    //段子控制器
    YXLabelTableViewController *labelTableVc = [[YXLabelTableViewController alloc] init];
    labelTableVc.tableView.backgroundColor = [UIColor colorWithRed:arc4random_uniform(100)/100.0 green:arc4random_uniform(100)/100.0 blue:arc4random_uniform(100)/100.0 alpha:1.0];
    [self addChildViewController:labelTableVc];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / self.view.frame.size.width;
    
    //改变NavigationSrollView的偏移量
    UILabel *label = self.naviScrollerView.subviews[index];
    CGPoint titleOffSet = self.naviScrollerView.contentOffset;
    titleOffSet.x = label.center.x - self.naviScrollerView.frame.size.width * 0.5;
    if (titleOffSet.x < 0) titleOffSet.x = 0;
    if (index > 6) {
        CGFloat maxOffSetX = self.naviScrollerView.contentSize.width - self.naviScrollerView.frame.size.width;
        if (titleOffSet.x > maxOffSetX) titleOffSet.x = maxOffSetX;
    }
    
    
    [self.naviScrollerView setContentOffset:titleOffSet animated:YES];
    
    
    //获取子控制器
    UITableViewController *tableVc = self.childViewControllers[index];
    if (tableVc.tableView.superview) {
        return;
    }
    tableVc.tableView.frame = CGRectMake(scrollView.contentOffset.x, 64, self.view.frame.size.width, self.view.frame.size.height - 64);
    [self.homeScrollerView addSubview:tableVc.tableView];
    
}

/**
 * 手指松开scrollView后，scrollView停止减速完毕就会调用这个
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat scale = scrollView.contentOffset.x / self.view.frame.size.width;
    NSInteger index = scrollView.contentOffset.x / self.view.frame.size.width;
    
    CGFloat rightScale = scale - index;
    CGFloat leftScale = 1 - rightScale;
    
    //获取label
    UILabel *leftLabel = self.naviScrollerView.subviews[index];
    if (index < self.naviScrollerView.subviews.count - 1) {
        UILabel *rightLabel = self.naviScrollerView.subviews[index + 1];
        
        leftLabel.textColor = [UIColor colorWithRed:(223 + (22 *leftScale))/255.0 green:(223 + (22 *leftScale))/255.0 blue:(223 + (22 *leftScale))/255.0 alpha:1.0];
        leftLabel.font = [UIFont systemFontOfSize:15 * (1 + leftScale / 3)];
        
        rightLabel.textColor = [UIColor colorWithRed:(223 + (22 * rightScale))/255.0 green:(223 + (22 * rightScale))/255.0 blue:(223 + (22 * rightScale))/255.0 alpha:1.0];
        rightLabel.font = [UIFont systemFontOfSize:15 * (1 + rightScale / 3)];
//        NSLog(@"%lf,%lf",leftScale,rightScale);
    }
    
}

#pragma mark - setUpRightButton
- (void)setUpRightButton
{
    UIButton *tagButton = [YXButton buttonWithType:UIButtonTypeCustom];
    [tagButton setBackgroundImage:[UIImage imageNamed:@"icon_plus_classify"] forState:UIControlStateNormal];
    CGFloat tagButtonW =  tagButton.currentBackgroundImage.size.width;
    CGFloat tagButtonH = tagButton.currentBackgroundImage.size.height;
    tagButton.frame = CGRectMake(0, 0, tagButtonW, tagButtonH);
    tagButton.layer.cornerRadius = 8;
    tagButton.layer.masksToBounds = YES;
    [tagButton addTarget:self action:@selector(add:) forControlEvents:UIControlEventTouchDown];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:tagButton];
    
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
}

- (void)add:(UIButton *)sender
{
    static BOOL isRotation = YES;
    
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotationAnimation.duration = 0.25;
    
    CATransition *transition = [CATransition animation];
    transition.type = @"kCATransitionReveal";
    transition.subtype = kCATransitionFromTop;
    transition.duration= 0.25;
    
    if (isRotation) {
        //旋转动画
        rotationAnimation.fromValue = @0;
        rotationAnimation.toValue = @(-M_PI_4);
        isRotation = NO;
        
        self.navigationItem.titleView.hidden = YES;
        [self.view addSubview:self.channelView];
        [self.view.layer addAnimation:transition forKey:nil];

    }else
    {
        //旋转动画
        rotationAnimation.fromValue = @(-M_PI_4);
        rotationAnimation.toValue = @0;
        isRotation = YES;
        
        self.navigationItem.titleView.hidden = NO;
        [self.channelView removeFromSuperview];

    }
    //设置动画执行完毕之后不删除动画
    rotationAnimation.removedOnCompletion=NO;
    //设置保存动画的最新状态
    rotationAnimation.fillMode=kCAFillModeForwards;
    [sender.layer addAnimation:rotationAnimation forKey:nil];
    
}


@end

@implementation YXButton

- (void)setHighlighted:(BOOL)highlighted
{
    
}

@end
