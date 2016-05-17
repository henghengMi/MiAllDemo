//
//  RoundView2.m
//  渐变圈1
//
//  Created by YuanMiaoHeng on 15/11/24.
//  Copyright © 2015年 LianJiang. All rights reserved.
//

#import "RoundView2.h"

@implementation RoundView2


- (void)drawRect:(CGRect)rect
{
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
//    
//    NSArray* gradientColors = [NSArray arrayWithObjects:
//                               (id)[UIColor whiteColor].CGColor,
//                               (id)[UIColor blackColor].CGColor, nil];
//    CGFloat gradientLocations[] = {0, 1};
//    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace,
//                                                        (__bridge CFArrayRef)gradientColors,
//                                                        gradientLocations);
//    CGPoint center = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
//    CGFloat radius = MAX(CGRectGetHeight(rect), CGRectGetWidth(rect));
//    CGContextDrawRadialGradient(context, gradient,
//                                center, 0,
//                                center, radius,
//                                kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
//    
//    CGGradientRelease(gradient);
//    CGColorSpaceRelease(colorSpace);
    
    
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGMutablePathRef path = CGPathCreateMutable();
//    int padding = 20;
//    CGPathMoveToPoint(path, NULL, padding, padding);
//    CGPathAddLineToPoint(path, NULL, rect.size.width - padding, rect.size.height / 2);
//    CGPathAddLineToPoint(path, NULL, padding, rect.size.height - padding);
//    CGContextSetShadowWithColor(context, CGSizeZero, 15, [UIColor greenColor].CGColor);
////    CGContextSetShadowWithColor(context, CGSizeZero, 20, UIColor.redColor.CGColor);
//    CGContextSetFillColorWithColor(context, UIColor.blueColor.CGColor);
//    CGContextAddPath(context, path);
//    CGContextFillPath(context);
////     CGContextAddPath(context, path);
////     CGContextFillPath(context);
//    CGPathRelease(path);
    
//    
//    CGFloat components[12]={
//        0.0, 1.0, 0.0, 0.5,     //start color(r,g,b,alpha)
//        1.0, 0.0, 0.0, 0.6,
//        0.0, 0.0, 0.8, 0.7 //end color
//    };
//    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
//    CGGradientRef gradient = CGGradientCreateWithColorComponents(space, components, NULL,3);
//    
//    CGPoint start = CGPointMake(0, 0);  //开始的点
//    CGPoint end = CGPointMake(rect.size.width / 2, rect.size.height /2 ); //结束的点
//    CGFloat startRadius = rect.size.width / 2;//_bj+_sc_kd/2;      //半径
//    CGFloat endRadius = 20; //_bj-_sc_kd/2;          //空心半径
//    
//    CGContextRef graCtx = UIGraphicsGetCurrentContext();
//    CGContextDrawRadialGradient(graCtx, gradient, start, startRadius, end, endRadius, 0);
////    CGContextDrawPath(<#CGContextRef  _Nullable c#>, kCGPathFill)
  
    
    CGFloat viewW = self.bounds.size.width;
    CGFloat viewH = self.bounds.size.height;
    CGContextRef context = UIGraphicsGetCurrentContext();

    

    
    
    //    CGConextSetStrokeColorSpace;
    //CGConextSetStrokeColorSpace
    //创建色彩空间对象
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    //创建渐变对象
    CGGradientRef gradientRef = CGGradientCreateWithColorComponents(colorSpaceRef,
                                                                    (CGFloat[]){
                                                                        0.01f,
                                                                        0.99f, 0.01f, 1.0f,
                                                                        0.01f,
                                                                        0.99f, 0.99f, 1.0f,
                                                                        0.99f,
                                                                        0.99f, 0.01f, 1.0f
                                                                    },
                                                                    (CGFloat[]){
                                                                        0.0f,
                                                                        0.5f,
                                                                        1.0f
                                                                    },
                                                                    3);
    
    //释放色彩空间
    CGColorSpaceRelease(colorSpaceRef);
    //填充渐变色
    
    CGContextDrawLinearGradient(context,
                                gradientRef, CGPointMake(0.0f, 0.0f), CGPointMake(0.0f, 200.0f), 0);
    //释放渐变对象
    CGGradientRelease(gradientRef);
    
    
    
    CGContextStrokePath(context);

    
}

@end
