//
//  YXRecomLabelCellTableViewCell.m
//  每天故事( )
//
//  Created by 蒋毅轩 on 16/3/23.
//  Copyright © 2016年 蒋毅轩. All rights reserved.
//

#import "YXRecomLabelCellTableViewCell.h"
#import "UIImageView+AFNetworking.h"

@interface YXRecomLabelCellTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *creataTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *contextLabel;
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;

@end

@implementation YXRecomLabelCellTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    self.iconImageView.layer.cornerRadius = 25;
    self.iconImageView.layer.masksToBounds = YES;
}

- (void)setFrameModel:(YXLabelFrameModel *)frameModel
{
    _frameModel = frameModel;
    
    YXLabelModel *model = frameModel.model;
    
    [self.iconImageView setImageWithURL:[NSURL URLWithString:model.profile_image]];
    self.nameLabel.text = model.name;
    self.creataTimeLabel.text = model.created_at;
    self.contextLabel.text = model.text;
    [self.dingButton setTitle:model.love forState:UIControlStateNormal];
    [self.caiButton setTitle:model.hate forState:UIControlStateNormal];
    [self.shareButton setTitle:model.repost forState:UIControlStateNormal];
    [self.commentButton setTitle:model.comment forState:UIControlStateNormal];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
