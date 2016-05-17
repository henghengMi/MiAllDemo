//
//  UIView+Animation.m
//  帧_抖动动画
//
//  Created by YuanMiaoHeng on 15/8/22.
//  Copyright (c) 2015年 LianJiang. All rights reserved.
//

#import "UIView+Animation.h"

@implementation UIView (Animation)

/**
 *  缩放
 */

- (void)zoomWithDuration:(NSTimeInterval)duration
{
    // 创建动画对象
    CAKeyframeAnimation *rotationAni = [CAKeyframeAnimation animation];
    
    // 动画类型
    rotationAni.keyPath =  @"transform.scale";
    
    // 计算弧度
    //CGFloat angle = M_PI   ;
    
    // 设置缩放倍数
    rotationAni.values = @[@1,@5.0,@1];
    rotationAni.removedOnCompletion = YES;
    // 设置时间
    // 1. 自定义时间 以百分比为单位
    //      rotationAni.keyTimes = @[@5,@5,@5];
    // 2. 1个路径走的总共时间
    rotationAni.duration = duration;
    
    // 执行次数
    rotationAni.repeatCount = MAXFLOAT;
    
    
    
    // 添加动画到对应的View的图层上去
    // Key 是为动画绑定一个标识，将来可以随时移除动画。
    [self.layer addAnimation:rotationAni forKey:@"scale"];
    
}
/**
 *  缩放：提供缩放的数值的数字就行，里面要放对象
 */
- (void)zoomWithDuration:(NSTimeInterval)duration values:(NSArray *)values
{
    // 创建动画对象
    CAKeyframeAnimation *rotationAni = [CAKeyframeAnimation animation];
    
    // 动画类型
    rotationAni.keyPath =  @"transform.scale";
    
    // 计算弧度
    //CGFloat angle = M_PI   ;
    
    // 设置缩放倍数
    rotationAni.values = values;
    rotationAni.removedOnCompletion = NO;
    // 设置时间
    // 1. 自定义时间 以百分比为单位
//          rotationAni.keyTimes = @[@5,@5,@5];
    // 2. 1个路径走的总共时间
    rotationAni.duration = duration;
    
    // 执行次数
    rotationAni.repeatCount = 1;
    
    // 添加动画到对应的View的图层上去
    // Key 是为动画绑定一个标识，将来可以随时移除动画。
    [self.layer addAnimation:rotationAni forKey:@"scale"];
    
}
/**
 *  缩放、Pefect参数。
 */
- (void)zoomWithDuration:(NSTimeInterval)duration repeatCount:(float)repeatCount values:(NSArray *)values
{
    // 创建动画对象
    CAKeyframeAnimation *rotationAni = [CAKeyframeAnimation animation];
    
    // 动画类型
    rotationAni.keyPath =  @"transform.scale";
    
    // 计算弧度
    //CGFloat angle = M_PI   ;
    
    // 设置缩放倍数
    rotationAni.values = values;
    rotationAni.removedOnCompletion = NO;
    rotationAni.fillMode = kCAFillModeForwards;
    
    // 设置时间
    // 1. 自定义时间 以百分比为单位
    //      rotationAni.keyTimes = @[@5,@5,@5];
    // 2. 1个路径走的总共时间
    rotationAni.duration = duration;
    
    // 执行次数
    rotationAni.repeatCount = repeatCount;
    
    // 添加动画到对应的View的图层上去
    // Key 是为动画绑定一个标识，将来可以随时移除动画。
    [self.layer addAnimation:rotationAni forKey:@"scale"];
    
}



/**
 *  转圈圈
 */
- (void)circleWithDuration:(NSTimeInterval)duration
{
    // 创建动画对象
    CAKeyframeAnimation *rotationAni = [CAKeyframeAnimation animation];
    
    // 动画类型
    rotationAni.keyPath =  @"transform.rotation";
    
    // 计算弧度
    CGFloat angle = M_PI   ;
    
    // 设置旋转路径
    rotationAni.values = @[@0,@(-angle),@(angle * -2) ];
    
    // 设置时间
    // 1. 自定义时间 以百分比为单位
    //      rotationAni.keyTimes = @[@5,@5,@5];
    // 2. 1个路径走的总共时间
    rotationAni.duration = duration;
    
    // 执行次数
    rotationAni.repeatCount = MAXFLOAT;
    
    // 添加动画到对应的View的图层上去
    // Key 是为动画绑定一个标识，将来可以随时移除动画。
    [self.layer addAnimation:rotationAni forKey:@"circle"];
}



