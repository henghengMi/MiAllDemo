//
//  UIButton+costomBtn.m
//  LJMall
//
//  Created by 蒋林 on 15/9/12.
//  Copyright (c) 2015年 蒋林. All rights reserved.
//

#import "UIButton+costomBtn.h"

@implementation UIButton (costomBtn)

+ (instancetype)buttonWithTarget:(id)target selector:(SEL)selector image:(NSString *)image highLightImage:(NSString *)highLightImage {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highLightImage] forState:UIControlStateHighlighted];
    [button sizeToFit];
    return button;
}

+ (instancetype)buttonWithTarget:(id)target selector:(SEL)selector title:(NSString *)title image:(NSString *)image highLightImage:(NSString *)highLightImage {
    UIButton *button = [self buttonWithTarget:target selector:selector image:image highLightImage:highLightImage];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [button sizeToFit];
    return button;
}


// 快速创建只有文字的按钮
+ (instancetype)LJTitleButtonWithTitle:(NSString *)title  target:(id)target selector:(SEL)selector {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    button.frame = CGRectMake(0, 0, 50, 44);
    [button sizeToFit];
    return button;
}


@end
