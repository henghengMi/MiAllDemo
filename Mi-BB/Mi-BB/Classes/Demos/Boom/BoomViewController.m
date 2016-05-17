
//
//  BoomViewController.m
//  Mi-BB
//
//  Created by YuanMiaoHeng on 16/4/19.
//  Copyright © 2016年 Mi. All rights reserved.
//

#import "BoomViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "UIView+Animation.h"
#import "UIView+BluerEffect.h"

@interface BoomViewController ()<UICollisionBehaviorDelegate,UIAccelerometerDelegate>
{
    CGPoint _startPoint;
}
@property(nonatomic,strong)CAEmitterLayer *emitter;
@property(nonatomic,strong)CAEmitterLayer *bigEmitter;
@property (strong, nonatomic)  UIImageView *bgView;
@property(strong , nonatomic) NSMutableArray *views;
@property(strong , nonatomic) UIDynamicAnimator *dynamic;
@property(strong , nonatomic) UIView * aView;

@property (assign, nonatomic)  CGPoint velocity;

@end

@interface BoomViewController ()

@end

@implementation BoomViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}



- (UIView *)aView
{
    if (!_aView) {
        _aView = [[UIView alloc] init];
        _aView.frame = self.view.bounds; //CGRectMake(100, 100, 200, 200);
        [self.view addSubview:_aView];
//        _aView.backgroundColor = [UIColor redColor];
    }
    return _aView;
}

- (UIImageView *)bgView
{
    if (_bgView == nil) {
        _bgView = [[UIImageView alloc] init];
    }
    return _bgView;
}

- (NSMutableArray *)views
{
    if (_views == nil) {
        _views = [NSMutableArray array];
    }
    return _views;
}

- (UIDynamicAnimator *)dynamic
{
    if (_dynamic == nil) {
        
        self.dynamic = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
        
    }
    return _dynamic;
}

- (void)acceleHanddleWithView:(UIView *)view didAccelerate:(UIAcceleration *)acceleration
{
    // 1.累加速度 = 加速度
    _velocity.x += acceleration.x;
    _velocity.y -= acceleration.y;
    
    // 2. 累加位移
    self.view.x += _velocity.x  ;
    self.view.y += _velocity.y  ;
    
    if (self.view.x <= 0) {
        self.view.x = 0;
        _velocity.x *=  - 0.5;
    }
    
    if (self.view.MaxX >= self.view.width) {
        self.view.MaxX = self.view.width;
        _velocity.x *=  - 0.5;
    }
    
    
    if (self.view.y <= 0) {
        self.view.y = 0;
        _velocity.y *=  - 0.5;
    }
    
    if (self.view.MaxY >= self.view.height) {
        self.view.MaxY = self.view.height;
        _velocity.y *=  - 0.5;
    }
}

- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration
{
    for (int i = 0; i < self.views.count; i ++) {
        UIView *view = self.views[i];
        [self acceleHanddleWithView:view didAccelerate:acceleration];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = YES;
    self.bgView.contentMode = UIViewContentModeScaleAspectFill;
    self.bgView.clipsToBounds = YES;
    _bgView.frame = self.view.bounds;
    self.bgView.userInteractionEnabled = YES;
    self.bgView.image = [UIImage imageByBundleWithImageName:@"dzs2.jpg"];
    
    [self.view addSubview:_bgView];
    [self.bgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)]];
    
//    [self setupEmitterOne];
    
    [self setupRoundView];
    
    [self setupUIAccelerometer];
}

- (void)setupUIAccelerometer
{
    UIAccelerometer *accele = [UIAccelerometer sharedAccelerometer];
    accele.delegate = self;
    accele.updateInterval = 1/ 30.0; // 1秒采集30次
}

