//
//  YXLabelFrameModel.h
//  每天故事( )
//
//  Created by 蒋毅轩 on 16/3/23.
//  Copyright © 2016年 蒋毅轩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import "YXLabelModel.h"

@interface YXLabelFrameModel : NSObject

@property (nonatomic,strong) YXLabelModel *model;

@property (nonatomic,assign) CGFloat rowHeight;

@end
