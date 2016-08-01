//
//  YXTabBarController.m
//  每天故事
//
//  Created by 蒋毅轩 on 16/3/17.
//  Copyright © 2016年 蒋毅轩. All rights reserved.
//

#import "YXTabBarController.h"
#import "YXTabBarView.h"

@interface YXTabBarController () <YXTabBarDelagate>

@property (nonatomic,strong)YXTabBarView *tabBarView;
@end

@implementation YXTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //获取屏幕尺寸
    //CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    //CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    
    //自定义一个tabBarView
    YXTabBarView *tabBarView = [[YXTabBarView alloc] initWithFrame:CGRectMake(0, 0, self.tabBar.bounds.size.width, self.tabBar.bounds.size.height)];
    tabBarView.userInteractionEnabled = YES;
    
    [tabBarView addTabbarBtnWithNorImageName:@"icon_homepage" selImageName:@"icon_homepage_highlighted"];
    [tabBarView addTabbarBtnWithNorImageName:@"icon_faxian" selImageName:@"icon_faxian_highlighted"];
    [tabBarView addTabbarBtnWithNorImageName:@"icon_info" selImageName:@"icon_info_highlighted"];
    [tabBarView addTabbarBtnWithNorImageName:@"icon_me" selImageName:@"icon_me_highlighted"];
    tabBarView.delagate = self;

    self.tabBarView = tabBarView;
    [self.tabBar addSubview:tabBarView];

}


#pragma mark - YXTabBarDelagate
- (void)tabbar:(YXTabBarView *)tabbar didSelectedFrom:(NSInteger)from to:(NSInteger)to
{
    self.selectedIndex = to;
    NSLog(@"%ld",to);
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
