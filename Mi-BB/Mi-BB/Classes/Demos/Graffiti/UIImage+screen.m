//
//  UIImage+screen.m
//  Q2D-e04-截图
//
//  Created by 袁妙恒 on 15/6/6.
//  Copyright (c) 2015年 袁妙恒. All rights reserved.
//

#import "UIImage+screen.h"

@implementation UIImage (screen)

+ (instancetype)clipTheView:(UIView *)view
{
    
    //获得上下文
    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, 0);
    
    //将控制器的图层Layer渲染到上下文中******关键代码*******
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    //返回新图片
    UIImage *newImg = UIGraphicsGetImageFromCurrentImageContext();
    
       //结束
    UIGraphicsEndImageContext();
    return newImg;
}

@end
