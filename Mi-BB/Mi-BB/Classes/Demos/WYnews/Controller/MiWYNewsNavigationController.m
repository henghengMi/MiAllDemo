//
//  MiNavigationController.m
//  Mi网易新闻
//
//  Created by YuanMiaoHeng on 15/11/13.
//  Copyright © 2015年 LianJiang. All rights reserved.
//

#import "MiWYNewsNavigationController.h"
#import "MiNavigationBar.h"
@implementation MiWYNewsNavigationController


+ (void)initialize
{
    UINavigationBar *bar = [UINavigationBar appearance];
    // 设置导航栏背景
    [bar setBackgroundImage:[UIImage imageNamed:@"top_navigation_background"] forBarMetrics:UIBarMetricsDefault];
}
    
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setValue:[[MiNavigationBar alloc] init] forKey:@"navigationBar"];
    
}

@end
