//
//  MiGradientCircleController.m
//  Mi-BB
//
//  Created by YuanMiaoHeng on 16/4/22.
//  Copyright © 2016年 Mi. All rights reserved.
//

#import "RoundView.h"
#import "RoundView2.h"
#import "MiGradientCircleController.h"

@interface MiGradientCircleController ()
@property(nonatomic,assign) CGFloat percent;
@property(nonatomic,weak) CAShapeLayer *shapeLayer2;
@property(nonatomic,weak) NSTimer *timer;
@end

@implementation MiGradientCircleController


- (void)sliderValueChanged:(UISlider *)sender {
    
    //    self.percent = sender.value;
    
    self.shapeLayer2.strokeEnd = 1.0f - sender.value/ 100.0f  ;
    
    
    
    
    //    self.shapeLayer2.strokeEnd =  sender.value / 100.0f ;
    //
    //    NSLog(@"%f",  self.shapeLayer2.strokeEnd  );
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //    RoundView *roundView = [[RoundView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    //    [self.view addSubview:roundView];
    //    roundView.trackColor = [UIColor blackColor];
    //    roundView.progressColor = [UIColor orangeColor];
    //    roundView.progress = .7;
    //    roundView.progressWidth = 10;
    //    self.view.backgroundColor = [UIColor purpleColor];
    
    //    RoundView2 *r = [[RoundView2 alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    //    [self.view addSubview:r];
    //    r.backgroundColor = [UIColor clearColor];
    //    [r.layer addSublayer:[self creatShaper]];
    //    r.layer.cornerRadius = 100;
    //    r.clipsToBounds = YES;
    
    //
    //
    //  CAShapeLayer *shapeLayer =  [self creatShaper];
    //    [self.view.layer addSublayer:shapeLayer];
    //
    //
    //   [shapeLayer addSublayer:[self gradientLayerWithView:shapeLayer]];
    //
    
    UIView  *aView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    [self.view addSubview:aView];
    aView.backgroundColor = [UIColor yellowColor];
    aView.layer.cornerRadius = 100;
    aView.clipsToBounds = YES;
    
    CALayer *gradientLayer = [self gradientLayerWithView:aView];
    CAShapeLayer *shaperLayer = [self creatShaperWithView:aView];
    CAShapeLayer *shaperLayer2 = [self creatShaperWithView2:aView];
    [aView.layer addSublayer:gradientLayer];
    [aView.layer addSublayer:shaperLayer];
    [aView.layer addSublayer:shaperLayer2];
    
    UIButton *btn = [UIButton buttonWithType:0];
    [aView addSubview:btn];
    btn.frame = CGRectMake((200 - 30) * 0.5, (200 - 30) * 0.5, 30, 30);
    //    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(go:) forControlEvents:(UIControlEventTouchUpInside)];
    //    [aView.layer insertSublayer:gradientLayer atIndex:0];
    //    [aView.layer insertSublayer:shaperLayer atIndex:0];
    [btn.layer addSublayer:[self gradientLayerWithView:btn]];
    btn.showsTouchWhenHighlighted = YES;
    btn.layer.cornerRadius = 3;
    btn.clipsToBounds = YES;
    
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake((ScreenWidth - 200) * 0.5 , CGRectGetMaxY(aView.frame) + 100, 200, 50)];
    [self.view addSubview:slider];
    slider.minimumTrackTintColor = [UIColor robinEggColor];
    slider.maximumTrackTintColor = MiColorRGBA(170, 251, 93, 1);
    slider.maximumValue = 100.0f;
    slider.minimumValue = 0.0f;
    [slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:(UIControlEventValueChanged)];
    
}

- (void)go:(UIButton *)btn
{
    if (_timer == nil) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timerUpdate:) userInfo:nil repeats:YES];
    }
}

- (void)timerUpdate:(NSTimer *)timer
{
    //    NSLog(@"%f", self.shapeLayer2.strokeEnd );
    
    if (self.shapeLayer2.strokeEnd <= 0.0f) {
        [_timer invalidate];
        _timer = nil;
        return;
    }
    self.shapeLayer2.strokeEnd -= 0.01;
    
    
}

