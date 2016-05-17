//
//  UIView+Spring.m
//  Esc_通过Xib自定义View
//
//  Created by YuanMiaoHeng on 15/8/19.
//  Copyright (c) 2015年 LianJiang. All rights reserved.
//

#import "UIView+Spring.h"

@implementation UIView (Spring)

- (void)SpringWithBenginDx:(CGFloat)beginDx beginDy:(CGFloat)beginDy endDx:(CGFloat)endDX endDy:(CGFloat)endDy;
{
    [UIView animateWithDuration:0.1 animations:^{
        
        self.transform = CGAffineTransformTranslate(self.transform, beginDx, beginDy);
        
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.3 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear  animations:^{
            
            self.transform = CGAffineTransformTranslate(self.transform, endDX, endDy);
            
        } completion:nil];
    }];
}

- (void)SpringToPoint:(CGPoint)point
{
//    [UIView animateWithDuration:0.1 animations:^{
//        
////        self.transform = CGAffineTransformTranslate(self.transform, 20, 0);
//        
//    }completion:^(BOOL finished) {
        [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.3 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear  animations:^{
            
//        self.transform = CGAffineTransformTranslate(0, 0,-1000);
//            self.transform = CGAffineTransformTranslate(self.transform, <#CGFloat tx#>, <#CGFloat ty#>)
        } completion:nil];
//    }];
}


- (void)SpringFromOriginalToDx:(CGFloat)endDX endDy:(CGFloat)endDy;
{
   
        [UIView animateWithDuration:0.8 delay:0 usingSpringWithDamping:0.3 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear  animations:^{
            
            self.transform = CGAffineTransformTranslate(self.transform, endDX, endDy);
            
        } completion:nil];
 
}

@end
