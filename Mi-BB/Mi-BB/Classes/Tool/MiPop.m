//
//  MiPop.m
//  Esc_动态自定义单元格
//
//  Created by 袁妙恒 on 15/7/30.
//  Copyright (c) 2015年 袁妙恒. All rights reserved.
//
#define MiColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#define dispearDuration 1.5 // 多少秒后消失

#define effectDuration 1.5 //  细化效果维持多少秒

#import "MiPop.h"

@interface MiPop ()



@end

@implementation MiPop


/*
 * 这里的 duration: 是指
 */
static  UILabel *label;


#pragma mark - 加了颜色的基础方法
+ (void)_basicWithMessage:(NSString *)message
           labelTextColor:(UIColor *)textColor
             labelBgColor:(UIColor *)BgColor
      duration:(NSTimeInterval)duration
          Type:(NSString *)type
       subType:(NSString *)subType
{
    [self _basicWithMessage:message duration:duration Type:type subType:subType];

    label.backgroundColor = textColor;
    label.backgroundColor = BgColor;
    
    
}

#pragma mark - 基础方法、其他方法由此延伸---私有方法
+ (void)_basicWithMessage:(NSString *)message
                 duration:(NSTimeInterval)duration
                     Type:(NSString *)type
                  subType:(NSString *)subType
{
    // 0. 关键！ 拿到当前使用的View
    UIView *view = [[UIApplication sharedApplication].windows lastObject];
    
    // 1.标签
    label = [[UILabel alloc] init];
    label.tag = 100;
    label.text = message;
    label.font = [UIFont systemFontOfSize:16];
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = MiColor(255 , 255, 255);
    label.backgroundColor = MiColor(44, 16, 118);
    
    
    NSDictionary *attrs = @{NSFontAttributeName : label.font};
    // 根据尺寸算高度
    CGSize maxSize = CGSizeMake(view.frame.size.width * 0.5, MAXFLOAT);
    CGSize labelSize = [label.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    label.frame = (CGRect){CGPointZero,CGSizeMake(labelSize.width + 20, labelSize.height + 20)};// 让上下左右有间距
    label.center = CGPointMake(view.frame.size.width * 0.5 , view.frame.size.height * 0.5 + 50);
    label.alpha = 0.0;
    label.layer.cornerRadius = 9; // 9刚刚好
    label.clipsToBounds = YES;
    [view addSubview:label];
    
    
    
    // 2.动画
    [UIView animateWithDuration:duration animations:^{
        // 出来的时候
          label.alpha = 0.5;
//        [self transitionWithDuration:duration Type:type WithSubtype:subType ForView:label];
        
    } completion:^(BOOL finished) {
         // 加效果
        
        // 变为0 delay : 动画持续时间。
        [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            
            label.alpha = 0;

            [self transitionWithDuration:duration Type:type WithSubtype:subType ForView:label];



        } completion:^(BOOL finished) {
            
            [label removeFromSuperview];
            
            [label.layer removeAnimationForKey:@"animation"];
            
        }];
    }];
    

}


#pragma mark 基础动画小封
// duration指的是动画持续多久
+ (void) transitionWithDuration:(NSTimeInterval)duration Type:(NSString *)type WithSubtype:(NSString *)subtype ForView:(UIView *) view
{
    
    CATransition * animation = [CATransition animation];
    animation.duration       = duration   ;
    animation.type           = type;
    
    if (subtype != nil) {
        
        //设置子类
        animation.subtype = subtype;
        
    }
    
    animation.timingFunction = UIViewAnimationOptionCurveEaseInOut;
    
    [view.layer addAnimation:animation forKey:@"animation"];
    
}


#pragma mark - 效果集合 水滴紫为默认
// 默认的水晶紫
+ (void)show:(NSString *)message;
{

    [self _basicWithMessage:message duration:effectDuration Type:@"rippleEffect" subType:kCATransitionFromLeft];
}

// 正常淡化
+ (void)showFade:(NSString *)message{
    
    [self _basicWithMessage:message duration:effectDuration Type:kCATransitionFade subType:kCATransitionFromTop];
}

// 相机
+ (void)showKaca:(NSString *)message
{
    [self _basicWithMessage:message labelTextColor:[UIColor whiteColor] labelBgColor:[UIColor blackColor] duration:effectDuration Type:@"cameraIrisHollowClose" subType:kCATransitionFromLeft];
}

// 庆祝
+ (void)showCongratulate:(NSString *)message
{
    [self _basicWithMessage:message labelTextColor:[UIColor redColor] labelBgColor:MiColor(255, 29, 139) duration:effectDuration Type:@"oglFlip" subType:kCATransitionFromBottom];
}



//================转场效果===================
/**
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

+ (void)removeAllsAnimation
{
    [label.layer removeAllAnimations];
}

+ (void)removeAllofLabel
{
    [label removeFromSuperview];
}
@end
