//
//  UIView+Spring.h
//  Esc_通过Xib自定义View
//
//  Created by YuanMiaoHeng on 15/8/19.
//  Copyright (c) 2015年 LianJiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Spring)

- (void)SpringWithBenginDx:(CGFloat)beginDx beginDy:(CGFloat)beginDy endDx:(CGFloat)endDX endDy:(CGFloat)endDy;


- (void)SpringFromOriginalToDx:(CGFloat)endDX endDy:(CGFloat)endDy;





- (void)SpringToPoint:(CGPoint)point;

@end
