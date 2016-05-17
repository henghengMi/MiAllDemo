
//  UIView+Animation.h
//  Created by YuanMiaoHeng on 15/8/22.
//  Copyright (c) 2015年 LianJiang. All rights reserved.

/*
 /*
 *keyPath 动画类型
 *平移动画: position/transform.translation.x
 *旋转动画: transform.rotation/transform.rotation.x/transform.rotation/rotation.y
 *缩放动画: bounds/transform.scale/transform.scale.x/transform.scale.y

 */


/* 
 * View的实例调用就会有相应动画
 * 目前有的动画类型
  1. 转圈圈
  2. 旋转角度
  3. 左右摇摆（iPone删除效果）
  4. 缩放
  5. 位移
 */
#import <UIKit/UIKit.h>

@interface UIView (Animation)

//================缩放===================

/*
 * 缩放,默认倍数。
 */
- (void)zoomWithDuration:(NSTimeInterval)duration;

/*
 * 缩放,自己喜欢放多少倍自己调去。
 */
- (void)zoomWithDuration:(NSTimeInterval)duration values:(NSArray *)values;

/**
 *  缩放、Pefect参数。
 */
- (void)zoomWithDuration:(NSTimeInterval)duration repeatCount:(float)repeatCount values:(NSArray *)values;


//================旋转===================
/*
 * 转圈圈, 默认逆时针
 */
- (void)circleWithDuration:(NSTimeInterval)duration;


/*
 * 旋转角度
 */
- (void)rotateWithAngle:(CGFloat)angle duration:(CFTimeInterval)duration;

/*
 * 左右摇摆
 */
- (void)shake;


//================平移===================
/*
 * 平移
 */
- (void)translate;




/*
 * 相应的停止方法
 */
- (void)stopShake;

- (void)stopRotate;

- (void)stopCircle;

- (void)stopScale;

- (void)stopTranslate;
@end
