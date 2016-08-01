//
//  YXLabelFrameModel.m
//  每天故事( )
//
//  Created by 蒋毅轩 on 16/3/23.
//  Copyright © 2016年 蒋毅轩. All rights reserved.
//

#import "YXLabelFrameModel.h"
#import <UIKit/UIKit.h>

@implementation YXLabelFrameModel

- (void)setModel:(YXLabelModel *)model
{
    _model = model;
    
    CGSize textSize = [model.text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size;
    
    self.rowHeight = textSize.height;
}

@end
