//
//  MeTableVC.h
//  每天故事
//
//  Created by 蒋毅轩 on 16/3/17.
//  Copyright © 2016年 蒋毅轩. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MeTableVC;
@protocol MeTableVCDelagate <NSObject>

- (void)tableVC:(MeTableVC *)tableVC setTabBarViewHide:(BOOL)hade;

@end

@interface MeTableVC : UITableViewController

@property (nonatomic,weak) id<MeTableVCDelagate>hideDelegate;

@end
