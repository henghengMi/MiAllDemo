//
//  MiPop.h
//  Esc_动态自定义单元格
//
//  Created by 袁妙恒 on 15/7/30.
//  Copyright (c) 2015年 袁妙恒. All rights reserved.
//  弹出的指示图层

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface MiPop : NSObject



// 默认水滴紫
+ (void)show:(NSString *)message;

// 正常淡化
+ (void)showFade:(NSString *)message;

// 黑色相机
+ (void)showKaca:(NSString *)message;
// 红色庆祝
+(void)showCongratulate:(NSString *)message;







// 移除layer动画
+ (void)removeAllsAnimation;

// 移除label
+ (void)removeAllofLabel;

@end
