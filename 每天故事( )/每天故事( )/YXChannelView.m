//
//  YXChannelView.m
//  每天故事
//
//  Created by 蒋毅轩 on 16/3/19.
//  Copyright © 2016年 蒋毅轩. All rights reserved.
//

#import "YXChannelView.h"

@interface YXChannelView ()

@property (nonatomic ,strong) NSMutableArray *channelArray;
@property (nonatomic ,strong) NSMutableArray *settingArray;

@property (nonatomic ,strong) NSMutableArray *otherArray;

@property (nonatomic,strong) UILabel *otherLabel;

@property (nonatomic,strong) UIButton *button;

@end

@implementation YXChannelView

#pragma mark - 懒加载channelArray
- (NSMutableArray *)channelArray
{
    if (!_channelArray) {
        _channelArray = [NSMutableArray array];
    }
    return _channelArray;
}

#pragma mark - 懒加载settingArray
- (NSMutableArray *)settingArray
{
    if (!_settingArray) {
        _settingArray = [NSMutableArray array];
    }
    return _settingArray;
}

#pragma mark - 懒加载otherArray
- (NSMutableArray *)otherArray
{
    if (!_otherArray) {
        _otherArray = [NSMutableArray array];
    }
    return _otherArray;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame style:UITableViewStyleGrouped]) {
        self.backgroundColor = [UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1.0];
        
        CGFloat labelY = 80;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, labelY, 100, 20)];
        label.text = @"我的频道";
        [self addSubview:label];
        
        self.otherLabel = [[UILabel alloc] init];
        self.otherLabel.text = @"频道推荐";
        [self addSubview:self.otherLabel];
        
        UIButton *button = [YXEditButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundImage:[UIImage imageNamed:@"btn_edit"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"btn_complete"] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(editButtonClick:) forControlEvents:UIControlEventTouchDown];
        CGSize buttonSize = button.currentBackgroundImage.size;
        button.frame = CGRectMake(frame.size.width - 60, labelY, buttonSize.width, buttonSize.height);
        [self addSubview:button];
        
        //创建12个频道
        NSArray *titleArray = @[@"推荐",@"关注",@"爱情",@"悬疑",@"婚姻",@"世情",@"灵异",@"青春",@"奇幻",@"传奇",@"古风",@"励志",];
        for (NSInteger i = 0; i < titleArray.count; i++) {
            UIButton *channelButton = [[YXEditButton alloc] init];
            [channelButton setTitle:titleArray[i] forState:UIControlStateNormal];
            [channelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [channelButton setTitleColor:[UIColor greenColor] forState:UIControlStateHighlighted];
            channelButton.font = [UIFont systemFontOfSize:15];
            [channelButton addTarget:self action:@selector(channelButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            channelButton.tag = i;
            channelButton.layer.cornerRadius = 5;
            channelButton.layer.masksToBounds = YES;
            channelButton.backgroundColor = [UIColor whiteColor];
            [self addSubview:channelButton];
            
            //添加到totle数组里
            [self.channelArray addObject:channelButton];
            [self.settingArray addObject:channelButton];
        }
        
        //设置我的频道
        [self setUpMyChannel:self.channelArray otherChannel:self.otherArray];
    }
    return self;
}

- (void)setUpMyChannel:(NSArray *)array otherChannel:(NSArray *)otherArray
{
    CGFloat leftMargin = 15;
    CGFloat butweenMargin = 10;
    CGFloat channelW = (self.frame.size.width - 2 * (leftMargin + butweenMargin)) / 3;
    CGFloat channelH = 30;
    
    for (NSInteger i = 0; i < array.count; i++) {
        //行数
        NSInteger line = i / 3;
        //列数
        NSInteger row =  i % 3;
        
        UIButton *myButton = array[i];
        myButton.frame = CGRectMake(leftMargin + (butweenMargin + channelW) * row, 120 + (butweenMargin + channelH) * line, channelW, channelH);
        
        
    }
    
    CGFloat myChannelMaxY = 0;
    if (array.count % 3 == 0) {
        myChannelMaxY = 120 + (array.count / 3) * (butweenMargin + channelH);
    }else
    {
        myChannelMaxY = 120 + (array.count / 3 + 1) * (butweenMargin + channelH);
    }
    
    CGFloat otherChannelY = myChannelMaxY + 20;
    self.otherLabel.frame = CGRectMake(leftMargin, otherChannelY, 100, 20);
    
    for (NSInteger i = 0; i < otherArray.count; i++) {
        //行数
        NSInteger line = i / 3;
        //列数
        NSInteger row =  i % 3;

        UIButton *myButton = otherArray[i];
        myButton.frame = CGRectMake(leftMargin + (butweenMargin + channelW) * row, otherChannelY + 35 + (butweenMargin + channelH) * line, channelW, channelH);
       
    }
}

#pragma mark - editButtonClick
- (void)editButtonClick:(UIButton *)sender
{
    if (sender.selected == NO) {
        
    }
    sender.selected = !sender.selected;

}

#pragma mark - channelButtonClick
- (void)channelButtonClick:(UIButton *)sender
{
    NSString *title = sender.titleLabel.text;
    NSLog(@"%@",title);
    
    if (sender.selected == NO) {
        //取出按钮
        for (UIButton *clickbutton in self.settingArray) {
            
            if ([clickbutton.titleLabel.text isEqualToString:title]) {
                self.button = clickbutton;
                
                [self.channelArray removeObject:clickbutton];
                //添加到下面数组中
                [self.otherArray addObject:self.button];
  
                [self setUpMyChannel:self.channelArray otherChannel:self.otherArray];
                NSLog(@"1111");
            }
            
        }

        NSLog(@"NO");
    }else
    {
        
        //取出按钮
        for (UIButton *clickbutton in self.settingArray) {

            if ([clickbutton.titleLabel.text isEqualToString:title]) {
                self.button = clickbutton;
                
                [self.otherArray removeObject:self.button];
                //添加到上面数组中
                [self.channelArray addObject:self.button];
                
                [self setUpMyChannel:self.channelArray otherChannel:self.otherArray];
                NSLog(@"2222");
        }
        }

         NSLog(@"YES");
    }
    sender.selected = !sender.selected;
   
}

@end

@implementation YXEditButton

- (void)setHighlighted:(BOOL)highlighted
{
    
}

@end
