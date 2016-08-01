//
//  YXReconmmedModel.m
//  每天故事( )
//
//  Created by 蒋毅轩 on 16/3/23.
//  Copyright © 2016年 蒋毅轩. All rights reserved.
//

#import "YXReconmmedModel.h"

@implementation YXReconmmedModel

/***    重写cellHeight的get方法   */
- (CGFloat)cellHeight
{
    //间距
    CGFloat leftMargin = 10;
    
    //头像尺寸
    CGFloat iconH = 50;
    
    //文本的尺寸
    CGSize textSize = [self.text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size;
    CGFloat textH = textSize.height;
    
    //图片的尺寸
    CGFloat picH = ([self.height floatValue]* ([UIScreen mainScreen].bounds.size.width - 20)) /([self.width floatValue]);
    self.picH = picH;
    
    CGFloat totleH = textH + picH + iconH + 4 * leftMargin;
    if (totleH > 800) {
        self.bigPic = YES;
        return textH + 300 + iconH + 4 * leftMargin;
    }
    
    return totleH;
}

@end
