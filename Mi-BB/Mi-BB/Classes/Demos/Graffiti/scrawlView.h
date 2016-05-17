//
//  scrawlView.h
//  涂鸦-01
//
//  Created by 袁妙恒 on 15/6/7.
//  Copyright (c) 2015年 袁妙恒. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface scrawlView : UIView

@property(nonatomic,assign)CGFloat lineW;
@property(nonatomic,strong)UIColor *linecolor;

- (UIColor *)setLineColor:(UIColor *)color;

- (void)back;
- (void)clear;
@end
