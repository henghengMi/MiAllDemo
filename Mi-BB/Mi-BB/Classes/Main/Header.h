//
//  Header.h
//  Mi-BB
//
//  Created by YuanMiaoHeng on 16/4/19.
//  Copyright © 2016年 Mi. All rights reserved.
//

#ifndef Header_h
#define Header_h

/**** 宏 ****/
/** 快捷定义UIImage对象 **/
#define IMAGE(imageName) [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]]

/** RGB颜色 */
// 颜色
#define MiColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define MiColorRGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]

/**
 *  16进制颜色
 */
#define MiColorHex(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define MiColorHexA(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

// 随机色
#define MiRandomColor MiColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))
#define MiRandomColorRGBA MiColorRGBA(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), 0.3)
#define MiRandomColorRGBa(a) MiColorRGBA(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), a)

/** 数据本地化 */
#define USERDEFAULTS [NSUserDefaults standardUserDefaults]
#define More_Than_568 K_Height > 568 ?
#define More_Than_667 K_Height > 667 ?
#define ScreenWidth  [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
/** View的尺寸 **/
#define self_W self.frame.size.width
#define self_H self.frame.size.height


/**** 分类 ****/
#import "Colours.h"
#import "NSString+SizeWithFont.h"
#import "UIView+Extension.h"
#import "UIButton+costomBtn.h"
#import "UIImage+Mi.h"
#import "MBProgressHUD+MJ.h"
#import "Masonry.h"

#endif
