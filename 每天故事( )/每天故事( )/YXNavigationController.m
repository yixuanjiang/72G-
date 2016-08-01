//
//  YXNavigationController.m
//  每天故事
//
//  Created by 蒋毅轩 on 16/3/17.
//  Copyright © 2016年 蒋毅轩. All rights reserved.
//

#import "YXNavigationController.h"

@interface YXNavigationController ()

@end

@implementation YXNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //此设置可以让导航栏的文字颜色改为白色
    self.navigationBar.barStyle = UIBarStyleBlack;
    //设置返回
    
    
    UIImage *image = [UIImage imageNamed:@"bg_classify"];
    //将图片改为平铺图片
    UIImage *newImage = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
    //设置导航栏的背景图
    [self.navigationBar setBackgroundImage:newImage forBarMetrics:UIBarMetricsDefault];
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0) {
        UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
        [backButton setBackgroundImage:[UIImage imageNamed:@"icon_nav_return_white"] forState:UIControlStateNormal];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        viewController.hidesBottomBarWhenPushed = YES;
        [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    }
    
    // 这句super的push要放在后面, 让viewController可以覆盖上面设置的leftBarButtonItem
    [super pushViewController:viewController animated:YES];
}

- (void)back
{
    [self popViewControllerAnimated:YES];
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
