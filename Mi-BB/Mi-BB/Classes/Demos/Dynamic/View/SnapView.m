//
//  SnapView.m
//  02.UIDynamic演练
//
//  Created by apple on 13-12-24.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "SnapView.h"

@implementation SnapView

//- (instancetype)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        self.box.image = [UIImage imageNamed:@"icon2"];
//
//    }
//    return self;
//}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 把此前的行为清除掉
    [self.animator removeAllBehaviors];

    UITouch *touch = touches.anyObject;
    CGPoint location = [touch locationInView:self];
    
    // 吸附小方块
//    self.box.center = location;
    // 定义行为
    UISnapBehavior *snap = [[UISnapBehavior alloc] initWithItem:self.box snapToPoint:location];
    
    // 振幅，0 狂震 1 轻震
    snap.damping = arc4random_uniform(5) / 10 + 0.3;
    
    // 把行为添加到仿真者中
    [self.animator addBehavior:snap];
}

@end
