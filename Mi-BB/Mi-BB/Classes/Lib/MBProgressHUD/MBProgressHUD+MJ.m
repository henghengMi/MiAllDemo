//
//  MBProgressHUD+MJ.m
//
//  Created by mj on 13-4-18.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "MBProgressHUD+MJ.h"

@implementation MBProgressHUD (MJ)


#pragma mark - 显示信息（仅文字）Mi_Yuan
+ (void)showText:(NSString *)text view:(UIView *)view
{
        if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
        // 快速显示一个提示信息
        MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
        
        hud.labelText = text;
        
        // 再设置模式
        hud.mode = MBProgressHUDModeText;
        
        // 动画消失 类型
        hud.animationType = MBProgressHUDAnimationZoomIn;
        
        // 隐藏时候从父控件中移除
        hud.removeFromSuperViewOnHide = YES;
        
        // x秒之后再消失
        [hud hide:YES afterDelay:3.0f];
        
        // 弹出的背景颜色
        hud.color = [UIColor colorWithRed:0/255.0 green:160/255.0 blue:180/255.0 alpha:0.8];
        [hud showHUDAddedTo:view animated:YES];
}


#pragma mark 显示信息(有头像)
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view
{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];

    hud.labelText = text;
    
//    hud.detailsLabelText = text;
    // 设置图片
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    
    // 动画消失 类型
    hud.animationType = MBProgressHUDAnimationZoomIn;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // x秒之后再消失
    [hud hide:YES afterDelay:1.2f];
    
    // 弹出的背景颜色
    hud.color = [UIColor colorWithRed:0/255.0 green:160/255.0 blue:180/255.0 alpha:0.8];
    [hud showHUDAddedTo:view animated:YES];

}

#pragma mark 显示错误或正确信息
+ (void)showError:(NSString *)error toView:(UIView *)view{
    [self show:error icon:@"error.png" view:view];
}

+ (void)showSuccess:(NSString *)success toView:(UIView *)view
{
    [self show:success icon:@"success.png" view:view];
}


#pragma mark 加载中一些信息
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view {

    if (view == nil)
    {
      view = [UIApplication sharedApplication].keyWindow;
    }

    // 快速显示一个提示信息
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
    //  显示的内容
    hud.labelText = message;
    
 // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // YES代表需要蒙版效果
//    hud.dimBackground = YES;
    hud.mode = MBProgressHUDModeIndeterminate;
    // 弹出的背景颜色
    hud.color = [UIColor colorWithRed:0/255.0 green:200/255.0 blue:220/255.0 alpha:0.8];//[UIColor colorWithRed:0.0/255.0 green:160.0/255.0 blue:180.0/255.0 alpha:0.3];
    
    // 消失的动画类型
    hud.animationType = MBProgressHUDAnimationZoomIn;
    
    [hud showHUDAddedTo:view animated:YES];

    
    return hud;
}

+ (void)showSuccess:(NSString *)success
{
    [self showSuccess:success toView:nil];
}

+ (void)showError:(NSString *)error
{
    [self showError:error toView:nil];
}

#pragma mark Mi_Yuan
+ (void)showTitle:(NSString *)title;
{
    [self showText:title view:nil];
}


+ (MBProgressHUD *)showMessage:(NSString *)message
{
    return [self showMessage:message toView:nil];
}

+ (void)hideHUDForView:(UIView *)view
{
    if (view == nil)
    {
        view = [UIApplication sharedApplication].keyWindow;
    }

    [self hideHUDForView:view animated:YES];
}

+ (void)hideHUD
{
    [self hideHUDForView:nil];
}
@end
