//
//  YXInfoCell.m
//  每天故事( )
//
//  Created by 蒋毅轩 on 16/3/21.
//  Copyright © 2016年 蒋毅轩. All rights reserved.
//

#import "YXInfoCell.h"

@implementation YXInfoCell


- (void)setModel:(YXSexModel *)model
{
    _model = model;
    self.textLabel.text = model.sex;
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
