//
//  YXMineInfoCell.m
//  每天故事( )
//
//  Created by 蒋毅轩 on 16/3/22.
//  Copyright © 2016年 蒋毅轩. All rights reserved.
//

#import "YXMineInfoCell.h"

@implementation YXMineInfoCell


/***   重写初始化方法   */
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
        CGFloat iconViewW = 68;
        CGFloat iconViewH = 68;
        self.iconView = [[UIImageView alloc] initWithFrame:CGRectMake(screenW - 40 - iconViewW, (80 - 68) / 2, iconViewW, iconViewH)];
        self.iconView.layer.cornerRadius = 34;
        self.iconView.layer.masksToBounds = YES;
        [self.iconView setImage:[UIImage imageNamed:@"img_68"]];
        
        UIImageView *imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_nva_goto"]];
        self.accessoryView = imageV;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self addSubview:self.iconView];
    }
    return self;
}

/***   重写模型的set方法   */
- (void)setModel:(InfoLabelModel *)model
{
    _model = model;
    
    self.textLabel.text = model.title;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
