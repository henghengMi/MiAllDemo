//
//  UIBarButtonItem+BarImgButton.m
//  Mi网易新闻
//
//  Created by YuanMiaoHeng on 15/11/13.
//  Copyright © 2015年 LianJiang. All rights reserved.
//

#import "UIBarButtonItem+BarImgButton.h"
#import "UIView+Extension.h"

@implementation UIBarButtonItem (BarImgButton)

+ (instancetype)buttonItemWithImg:(NSString *)img hightLightImg:(NSString *)hightLightImg target:(id)target action:(SEL)action btnTag:(int)btnTag
{
    UIButton *btn = [UIButton buttonWithType:0];
    btn.tag = btnTag;
    [btn setImage:[UIImage imageNamed:img] forState:(UIControlStateNormal)];
    [btn setImage:[UIImage imageNamed:hightLightImg] forState:(UIControlStateHighlighted)];
    [btn addTarget:target action:action forControlEvents:(UIControlEventTouchUpInside)];
    btn.size = btn.currentImage.size;
    return [[UIBarButtonItem alloc]initWithCustomView:btn];
}

@end