#pragma mark 设置圆圈View
-(void)setupRoundView
{
    int roundNum = arc4random_uniform(5) + 2;
    
    for (int i = 0; i < roundNum; i ++) {
        CGFloat viewHW = arc4random_uniform(100) + 40;
        UIView * roundView = [[UIView alloc] init];
        roundView.frame = CGRectMake(arc4random_uniform(self.view.bounds.size.width - 50) , arc4random_uniform(self.view.bounds.size.height - viewHW * 0.5), viewHW,viewHW);
        [self.view addSubview:roundView];
        roundView.layer.cornerRadius = viewHW * 0.5;
        roundView.clipsToBounds = YES;
        [self setupEmitterLayerMoreWithView:roundView];
        [self.views addObject:roundView];
    }
}

#pragma mark 单击屏幕
- (void)tap:(UITapGestureRecognizer *)tap
{
    //    CGPoint location = [tap locationInView:self.bgView];
    ////    self.aView.transform = CGAffineTransformMakeScale(2.0, 2.0);
    //
    NSArray *angles = @[@(M_PI * 2),@(2 /3 *M_PI  ),@(2 /2 *M_PI),@( M_PI_2),@(M_PI_4),@(M_PI_4 * 3/1)];
    //    NSUInteger  i2 = arc4random_uniform(angles.count);
    //    CGFloat angle = [angles[i] floatValue];
    //    CGFloat angle2 = [angles[i2] floatValue];
    
    for (int i = 0; i < self.views.count; i++) {
        
        NSUInteger  randomAngle = arc4random_uniform(angles.count);
        NSLog(@"randomAngle%d",randomAngle);
        
        CGFloat angle = [angles[randomAngle] floatValue];
        if (i % 2 == 0 ) {
            angle = - angle;
        }
        NSLog(@"%f",angle);
        // 2. 实例化推行为，单此推动
        UIPushBehavior * push = [[UIPushBehavior alloc] initWithItems:@[self.views[i]] mode:UIPushBehaviorModeInstantaneous];
        push.angle = angle;
        // 力量的大小
        push.magnitude = arc4random_uniform(30);
        // 对于单次推动，一定要设置成YES，才能够发力
        push.active = YES;
        [self.dynamic addBehavior:push];
    }
    
    // 碰撞
    UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems:self.views];
    collision.collisionDelegate = self;
    collision.translatesReferenceBoundsIntoBoundary = YES;
    [self.dynamic addBehavior:collision];
}

//- (void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier atPoint:(CGPoint)p
//{
//    NSLog(@"碰");
//}
//
//- (void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item1 withItem:(id<UIDynamicItem>)item2 atPoint:(CGPoint)p
//{
//    NSLog(@"碰");
//
//}

//- (void)collisionBehavior:(UICollisionBehavior *)behavior endedContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier
//{
//     NSLog(@"碰");
//}

#pragma mark 碰撞代理
- (void)collisionBehavior:(UICollisionBehavior *)behavior endedContactForItem:(id<UIDynamicItem>)item1 withItem:(id<UIDynamicItem>)item2
{
    //    NSLog(@"碰");
    UIView *itemOne = (UIView *)item1;
    UIView *itemOther = (UIView *)item2;
    
    // 大小缩放
    
    CGFloat scale = arc4random_uniform(5) * 0.1f;
    int  a =  arc4random_uniform(2);
    if (a == 0) {
        scale = - scale;
    }
    NSArray *values = @[@(1+scale),@(1),@(1 + scale)];
    [itemOne zoomWithDuration:0.15 values:values];
    
    
    CGFloat scale2 = arc4random_uniform(5) * 0.1f;
    if (a == 0) {
        scale2 = - scale2;
    }
    NSArray *values2 = @[@(1+scale2),@(1),@(1+scale2)];
    [itemOther zoomWithDuration:3 values:values2];
    
    
    // 移除发射 创建新的
    for (int i = 0; i < itemOne.layer.sublayers.count; i ++) {
        if([itemOne.layer.sublayers[i] isKindOfClass:[CAEmitterLayer class]])
        {
            [itemOne.layer.sublayers[i] removeFromSuperlayer];
            [self setupEmitterLayerMoreWithView:itemOne];
        }
        
        if([itemOther.layer.sublayers[i] isKindOfClass:[CAEmitterLayer class]])
        {
            [itemOther.layer.sublayers[i] removeFromSuperlayer];
            [self setupEmitterLayerMoreWithView:itemOther];
        }
        
        
    }
    //    [itemOne.la];
    
}

