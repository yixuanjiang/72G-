//
//  YXSexTableVC.h
//  每天故事( )
//
//  Created by 蒋毅轩 on 16/3/22.
//  Copyright © 2016年 蒋毅轩. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YXSexTableVC;
@protocol YXSexTableVCDelegate <NSObject>

- (void)YXSexTableVC:(YXSexTableVC *)sexTableVC passSex:(NSString *)sex;

@end

@interface YXSexTableVC : UITableViewController
@property (nonatomic,copy) NSString *selectedSex;

@property (nonatomic,strong) id<YXSexTableVCDelegate> sexDelegate;
@end
