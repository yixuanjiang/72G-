//
//  YXseeBigPicViewController.m
//  每天故事( )
//
//  Created by 蒋毅轩 on 16/3/25.
//  Copyright © 2016年 蒋毅轩. All rights reserved.
//

#import "YXseeBigPicViewController.h"
#import "UIImageView+WebCache.h"

@interface YXseeBigPicViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *showScrollView;
@property (weak, nonatomic) IBOutlet UIButton *showPicButton;

@end

@implementation YXseeBigPicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // 屏幕尺寸
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    
    UIImageView *showPicImaeg = [[UIImageView alloc] init];
    showPicImaeg.userInteractionEnabled = YES;
    [showPicImaeg addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back:)]];
    [showPicImaeg sd_setImageWithURL:[NSURL URLWithString:self.model.image2]];
    
    showPicImaeg.frame = CGRectMake(0, 0, screenW, self.model.picH);
    if (self.model.picH > screenH) {
        self.showScrollView.contentSize = CGSizeMake(0, self.model.picH);
    }else
    {
        self.showScrollView.contentSize = CGSizeMake(0, screenH);
        showPicImaeg.center = CGPointMake(screenW / 2, screenH / 2);
    }
    
    [self.showScrollView addSubview:showPicImaeg];
    
    self.showPicButton.autoresizesSubviews = NO;
    
    [self.showPicButton bringSubviewToFront:showPicImaeg];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)back:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
