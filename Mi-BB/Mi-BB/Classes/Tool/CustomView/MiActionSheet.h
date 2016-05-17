//
//  MiActionSheet.h
//  LJMall
//
//  Created by YuanMiaoHeng on 15/10/14.
//  Copyright (c) 2015年 蒋林. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TitleButtonClickBlock) (NSInteger index);

@interface MiActionSheet : UIView

@property(nonatomic, copy) TitleButtonClickBlock  titleBtnClick ;

@property(nonatomic, strong) UIColor *backgroupColorWithButton;

@property(nonatomic, assign) CGFloat fontSize;

@property(nonatomic, strong) UIColor * titleColor;

@property(nonatomic, strong) UIColor * topTitleColor;



- (instancetype)initWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle  otherButtonTitles:(NSArray *)otherButtonTitles;




@end
