//
//  DemoView.m
//  02.UIDynamic演练
//
//  Created by apple on 13-12-24.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "DemoView.h"

@implementation DemoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        // 1. 背景图片
        UIImage *bgImage = [UIImage imageNamed:@"BackgroundTile"];
        self.backgroundColor = [UIColor colorWithPatternImage:bgImage];
        
        // 2. 小方块
        UIImage *image = [UIImage imageNamed:@"icon2"];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.center = CGPointMake(self.center.x, 120);
        imageView.width = 100;
        imageView.height = 100;
        imageView.clipsToBounds = YES;
        imageView.layer.cornerRadius = 50;
        [self addSubview:imageView];
        
        self.box = imageView;
        
        // 3. 仿真者
        UIDynamicAnimator *animator = [[UIDynamicAnimator alloc] initWithReferenceView:self];
        _animator = animator;
    }
    
    return self;
}

@end
