//
//  RoundView.h
//  渐变圈1
//
//  Created by YuanMiaoHeng on 15/11/24.
//  Copyright © 2015年 LianJiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RoundView : UIView
{
    CAShapeLayer *_trackLayer;
    UIBezierPath *_trackPath;
    CAShapeLayer *_progressLayer;
    UIBezierPath *_progressPath;
}

@property (nonatomic, strong) UIColor *trackColor;
@property (nonatomic, strong) UIColor *progressColor;
@property (nonatomic) float progress;//0~1之间的数
@property (nonatomic) float progressWidth;

- (void)setProgress:(float)progress animated:(BOOL)animated;
@end
