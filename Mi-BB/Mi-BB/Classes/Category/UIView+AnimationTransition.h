//
//  UIView+AnimationTransition.h
//  Esc_转场动画
//
//  Created by YuanMiaoHeng on 15/8/25.
//  Copyright (c) 2015年 LianJiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (AnimationTransition)



/** 转场动画类型
 *******************************************************
 type:动画类型(比如：滴水效果，翻转效果...)
 -------------------------------------------------------
 fade kCATransitionFade 交叉淡化过渡
 moveIn kCATransitionMoveIn 新视图移到旧视图上面
 push kCATransitionPush 新视图把旧视图推出去
 reveal kCATransitionReveal 将旧视图移开,显示下面的新视图
 pageCurl               向上翻一页
 pageUnCurl             向下翻一页
 rippleEffect             滴水效果
 suckEffect 收缩效果，如一块布被抽走
 cube                   立方体效果
 oglFlip              上下左右翻转效果
 rotate     旋转效果
 cameraIrisHollowClose 相机镜头关上效果(不支持过渡方向)
 cameraIrisHollowOpen 相机镜头打开效果(不支持过渡方向)
 
 *******************************************************
 subtype: 动画方向(比如说是从左边进入，还是从右边进入...)
 ------------------------------------------------------
 kCATransitionFromRight;
 kCATransitionFromLeft;
 kCATransitionFromTop;
 kCATransitionFromBottom;
 
 当 type 为@"rotate"(旋转)的时候,它也有几个对应的 subtype,分别为:
 90cw 逆时针旋转 90°
 90ccw 顺时针旋转 90°
 180cw 逆时针旋转 180°
 180ccw  顺时针旋转 180°
 **/


/*
 * 转场动画，指定type 、subType ， 默认0.5秒
 */
- (void) transitionnWithType:(NSString *)type subType:(NSString *)subType;

/*
 * 转场动画，可以自己设置秒数
 */
- (void) transitionWithDuration:(CFTimeInterval)duration Type:(NSString *)type subType:(NSString *)subType;



@end
