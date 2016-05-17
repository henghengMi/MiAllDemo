//
//  UIBarButtonItem+BarImgButton.h
//  Mi网易新闻
//
//  Created by YuanMiaoHeng on 15/11/13.
//  Copyright © 2015年 LianJiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (BarImgButton)
+ (instancetype)buttonItemWithImg:(NSString *)img hightLightImg:(NSString *)hightLightImg target:(id)target action:(SEL)action btnTag:(int)btnTag;
@end
