//
//  UIView+BluerEffect.m
//  Esc_iOS8毛玻璃模糊
//
//  Created by YuanMiaoHeng on 15/9/8.
//  Copyright (c) 2015年 LianJiang. All rights reserved.
//

#import "UIView+BluerEffect.h"

@implementation UIView (BluerEffect)

- (void)BluerEffect
{
    
    // 毛玻璃效果，只要把UIVisualEffectView对象加进imgView中即可
//    UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
//    UIImage *img = [UIImage imageNamed:@"06.jpg"];
//    imgView.image = img;
//    [self.view addSubview:imgView];
    
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    effectView.alpha = 0.9;
    effectView.frame = self.bounds;//CGRectMake(0, 0, self.view.frame.size.width, 200);
    [self addSubview:effectView];
}


- (void) BluerEffectWithAlph:(CGFloat)alph
{
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    effectView.alpha = alph;
    effectView.frame = self.bounds;
    [self addSubview:effectView];
}
@end