- (void)pan:(UIPanGestureRecognizer *)pan
{
    [self.dynamic removeAllBehaviors];
    
    
    CGPoint point = [pan translationInView:self.view];
    CGFloat distance;
    
    if (pan.state == UIGestureRecognizerStateBegan) // 开始
    {
        _startPoint = point;
    }
    else if (pan.state == UIGestureRecognizerStateChanged) {
        //        [self.dynamic addBehavior:gravity];
        //
        ////        //  滑动的方向
        //        CGPoint endPoint = point;
        //        CGPoint offset = CGPointMake(_startPoint.x - endPoint.x, _startPoint.y - endPoint.y);
        //        distance = sqrtf(offset.x * offset.x + offset.y * offset.y); // 距离
        ////        CGFloat angle = atan2f(offset.y, offset.x); // 滑动的方向
        pan.view.transform = CGAffineTransformTranslate(pan.view.transform, point.x, point.y);
        [pan setTranslation:CGPointZero inView:pan.view];
        
        
    }
    
    else if (pan.state == UIGestureRecognizerStateEnded)
    {
        
        
    }
    
}


- (void)setupEmitterLayerMoreWithView:(UIView *)view;
{
    
    CAEmitterLayer *emitter = [CAEmitterLayer layer];
    emitter.frame = view.bounds;
    [view.layer addSublayer:emitter];
    //    emitter.masksToBounds = YES;
    // 渲染模式
    emitter.renderMode = kCAEmitterLayerAdditive;
    // 发射起点
    emitter.emitterPosition = CGPointMake(view.bounds.size.width * 0.5 , view.bounds.size.width * 0.5  );
    self.bigEmitter = emitter;
    
    // cell
    NSMutableArray *cells = [NSMutableArray array];
    NSArray *colors = @[MiRandomColor,MiRandomColor,MiRandomColor,MiRandomColor,MiRandomColor,MiRandomColor,MiRandomColor];
    // 粒子发射器
    for (int i = 0; i < colors.count; i++) {
        CAEmitterCell *cell = [[CAEmitterCell alloc] init];
        // 粒子图片
        cell.contents = (__bridge id)[UIImage imageNamed:@"lizi"].CGImage;
        // 粒子个数
        cell.birthRate = arc4random_uniform(200) + 100;
        // 粒子速度
        cell.velocity = arc4random_uniform(30);
        // 粒子范围
        cell.velocityRange = 50;
        //  粒子生命周期
        cell.lifetime = arc4random_uniform(10);
        // 颜色
        UIColor *color = colors[i];
        cell.color = color.CGColor ;
        // 粒子透明度在生命周期内的改变速度
        cell.alphaSpeed = -0.2;
        // 粒子发射角度
        cell.emissionRange = 2 * M_PI;//[angles[arc4random_uniform(1)] floatValue];
        // 粒子x/y/z方向的加速度分量
        cell.xAcceleration = 0;
        cell.yAcceleration = 0;
        cell.zAcceleration = 0;
        // 缩放比例：
        cell.scale = 1.0 + arc4random_uniform(11) * 0.1f;
        // 子旋转角度
        //        cell.spin = M_PI_2;
        // 子旋转角度范围
        //        cell.spinRange = 0.5;
        //  指定cell
        [cells addObject:cell];
    }
    
    // emitter 和 cell 产生关联
    emitter.emitterCells = cells;
}

 - (void)setupEmitterOne
 {
 
     CAEmitterLayer *emitter = [CAEmitterLayer layer];
     emitter.frame = self.bgView.bounds;
     [self.bgView.layer addSublayer:emitter];
//     emitter.masksToBounds = YES;
//     emitter.cornerRadius = 20;
     // 渲染模式
     emitter.renderMode = kCAEmitterLayerAdditive;
     // 发射起点
     emitter.emitterPosition = CGPointMake(self.aView.bounds.size.width * 0.5 ,300);
     self.emitter = emitter;
     emitter.emitterDepth = 100;
     
     // cell
     NSMutableArray *cells = [NSMutableArray array];
     // 粒子发射器
     CAEmitterCell *cell = [[CAEmitterCell alloc] init];
     // 粒子图片
     cell.contents = (__bridge id)[UIImage imageNamed:@"lizi"].CGImage;
     // 粒子个数
     cell.birthRate = 5000;
     // 粒子速度
     cell.velocity =  5;//arc4random_uniform(50);
     // 粒子范围
     cell.velocityRange = 500;
     //  粒子生命周期
     cell.lifetime = 10;
     // 颜色
     UIColor *color = MiRandomColorRGBA;
     cell.color = color.CGColor ;
     // 粒子透明度在生命周期内的改变速度
     cell.alphaSpeed = -0.1;
     
     // 粒子发射角度
     cell.emissionRange = M_PI;//[angles[arc4random_uniform(1)] floatValue];
     // 粒子x/y/z方向的加速度分量
     cell.xAcceleration = 0;
     cell.yAcceleration = 20;
     
     cell.zAcceleration = 0;
     // 缩放比例：
     cell.scale = 1.0;
     
     // 子旋转角度
     //        cell.spin = M_PI_2;
     // 子旋转角度范围
     //        cell.spinRange = 0.5;
     //  指定cell
     [cells addObject:cell];
     
     // emitter 和 cell 产生关联
     emitter.emitterCells = @[cell];
 }
 
 





