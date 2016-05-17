//
//  MiAccelerometerController.m
//  Mi-BB
//
//  Created by YuanMiaoHeng on 16/4/23.
//  Copyright © 2016年 Mi. All rights reserved.
//

#import "MiAccelerometerController.h"

@interface MiAccelerometerController ()<UIAccelerometerDelegate,UICollisionBehaviorDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *imgView1;
@property (strong, nonatomic) IBOutlet UIImageView *imgView2;
@property (strong, nonatomic) IBOutlet UIImageView *imgView3;

@property (assign, nonatomic)  CGPoint velocity1;
@property (assign, nonatomic)  CGPoint velocity2;
@property (assign, nonatomic)  CGPoint velocity3;
@end

@implementation MiAccelerometerController


- (UIImageView *)imgView1
{
    if (_imgView1 == nil) {
        _imgView1 = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 120, 120)];
        _imgView1.contentMode = UIViewContentModeScaleAspectFill;
        _imgView1.clipsToBounds = YES;
        [self.view addSubview:_imgView1];
        _imgView1.image = IMAGE(@"icon1");
        _imgView1.userInteractionEnabled = YES;
    }
    return _imgView1;
}

- (UIImageView *)imgView2
{
    if (_imgView2 == nil) {
        _imgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(20, 150, 120, 120)];
        _imgView2.contentMode = UIViewContentModeScaleAspectFill;
        [self.view addSubview:_imgView2];
        _imgView2.clipsToBounds = YES;

         _imgView2.image = IMAGE(@"icon2");
        _imgView2.userInteractionEnabled = YES;
    }
    return _imgView2;
}

- (UIImageView *)imgView3
{
    if (_imgView3 == nil) {
        _imgView3 = [[UIImageView alloc] initWithFrame:CGRectMake(120, 80, 120, 120)];
        _imgView3.contentMode = UIViewContentModeScaleAspectFill;
        [self.view addSubview:_imgView3];
        _imgView3.clipsToBounds = YES;
        
        _imgView3.image = IMAGE(@"icon3");
        _imgView3.userInteractionEnabled = YES;
    }
    return _imgView3;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imgView1.clipsToBounds = YES;
    self.imgView1.layer.cornerRadius = 60;
    self.imgView2.clipsToBounds = YES;
    self.imgView2.layer.cornerRadius = 60;
    self.imgView3.clipsToBounds = YES;
    self.imgView3.layer.cornerRadius = 60;
    // 设置加速计
    UIAccelerometer *accele = [UIAccelerometer sharedAccelerometer];
    accele.delegate = self;
    // 采样间隔（每隔多少秒采样一次）
    accele.updateInterval = 1/ 30.0; // 1秒采集30次
}



- (void)setupAccelerometerWithView:(UIView *)view accelerate:(UIAcceleration *)acceleration velocity:(CGPoint)velocity
{
    // 1.累加速度 = 加速度
    velocity.x += acceleration.x;
    velocity.y -= acceleration.y;
    
    // 2. 累加位移
    self.view.x += velocity.x  ;
    self.view.y += velocity.y  ;
    
    if (self.view.x <= 0) {
        self.view.x = 0;
        velocity.x *=  - 0.5;
    }
    
    if (self.view.MaxX >= self.view.width) {
        self.view.MaxX = self.view.width;
        velocity.x *=  - 0.5;
    }
    
    
    if (self.view.y <= 0) {
        self.view.y = 0;
        velocity.y *=  - 0.5;
    }
    
    if (self.view.MaxY >= self.view.height) {
        self.view.MaxY = self.view.height;
        velocity.y *=  - 0.5;
    }
}

- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration
{
    // 1.累加速度 = 加速度
    _velocity1.x += acceleration.x;
    _velocity1.y -= acceleration.y;
    
    // 2. 累加位移
    self.imgView1.x += _velocity1.x  ;
    self.imgView1.y += _velocity1.y  ;
    
    if (self.imgView1.x <= 0) {
        self.imgView1.x = 0;
        _velocity1.x *=  - 0.5;
    }
    
    if (self.imgView1.MaxX >= self.view.width) {
        self.imgView1.MaxX = self.view.width;
        _velocity1.x *=  - 0.5;
    }
    
    if (self.imgView1.y <= 0) {
        self.imgView1.y = 0;
        _velocity1.y *=  - 0.5;
    }
    
    if (self.imgView1.MaxY >= self.view.height) {
        self.imgView1.MaxY = self.view.height;
        _velocity1.y *=  - 0.5;
    }
    
    // 1.累加速度 = 加速度
    _velocity2.x += acceleration.x;
    _velocity2.y -= acceleration.y;
    
    // 2. 累加位移
    self.imgView2.x += _velocity2.x  ;
    self.imgView2.y += _velocity2.y  ;
    
    if (self.imgView2.x <= 0) {
        self.imgView2.x = 0;
        _velocity2.x *=  - 0.7;
    }
    
    if (self.imgView2.MaxX >= self.view.width) {
        self.imgView2.MaxX = self.view.width;
        _velocity2.x *=  - 0.7;
    }
    
    
    if (self.imgView2.y <= 0) {
        self.imgView2.y = 0;
        _velocity2.y *=  - 0.7;
    }
    
    if (self.imgView2.MaxY >= self.view.height) {
        self.imgView2.MaxY = self.view.height;
        _velocity2.y *=  - 0.7;
    }

    // 1.累加速度 = 加速度
    _velocity3.x += acceleration.x;
    _velocity3.y -= acceleration.y;
    
    // 2. 累加位移
    self.imgView3.x += _velocity3.x  ;
    self.imgView3.y += _velocity3.y  ;
    
    if (self.imgView3.x <= 0) {
        self.imgView3.x = 0;
        _velocity3.x *=  - 1.0;
    }
    
    if (self.imgView3.MaxX >= self.view.width) {
        self.imgView3.MaxX = self.view.width;
        _velocity3.x *=  - 1.0;
    }
    
    if (self.imgView3.y <= 0) {
        self.imgView3.y = 0;
        _velocity3.y *=  - 1.0;
    }
    
    if (self.imgView3.MaxY >= self.view.height) {
        self.imgView3.MaxY = self.view.height;
        _velocity3.y *=  - 1.0;
    }

    
}

@end
