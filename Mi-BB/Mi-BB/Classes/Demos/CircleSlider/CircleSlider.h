//
//  CircleSliderView.h
//  圆形slider
//
//  Created by YuanMiaoHeng on 15/11/27.
//  Copyright © 2015年 LianJiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"
@interface CircleSlider : UIControl

@property(nonatomic, assign) CGFloat angle;

@property(nonatomic, assign) CGFloat minValue;

@property(nonatomic, assign) CGFloat maxValue;

@property(nonatomic, assign) CGFloat currentValue;

@end
