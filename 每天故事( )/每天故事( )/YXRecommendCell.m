//
//  YXRecommendCell.m
//  每天故事( )
//
//  Created by 蒋毅轩 on 16/3/23.
//  Copyright © 2016年 蒋毅轩. All rights reserved.
//

#import "YXRecommendCell.h"
#import "UIImageView+AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "YXseeBigPicViewController.h"


@interface YXRecommendCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *creataTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *contextLabel;
@property (weak, nonatomic) IBOutlet UIImageView *picImage;
@property (weak, nonatomic) IBOutlet UIButton *seeBigPicButton;

@end

@implementation YXRecommendCell

- (void)awakeFromNib {
    // Initialization code
    self.iconImageView.layer.cornerRadius = 25;
    self.iconImageView.layer.masksToBounds = YES;
    
    self.picImage.userInteractionEnabled = YES;
    [self.picImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPic)]];
}

- (void)setModel:(YXReconmmedModel *)model
{
    _model = model;
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.profile_image]];
    self.nameLabel.text = model.name;
    self.creataTimeLabel.text = model.created_at;
    self.contextLabel.text = model.text;
    [self.picImage sd_setImageWithURL:[NSURL URLWithString:model.image2]];

    
    if (model.isBigPic) {
        self.picImage.contentMode = UIViewContentModeScaleAspectFill;
        //切除imageview承载之外的图片
        self.picImage.clipsToBounds = YES;
        
        //显示下面点击的button
        self.seeBigPicButton.hidden = NO;
    }else
    {
        self.seeBigPicButton.hidden = YES;
    }
    
}

- (void)showPic
{
    YXseeBigPicViewController *showVC = [[YXseeBigPicViewController alloc] init];
    showVC.model = self.model;
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:showVC animated:YES completion:nil];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
