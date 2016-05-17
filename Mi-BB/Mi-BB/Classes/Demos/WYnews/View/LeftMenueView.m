//
//  LeftMenueView.m
//  Mi网易新闻
//
//  Created by YuanMiaoHeng on 15/11/13.
//  Copyright © 2015年 LianJiang. All rights reserved.
//

#import "LeftMenueView.h"
#import "NotHighlightButton.h"
@interface LeftMenueView ()

@property(nonatomic,weak)UIButton * selectedButton;

@end

@implementation LeftMenueView


- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        [self UI];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setDelegate:(id<LeftMenueViewDelegate>)delegate
{
    _delegate = delegate;
    // 默认点击第一个
    [self btnClick: [self.subviews firstObject]];
}

- (void)UI
{
    CGFloat alph = 0.2;
    [self setupButtonWithTitle:@"新闻" image:@"sidebar_nav_comment" Color:MiColorRGBA(178, 178, 75, 0.2)];
    [self setupButtonWithTitle:@"订阅" image:@"sidebar_nav_news" Color:MiColorRGBA(147, 71, 74, alph)];
    [self setupButtonWithTitle:@"图片" image:@"sidebar_nav_photo" Color:MiColorRGBA(83, 145, 199, alph)];
    [self setupButtonWithTitle:@"视频" image:@"sidebar_nav_radio" Color:MiColorRGBA(199, 84, 135, alph)];
    [self setupButtonWithTitle:@"跟帖" image:@"sidebar_nav_reading" Color:MiColorRGBA(199, 129, 84, alph)];
    [self setupButtonWithTitle:@"电台" image:@"sidebar_nav_video" Color:MiColorRGBA(118, 181, 96, alph)];
}

- (UIButton *)setupButtonWithTitle:(NSString *)title image:(NSString *)image Color:(UIColor *)color
{
    NotHighlightButton *btn = [NotHighlightButton buttonWithType:0];
    btn.tag = self.subviews.count;
    [btn setTitle:title forState:(UIControlStateNormal)];
    [btn setImage:[UIImage imageNamed:image] forState:(UIControlStateNormal)];
    btn.adjustsImageWhenHighlighted = NO;
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft; // 按钮左对齐
    [self addSubview:btn];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    btn.contentEdgeInsets = UIEdgeInsetsMake(0, 50, 0, 0);
    [btn setBackgroundImage:[UIImage imageWithColor:color] forState:(UIControlStateSelected)];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:(UIControlEventTouchDown)];
    
    return btn;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    NSInteger count =  self.subviews.count;

   
    for (int i = 0; i < count; i++) {
        UIButton *btn = self.subviews[i];
        btn.width = self_W;
        btn.height = self_H / count;
        btn.y = btn.height * i;
    }
}
- (void)btnClick:(UIButton *)btn
{
  
    if ([self.delegate  respondsToSelector:@selector(LeftMenue:didSelectedWithFormIndex:toIndex:)]) {
        [self.delegate LeftMenue:self didSelectedWithFormIndex:self.selectedButton.tag toIndex:btn.tag];
    }
    self.selectedButton.selected = NO;
    btn.selected = YES;
    self.selectedButton = btn;

}


@end