/**
 birthRate:粒子产生系数，默认1.0；
 
 emitterCells: 装着CAEmitterCell对象的数组，被用于把粒子投放到layer上；
 
 emitterDepth:决定粒子形状的深度联系：emitter shape
 
 emitterZposition:发射源的z坐标位置；
 
 lifetime:粒子生命周期
 
 preservesDepth:不是多很清楚（粒子是平展在层上）
 
 
 scale:粒子的缩放比例：
 
 seed：用于初始化随机数产生的种子
 
 spin:自旋转速度
 
 velocity：粒子速度
 
 CAEmitterCell
 
 
 CAEmitterCell类代从从CAEmitterLayer射出的粒子；emitter cell定义了粒子发射的方向。
 
 alphaRange:  一个粒子的颜色alpha能改变的范围；
 
 alphaSpeed:粒子透明度在生命周期内的改变速度；
 
 birthrate：粒子参数的速度乘数因子；每秒发射的粒子数量
 
 blueRange：一个粒子的颜色blue 能改变的范围；
 
 blueSpeed: 粒子blue在生命周期内的改变速度；
 
 color:粒子的颜色
 
 contents：是个CGImageRef的对象,既粒子要展现的图片；
 
 contentsRect：应该画在contents里的子rectangle：
 
 emissionLatitude：发射的z轴方向的角度
 
 emissionLongitude:x-y平面的发射方向
 
 emissionRange；周围发射角度
 
 emitterCells：粒子发射的粒子
 
 enabled：粒子是否被渲染
 
 greenrange: 一个粒子的颜色green 能改变的范围；
 
 greenSpeed: 粒子green在生命周期内的改变速度；
 
 lifetime：生命周期
 
 lifetimeRange：生命周期范围      lifetime= lifetime(+/-) lifetimeRange
 
 magnificationFilter：不是很清楚好像增加自己的大小
 
 minificatonFilter：减小自己的大小
 
 minificationFilterBias：减小大小的因子
 
 name：粒子的名字
 
 redRange：一个粒子的颜色red 能改变的范围；
 
 redSpeed; 粒子red在生命周期内的改变速度；
 
 scale：缩放比例：
 
 scaleRange：缩放比例范围；
 
 scaleSpeed：缩放比例速度：
 
 spin：子旋转角度
 
 spinrange：子旋转角度范围
 
 style：不是很清楚：
 
 velocity：速度
 
 velocityRange：速度范围
 
 xAcceleration:粒子x方向的加速度分量
 
 yAcceleration:粒子y方向的加速度分量
 
 zAcceleration:粒子z方向的加速度分量
 */


@end
