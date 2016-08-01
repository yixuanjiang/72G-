//
//  YXReconmmedModel.h
//  每天故事( )
//
//  Created by 蒋毅轩 on 16/3/23.
//  Copyright © 2016年 蒋毅轩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YXReconmmedModel : NSObject

/***   发布者图像   */
@property (nonatomic,copy) NSString *profile_image;
/***   发布者name   */
@property (nonatomic,copy) NSString *name;
/***   创建时间   */
@property (nonatomic,copy) NSString *created_at;
/***   内容   */
@property (nonatomic,copy) NSString *text;
/***   图片URL   */
@property (nonatomic,copy) NSString *image2;

/***   点赞数   */
@property (nonatomic,copy) NSString *love;
/***   踩数   */
@property (nonatomic,copy) NSString *hate;
/***   转发次数   */
@property (nonatomic,copy) NSString *repost;
/***   评论数量   */
@property (nonatomic,copy) NSString *comment;
/***   height   */
@property (nonatomic,copy) NSString *height;
/***   width   */
@property (nonatomic,copy) NSString *width;

//  辅助属性
/***   行高   */
@property (nonatomic,assign) CGFloat cellHeight;
/***   图片适配屏幕宽度后的高度尺寸   */
@property (nonatomic,assign) CGFloat picH;
/***   是否为大图   */
@property (nonatomic,assign,getter=isBigPic) BOOL bigPic;


@end
