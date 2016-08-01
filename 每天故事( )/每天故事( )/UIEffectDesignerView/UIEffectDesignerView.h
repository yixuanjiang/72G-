//
//  UIEffectDesignerView.h
//  粒子加速效果
//
//  Created by 蒋毅轩 on 16/3/12.
//  Copyright (c) 2016年 蒋毅轩. All rights reserved.
//

#import "QuartzCore/QuartzCore.h"

#if defined(__IPHONE_OS_VERSION_MIN_REQUIRED)
#import <UIKit/UIKit.h>
@interface UIEffectDesignerView : UIView

#else

#import <AppKit/AppKit.h>
@interface UIEffectDesignerView : NSView
#endif

@property (strong, nonatomic) CAEmitterLayer* emitter;

-(instancetype)initWithFile:(NSString*)fileName;
+(instancetype)effectWithFile:(NSString*)fileName;

@end
