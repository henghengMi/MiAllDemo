//
//  CircleSliderView.m
//  圆形slider
//
//  Created by YuanMiaoHeng on 15/11/27.
//  Copyright © 2015年 LianJiang. All rights reserved.
//

#import "CircleSlider.h"
#import "Header.h"
#define ToRad(deg) 		( (M_PI * (deg)) / 180.0 )
#define ToDeg(rad)		( (180.0 * (rad)) / M_PI )
#define SQR(x)			( (x) * (x) )

#define radius 120

#define bglineWidth 7
#define presslineWidth 17

@interface CircleSlider ()
{
    CGPoint _lastPoint;
    CGFloat _addAngle;
}

@end
@implementation CircleSlider

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.angle = 135; // 起始角度为135度
        if (!self.minValue)       // 默认最小值
            self.minValue = 0.0f;
        
        if (!self.maxValue)        // 默认最大值
            self.maxValue = 1.0f;

    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGFloat viewW = rect.size.width;
    CGFloat viewH = rect.size.height;
    CGFloat starAngle = M_PI_2 + M_PI_4;
    CGFloat endAngle  = 2 * M_PI + M_PI_4;
    
    // 1.背景
    CGContextAddArc(context, viewW * 0.5, viewH * 0.5, radius,starAngle , endAngle, 0);
    [[UIColor lightGrayColor] set];
    CGContextSetLineWidth(context, bglineWidth);
    CGContextSetShadowWithColor(context, CGSizeZero, 2, [UIColor grayColor].CGColor);
    CGContextStrokePath(context);
    
    // 2. 隐藏进度，幕后黑手
    CGContextAddArc(context, viewW * 0.5, viewH * 0.5, radius, starAngle ,ToRad(_angle) , 0);
    CGContextSetLineWidth(context, bglineWidth);
    CGContextStrokePath(context);
    
    NSLog(@"self.angle:%f",self.angle);
    
    
    // 颜色 超过3分1就换颜色
    if (_addAngle >= 0 && _addAngle < 90)
    {
        [self drawPressWithRect:rect context:context startAngle:starAngle color:[UIColor yellowColor]];
        
    }
    else if (_addAngle >= 90 && _addAngle <= 179)
    {
        [self drawPressWithRect:rect context:context startAngle:starAngle color:[UIColor yellowColor]];
        [self drawPressWithRect:rect context:context startAngle:starAngle + M_PI_2 color:[UIColor cyanColor]];
    }
    else if ( _addAngle >= 179 && _addAngle <= 270)
    {
        
        [self drawPressWithRect:rect context:context startAngle:starAngle color:[UIColor yellowColor]];
        [self drawPressWithRect:rect context:context startAngle:starAngle + M_PI_2 color:[UIColor cyanColor]];
        [self drawPressWithRect:rect context:context startAngle:starAngle + M_PI color:[UIColor redColor]];
    }

    // 3. 滑块
    CGPoint handleCenter =  [self pointFromAngle:self.angle];
    CGContextSetShadowWithColor(context, CGSizeZero, 10,[UIColor greenColor].CGColor);
    [[UIColor blueColor] set];
    CGContextSetLineWidth(context, bglineWidth * 2);
    CGContextAddEllipseInRect(context, CGRectMake(handleCenter.x , handleCenter.y, 30, 30));
    CGContextDrawPath(context, kCGPathFill);
}

#pragma mark 画进度条
- (void)drawPressWithRect:(CGRect)rect context:(CGContextRef)context startAngle:(CGFloat)startAngle color:(UIColor *)color
{
    CGFloat viewW = rect.size.width;
    CGFloat viewH = rect.size.height;
    CGContextAddArc(context, viewW * 0.5, viewH * 0.5, radius, startAngle ,ToRad(_angle) , 0);
    [color set];
    CGContextSetLineWidth(context, presslineWidth);
    CGContextSetLineCap(context, kCGLineCapRound);
//    CGContextSetShadow(context, CGSizeMake(5, 0), 0);
    CGContextStrokePath(context);
}

-(CGPoint)pointFromAngle:(int)angleInt{
    //中心点
    CGPoint centerPoint = CGPointMake(self.frame.size.width/2 - presslineWidth, self.frame.size.height/2 - presslineWidth);
    //根据角度得到圆环上的坐标
    CGPoint result;
    result.y = round(centerPoint.y + radius * sin(ToRad(angleInt)));
    result.x = round(centerPoint.x + radius * cos(ToRad(angleInt)));
    return result;
}



#pragma mark  跟踪
- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    [super beginTrackingWithTouch:touch withEvent:event];
    NSLog(@"beginTrackingWithTouch");
    
    return YES;
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    [super continueTrackingWithTouch:touch withEvent:event];
    CGPoint lastPoint = [touch locationInView:self];
    // 移动滑块
    [self moveHandle:lastPoint];
    // 发送值改变事件
    [self sendActionsForControlEvents:(UIControlEventValueChanged)];
    // 记下上一次的点
    _lastPoint = lastPoint;
    return YES;
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    [super endTrackingWithTouch:touch withEvent:event];
    
//    NSLog(@"endTrackingWithTouch");
}


// 移动的操作，计算出角度再刷帧。
- (void)moveHandle:(CGPoint )lastPoint
{
    CGPoint centerPoint = CGPointMake(self.bounds.size.width/2,self.bounds.size.height/2);
    //计算中心点到任意点的角度
    float currentAngle = AngleFromNorth(centerPoint,lastPoint,NO);
    int angleInt = floor(currentAngle);
   
//    NSLog(@"angleInt%d",angleInt);
    
    if (angleInt > 45 && angleInt <= 90)
    {
        angleInt = 45;
        return;
    }
        else if (angleInt > 90 && angleInt < 135)
    {
        angleInt = 135;
        return;
    }
    //保存新角度
    self.angle = angleInt;
    // 转化为0度开始到270度
    _addAngle =  (angleInt >= 0 && angleInt <= 45) ? 360 + angleInt - 135 :  angleInt -135;
    // 比例
    CGFloat scale =  _addAngle / 270 * self.maxValue;
    // 当前值
    self.currentValue = scale * (self.maxValue - self.minValue);
    
    NSLog(@"_addAngle :%f",_addAngle);
    //重新绘制
    [self setNeedsDisplay];
}

// 计算圆中心点到任意点的角度
static inline float AngleFromNorth(CGPoint p1, CGPoint p2, BOOL flipped) {
  
    CGPoint v = CGPointMake(p2.x-p1.x,p2.y-p1.y);
   
    float vmag = sqrt(SQR(v.x) + SQR(v.y)), result = 0;
 
    v.x /= vmag;
  
    v.y /= vmag;
 
    double radians = atan2(v.y,v.x);
    
    result = ToDeg(radians);
  
    return (result >=0  ? result : result + 360.0);
}

@end
