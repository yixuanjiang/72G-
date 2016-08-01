//
//  YXUpDateNameVC.h
//  每天故事( )
//
//  Created by 蒋毅轩 on 16/3/22.
//  Copyright © 2016年 蒋毅轩. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YXUpDateNameVC;
@protocol YXUpDateNameVCDelegate <NSObject>

- (void)YXUpDateNameVC:(YXUpDateNameVC *)upDateName passName:(NSString *)name;

@end

@interface YXUpDateNameVC : UIViewController

@property (nonatomic,weak) id<YXUpDateNameVCDelegate>delagate;

@end