- (void)rotateWithAngle:(CGFloat)angle duration:(CFTimeInterval)duration
{
    // 创建动画对象
    CAKeyframeAnimation *rotationAni = [CAKeyframeAnimation animation];
    
    // 动画类型
    rotationAni.keyPath =  @"transform.rotation";
    
    // 计算弧度
//    CGFloat angle = M_PI;
    
    // 设置旋转路径
    rotationAni.values = @[@(angle),@(-angle),@(angle)];
    
    // 设置时间
    // 1. 自定义时间 以百分比为单位
    //    rotationAni.keyTimes = @[@5,@3];
    // 2. 1个路径走的总共时间
       rotationAni.duration = duration;
    
    // 执行次数
    rotationAni.repeatCount = MAXFLOAT;
    
    // 添加动画到对应的View的图层上去
    // Key 是为动画绑定一个标识，将来可以随时移除动画。
    [self.layer addAnimation:rotationAni forKey:@"rotation"];
}


/**
 *  抖动吧。。少年
 */
- (void)shake
{
    // 创建动画对象
    CAKeyframeAnimation *rotationAni = [CAKeyframeAnimation animation];
    
    // 动画类型
    rotationAni.keyPath =  @"transform.rotation";
    
    // 计算弧度
        CGFloat angle = M_PI_4 * 0.2 ;
    
    // 设置旋转路径
    rotationAni.values = @[@(angle),@(-angle),@(angle)];
    
    // 设置时间
    // 1. 自定义时间 以百分比为单位
    //    rotationAni.keyTimes = @[@5,@3];
    // 2. 1个路径走的总共时间
//    rotationAni.duration = duration;
    
    // 执行次数
    rotationAni.repeatCount = MAXFLOAT;
    
    // 添加动画到对应的View的图层上去
    // Key 是为动画绑定一个标识，将来可以随时移除动画。
    [self.layer addAnimation:rotationAni forKey:@"shake"];
    
}

/**
 *  平移吧。。少年
 */
- (void)translate
{
    // 创建动画对象
    CAKeyframeAnimation *traslateAni = [CAKeyframeAnimation animation];
    
    // 动画类型
    traslateAni.keyPath =  @"transform.translation.x";
    
    // 计算弧度
   // CGFloat angle = M_PI_4 * 0.2 ;
    
    // 设置旋转路径
    traslateAni.values = @[@(50),@(-50),@(50)];
    
    // 设置时间
    // 1. 自定义时间 以百分比为单位
    //    rotationAni.keyTimes = @[@5,@3];
    // 2. 1个路径走的总共时间
    //    rotationAni.duration = duration;
    
    // 执行次数
    traslateAni.repeatCount = MAXFLOAT;
    
    // 添加动画到对应的View的图层上去
    // Key 是为动画绑定一个标识，将来可以随时移除动画。
    [self.layer addAnimation:traslateAni forKey:@"traslate"];
    
}


/**
 *  平移吧。。少年参数
 */
- (void)translateWithDuration:(NSTimeInterval)duration values:(NSArray *)values;
{
    // 创建动画对象
    CAKeyframeAnimation *traslateAni = [CAKeyframeAnimation animation];
    
    // 动画类型
    traslateAni.keyPath =  @"transform.translation.x";
    
    // 计算弧度
    // CGFloat angle = M_PI_4 * 0.2 ;
    
    // 设置旋转路径
    traslateAni.values = values;
    
    // 设置时间
    // 1. 自定义时间 以百分比为单位
    //    rotationAni.keyTimes = @[@5,@3];
    // 2. 1个路径走的总共时间
        traslateAni.duration = duration;
    
    // 执行次数
    traslateAni.repeatCount = MAXFLOAT;
    
    // 添加动画到对应的View的图层上去
    // Key 是为动画绑定一个标识，将来可以随时移除动画。
    //[self.layer addAnimation:traslateAni forKey:@"traslate"];
    
}

/**
 *  停止抖动
 */
- (void)stopShake
{
    [self.layer removeAnimationForKey:@"shake"];
}

/**
 *  停止旋转角度
 */
- (void)stopRotate
{
    [self.layer removeAnimationForKey:@"rotation"];
}

/**
 *   停止转圈圈
 */
- (void)stopCircle
{
    [self.layer removeAnimationForKey:@"circle"];
}

- (void)stopScale
{
    [self.layer removeAnimationForKey:@"scale"];
}

- (void)stopTranslate
{
    //[self.layer removeAnimationForKey:@"translate"];
    [self.layer removeAllAnimations];

}
@end
