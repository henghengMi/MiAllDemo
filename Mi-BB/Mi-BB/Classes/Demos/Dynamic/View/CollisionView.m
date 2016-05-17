//
//  CollisionView.m
//  02.UIDynamic演练
//
//  Created by apple on 13-12-24.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "CollisionView.h"

@interface CollisionView() <UICollisionBehaviorDelegate>

@end

@implementation CollisionView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(0, 300, 150, 20)];
        redView.backgroundColor = [UIColor redColor];
        [self addSubview:redView];
        
//        UIView *blueView = [[UIView alloc] initWithFrame:CGRectMake(110, 120, 100, 100)];
//        blueView.backgroundColor = [UIColor blueColor];

        UIImageView *headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(110, 120, 100, 100)];
        headImgView.image = [UIImage imageNamed:@"icon1"];
        headImgView.contentMode = UIViewContentModeScaleAspectFit;
        headImgView.clipsToBounds = YES;
        headImgView.layer.cornerRadius = 50;
        [self addSubview:headImgView];
        
        // 增加碰撞检测
        UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems:@[headImgView]];
        collision.translatesReferenceBoundsIntoBoundary = YES;
        
        // Boundary是即参与碰撞，又不会发生位移的静态物体的边界
        CGFloat toX = redView.frame.size.width;
        CGFloat toY = redView.frame.origin.y + redView.frame.size.height;
        
        [collision addBoundaryWithIdentifier:@"lalala" fromPoint:redView.frame.origin toPoint:CGPointMake(toX, toY)];
        
        // 设置碰撞行为的代理
        collision.collisionDelegate = self;
        
        [self.animator addBehavior:collision];
        
        // 重力
        UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:@[headImgView]];
        [self.animator addBehavior:gravity];
        
        // 物体属性行为
        UIDynamicItemBehavior *item = [[UIDynamicItemBehavior alloc] initWithItems:@[headImgView]];
        
        // 弹力系数，0~1，0是最不弹，1是最弹
        item.elasticity = 0.8;
        
        [self.animator addBehavior:item];
        
        // 此方法可以用于碰撞实际情况的跟踪
//        collision.action = ^ {
//            NSLog(@"%@", NSStringFromCGRect(self.box.frame));
//        };
    }
    
    return self;
}

#pragma mark - 碰撞的代理方法
- (void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier atPoint:(CGPoint)p
{
    NSLog(@"%@", identifier);
    NSString *ID = [NSString stringWithFormat:@"%@", identifier];
    UIView *blue = (UIView *)item;
    
    // 根板子相撞，变换颜色
    if ([ID isEqualToString:@"lalala"]) {
        blue.backgroundColor = [UIColor greenColor];
        
        // 结束后恢复颜色
        [UIView animateWithDuration:0.3f animations:^{
            blue.backgroundColor = [UIColor blueColor];
        }];
    }
}

@end
