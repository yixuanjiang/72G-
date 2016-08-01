//
//  YXMineLabelCell.m
//  每天故事( )
//
//  Created by 蒋毅轩 on 16/3/22.
//  Copyright © 2016年 蒋毅轩. All rights reserved.
//

#import "YXMineLabelCell.h"

@implementation YXMineLabelCell


/***   重写初始化方法   */
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(120, 0, 200, 44)];
        self.label.textColor = [UIColor grayColor];
        
        UIImageView *imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_nva_goto"]];
        self.accessoryView = imageV;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubview:self.label];
    }
    return self;
}

/***   重写模型的set方法   */
- (void)setModel:(InfoLabelModel *)model
{
    _model = model;
    
    self.textLabel.text = model.title;
    self.label.text = model.label;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
