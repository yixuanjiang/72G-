//
//  YXMineInfoCell.h
//  每天故事( )
//
//  Created by 蒋毅轩 on 16/3/22.
//  Copyright © 2016年 蒋毅轩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InfoLabelModel.h"

@interface YXMineInfoCell : UITableViewCell
/***   iconImageView   */
@property (nonatomic,strong) UIImageView *iconView;

@property (nonatomic,strong) InfoLabelModel *model;

@end
