//
//  MiAlertView.h
//  LJMall
//
//  Created by YuanMiaoHeng on 15/10/22.
//  Copyright (c) 2015年 蒋林. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^LeftBlock)();
typedef void (^RightBlock)();

@interface MiAlertView : UIView


/** 类方法-Block为点击确定按钮后操作 **/
+ (void)alertWithTitle:(NSString *)title LeftTitle:(NSString *)letfTitle rightTitle:(NSString *)rightTitle rightTitlecomplete:(void(^)())rightTitleClickHandle;

/** 类方法Block操作 默认左边为取消，右边为确定 按钮 **/
+ (void)alertWithTitle:(NSString *)title complete:(void(^)())rightTitleClickHandle;

/** 定制各种属性 **/
- (instancetype)initWithTitle:(NSString *)title LeftTitle:(NSString *)letfTitle rightTitle:(NSString *)rightTitle ;


- (instancetype)initWithTitle:(NSString *)title LeftTitle:(NSString *)letfTitle rightBtn:(UIButton *)rightBtn;


//@property (nonatomic, copy) dispatch_block_t leftBlock;
//@property (nonatomic, copy) dispatch_block_t rightBlock;

/** 点击的Block **/
@property(nonatomic, copy)LeftBlock leftBlock;
@property(nonatomic, copy)RightBlock rightBlock;


/** 颜色 **/
@property(nonatomic, strong) UIColor *leftTitleColor;
@property(nonatomic, strong) UIColor *leftTitleBackgroupColor;
@property(nonatomic, strong) UIColor *titleColor;
@property(nonatomic, strong) UIColor *rightTitleColor;
@property(nonatomic, strong) UIColor *rightTitleBackgroupColor;
@property(nonatomic, strong) UIColor *leftHightedLightBackgroungColor;
@property(nonatomic, strong) UIColor *rightHightedLightBackgroungColor;

/** 字体 **/
@property(nonatomic, assign) CGFloat titleFontSize;

/** 右边按钮 **/
@property(nonatomic, assign) UIButton *rightBtn;






@end
