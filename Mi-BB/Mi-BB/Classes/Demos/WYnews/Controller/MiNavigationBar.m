//
//  MiNavigationBar.m
//  Mi网易新闻
//
//  Created by YuanMiaoHeng on 15/11/14.
//  Copyright © 2015年 LianJiang. All rights reserved.
//

#import "MiNavigationBar.h"

@implementation MiNavigationBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    for (UIButton *btn in self.subviews) {
        
        if (btn.centerX < self.width * 0.5) { // 左边
            btn.x = 0;
        }
        else if (btn.centerX > self.width * 0.5)
        {
            btn.x = self.width - btn.width;
        }
        
//        NSLog(@"subView:%@",self.subviews);
    }
}

@end