- (CALayer *)gradientLayerWithButton:(UIButton *)view
{
    NSArray *colors0 = @[(__bridge id)MiColorRGBA(255, 125, 8, 0.6).CGColor ,(__bridge id)MiColorRGBA(240, 110, 180, 0.55).CGColor,(__bridge id)MiColorRGBA(10, 200, 220, 0.4).CGColor,(__bridge id)MiColorRGBA(193, 255, 130, 0.7).CGColor,(__bridge id)MiColorRGBA(205, 0, 205, 0.8).CGColor,(__bridge id)MiColorRGBA(255, 25, 25, 0.8).CGColor];
    
    CALayer *gradientLayer = [CALayer layer];
    //    self.gradientLayer = gradientLayer;
    CAGradientLayer *gradientLayer1 =  [CAGradientLayer layer];
    //    [gradientLayer1 setLocations:@[@0.1,@0.5,@1]];
    gradientLayer1.frame = view.bounds;
    [gradientLayer1 setColors:colors0];
    [gradientLayer1 setStartPoint:CGPointMake(0.5, 0)];
    [gradientLayer1 setEndPoint:CGPointMake(0.9, 1)];
    [gradientLayer addSublayer:gradientLayer1];
    //    gradientLayer1.cornerRadius = 100 ;
    //    gradientLayer1.masksToBounds = YES;
    
    return gradientLayer;
}


- (CALayer *)gradientLayerWithView:(UIView *)view
{
    NSArray *colors0 = @[(__bridge id)MiColorRGBA(255, 125, 8, 0.6).CGColor ,(__bridge id)MiColorRGBA(240, 110, 180, 0.55).CGColor,(__bridge id)MiColorRGBA(10, 200, 220, 0.4).CGColor,(__bridge id)MiColorRGBA(193, 255, 130, 0.7).CGColor,(__bridge id)MiColorRGBA(205, 0, 205, 0.8).CGColor,(__bridge id)MiColorRGBA(255, 25, 25, 0.8).CGColor];
    
    CALayer *gradientLayer = [CALayer layer];
    //    self.gradientLayer = gradientLayer;
    CAGradientLayer *gradientLayer1 =  [CAGradientLayer layer];
    //    [gradientLayer1 setLocations:@[@0.1,@0.5,@1]];
    gradientLayer1.frame = view.bounds;
    [gradientLayer1 setColors:colors0];
    [gradientLayer1 setStartPoint:CGPointMake(0.5, 0)];
    [gradientLayer1 setEndPoint:CGPointMake(0.5, 1)];
    [gradientLayer addSublayer:gradientLayer1];
    //    gradientLayer1.cornerRadius = 100 ;
    //    gradientLayer1.masksToBounds = YES;
    
    return gradientLayer;
}

- (void)setPercent:(CGFloat)percent
{
    _percent = percent;
    
}

- (CAShapeLayer *)creatShaperWithView:(UIView *)view
{
    // 创建
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
    shapeLayer.lineWidth = 5;
    shapeLayer.frame = CGRectMake(0, 0, view.bounds.size.width -shapeLayer.lineWidth , view.bounds.size.height -shapeLayer.lineWidth );
    shapeLayer.fillColor = [UIColor whiteColor].CGColor;
    shapeLayer.strokeColor = [UIColor clearColor].CGColor;
    
    shapeLayer.lineCap = kCALineCapRound;
    
    // 路径
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(view.bounds.size.width / 2, view.bounds.size.height / 2) radius:100 - shapeLayer.lineWidth -3  startAngle:- M_PI_2 endAngle:1.5 * M_PI  clockwise:YES];
    shapeLayer.path = path.CGPath;
    //    shapeLayer.strokeStart = 0.0;
    //    shapeLayer.strokeEnd = 0.5;
    return shapeLayer;
}


- (CAShapeLayer *)creatShaperWithView2:(UIView *)view
{
    // 创建
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
    shapeLayer.lineWidth = 9;
    shapeLayer.frame = CGRectMake(0, 0, view.bounds.size.width -shapeLayer.lineWidth , view.bounds.size.height -shapeLayer.lineWidth );
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.strokeColor = [UIColor whiteColor].CGColor;
    shapeLayer.lineCap = kCALineCapButt;
    self.shapeLayer2 = shapeLayer;
    shapeLayer.strokeStart = 0.0f;
    shapeLayer.strokeEnd = 1.0f;
    // 路径
    //    CGFloat endAngle = _percent * M_PI * 2 - M_PI_2;
    
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(view.bounds.size.width / 2, view.bounds.size.height / 2) radius:100 - shapeLayer.lineWidth +5 startAngle:- M_PI_2 endAngle:- 2.5 *M_PI     clockwise:NO];
    shapeLayer.path = path.CGPath;
    
    
    return shapeLayer;
}


@end
