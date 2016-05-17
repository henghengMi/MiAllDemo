//
//  MiWYNewsHomeController.m
//  Mi-BB
//
//  Created by YuanMiaoHeng on 16/4/23.
//  Copyright © 2016年 Mi. All rights reserved.
//

#import "MiWYNewsHomeController.h"
#import "LeftMenueView.h"
#import "NewsController.h"
#import "MiWYNewsNavigationController.h"
#import "ReadingController.h"
#import "TitleButton.h"
#import "RightMenueView.h"
#import "UIBarButtonItem+BarImgButton.h"
#define kCoverTag 50000
#define kAnimationDuration 0.25f

@interface MiWYNewsHomeController ()<LeftMenueViewDelegate>
@property(nonatomic,weak)UIViewController *showViewController;
@property(nonatomic,weak)LeftMenueView *leftMenu;
@property(nonatomic,weak)RightMenueView *rightMenu;
@end

@implementation MiWYNewsHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupBgView];
    self.view.backgroundColor = [UIColor redColor];
    
    NewsController *newsvc = [[NewsController alloc] init];
    [self setupVC:newsvc title:@"新闻"];
    
    ReadingController *readingvc = [[ReadingController alloc] init];
    [self setupVC:readingvc title:@"订阅"];
    
    UIViewController *phonevc = [[UIViewController alloc] init];
    [self setupVC:phonevc title:@"图片"];
    
    UIViewController *vidiovc = [[UIViewController alloc] init];
    [self setupVC:vidiovc title:@"视频"];
    
    UIViewController *followvc = [[UIViewController alloc] init];
    [self setupVC:followvc title:@"跟帖"];
    
    UIViewController *radiovc = [[UIViewController alloc] init];
    [self setupVC:radiovc title:@"电台"];
    
    
    LeftMenueView *leftMenu = [[LeftMenueView alloc] init];
    leftMenu.y = 150;
    leftMenu.width =  ScreenWidth - 120;
    leftMenu.height = ScreenHeight - leftMenu.y * 2;
    leftMenu.delegate = self;
    [self.view addSubview:leftMenu];
    [self.view insertSubview:leftMenu atIndex:1];
    self.leftMenu = leftMenu;
    
    RightMenueView *rightMenu = [[RightMenueView alloc] init];
//    rightMenu.backgroundColor = [UIColor redColor];
    rightMenu.x =  100;
    rightMenu.width =  ScreenWidth - rightMenu.x;
    rightMenu.height = ScreenHeight ;
    [self.view addSubview:rightMenu];
    [self.view insertSubview:rightMenu belowSubview:leftMenu];
    self.rightMenu = rightMenu;
    __weak typeof (self)weakSelf =  self;
    self.rightMenu.gobackBlock = ^{
        [UIView animateWithDuration:kAnimationDuration animations:^{
            weakSelf.showViewController.view.transform = CGAffineTransformIdentity;
        }];
    };
    
    self.rightMenu.gomainBlock = ^{
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    };
    
}

- (void)setupBgView
{
    UIImageView *imgView = [[UIImageView alloc] init];
    imgView.frame = self.view.bounds;
    imgView.contentMode = UIViewContentModeScaleAspectFill;
    imgView.clipsToBounds = YES;
    imgView.image = IMAGE(@"sidebar_bg");
    [self.view addSubview:imgView];
}

#pragma mark 设置子控制器
- (void)setupVC:(UIViewController *)vc title:(NSString *)title
{
    vc.view.frame = self.view.bounds;
    vc.view.backgroundColor = [UIColor blackColor];
    MiWYNewsNavigationController *readingNav = [[MiWYNewsNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:readingNav];
    
    // 设置导航栏数据
    vc.navigationItem.titleView = [TitleButton title:title];
    vc.navigationItem.leftBarButtonItem = [UIBarButtonItem buttonItemWithImg:@"top_navigation_menuicon" hightLightImg:nil target:self action:@selector(menuBtnClick:) btnTag:1000];
    vc.navigationItem.rightBarButtonItem = [UIBarButtonItem buttonItemWithImg:@"top_navigation_infoicon" hightLightImg:nil target:self action:@selector(menuBtnClick:) btnTag:2000];
}

- (void)menuBtnClick: (UIButton *)btn
{
    // 拿点击的控制器的view
    UIView *showView = self.showViewController.view;
    [UIView animateWithDuration:kAnimationDuration animations:^{
        CGFloat scale = ( ScreenHeight - 80 * 2) / ScreenHeight;
        CGFloat leftMargin = ScreenWidth * (1 - scale) * 0.5;
        CGFloat translateX ;
        CGAffineTransform translateForm;
        
        CGAffineTransform scaleForm = CGAffineTransformMakeScale(scale, scale);
        if (btn.tag == 2000) { // 右边
            self.leftMenu.hidden = YES;
            translateX =  ScreenWidth - 100 - leftMargin;
            translateForm =  CGAffineTransformTranslate(scaleForm, - translateX / scale,0);
        }
        else // 左边
        {
            self.rightMenu.hidden = YES;
            translateX = ScreenWidth - 120 - leftMargin;
            translateForm =  CGAffineTransformTranslate(scaleForm,  translateX / scale,0);
        }
        
        showView.transform = translateForm;
        // 遮盖
        UIButton *cover = [UIButton buttonWithType:0];
        cover.tag = kCoverTag;
        cover.frame = showView.bounds;
        [showView addSubview:cover];
        [cover addTarget:self action:@selector(coverClick:) forControlEvents:(UIControlEventTouchUpInside)];
    }];
    
}

#pragma mark 点击遮盖
- (void)coverClick:(UIView *)cover
{
    // 拿点击的控制器的view
    UIView *showView = self.showViewController.view;
    
    //    UIView *missView =   cover.tag == 1000 ? self.leftMenu : self.rightMenu;
    [UIView animateWithDuration:kAnimationDuration animations:^{
        showView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [cover removeFromSuperview];
        self.rightMenu.hidden = NO;
        self.leftMenu.hidden = NO;
    }];
}

#pragma mark 左边栏点击的代理方法
- (void)LeftMenue:(LeftMenueView *)LeftMenue didSelectedWithFormIndex:(NSInteger)formIndex toIndex:(NSInteger)toIndex
{
    UIViewController *oldController = (UIViewController *)self.childViewControllers[formIndex];
    [oldController.view removeFromSuperview];
    
    UIViewController *newController = (UIViewController *)self.childViewControllers[toIndex];
    [self.view addSubview:newController.view];
    
    newController.view.layer.shadowColor = [[UIColor blackColor] CGColor];
    newController.view.layer.shadowOffset = CGSizeMake(-3, 0);
    newController.view.layer.shadowOpacity = 0.2;
    
    // 把旧的控制器view的transform赋值给新的控制器的view
    newController.view.transform = oldController.view.transform;
    
    [UIView animateWithDuration:kAnimationDuration animations:^{
        
        newController.view.transform = CGAffineTransformIdentity;
        
    } completion:^(BOOL finished) {
        self.rightMenu.hidden = NO;
        // 把新控制器的cover移除
        [self coverClick:[newController.view viewWithTag:kCoverTag]]   ;
    }];
    
    // 记录点击的控制器
    self.showViewController = newController;
    
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
