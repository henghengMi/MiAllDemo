//
//  UIButton+costomBtn.h
//  LJMall
//
//  Created by 蒋林 on 15/9/12.
//  Copyright (c) 2015年 蒋林. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (costomBtn)

+ (instancetype)buttonWithTarget:(id)target selector:(SEL)selector image:(NSString *)image highLightImage:(NSString *)highLightImage;
+ (instancetype)buttonWithTarget:(id)target selector:(SEL)selector title:(NSString *)title image:(NSString *)image highLightImage:(NSString *)highLightImage;
// 快速创建只有文字的按钮
+ (instancetype)LJTitleButtonWithTitle:(NSString *)title  target:(id)target selector:(SEL)selector ;



@end


