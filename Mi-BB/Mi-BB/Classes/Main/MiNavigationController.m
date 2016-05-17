//
//  MiNavigationController.m
//  Mi-BB
//
//  Created by YuanMiaoHeng on 16/4/19.
//  Copyright © 2016年 Mi. All rights reserved.
//

#import "MiNavigationController.h"

@implementation MiNavigationController

+ (void)initialize
{
    //设置背景图片
    UINavigationBar *bar = [UINavigationBar appearance];
    [bar setBackgroundImage:[UIImage  imageWithColor:[UIColor peachColor]] forBarMetrics:UIBarMetricsDefault];
    
    //设置标题格式
    NSDictionary *titleDic = @{NSFontAttributeName : [UIFont systemFontOfSize:18],NSForegroundColorAttributeName : [UIColor yellowGreenColor]};
    [bar setTitleTextAttributes:titleDic];
    
//    [bar setBackIndicatorImage:[UIImage imageNamed:@"miNav"]];
//    [bar setTintColor:[UIColor raspberryColor]];
    
}


#pragma mark - 拦截导航控制器push进来的所有子控制器
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.childViewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[UIButton buttonWithTarget:self selector:@selector(goBack) title:nil image:@"backArrow" highLightImage:nil]];
        viewController.edgesForExtendedLayout = UIRectEdgeNone;//起始点从00开始
    }
    [super pushViewController:viewController animated:animated];
}

- (void)goBack {
    [self popViewControllerAnimated:YES];
}

@end
