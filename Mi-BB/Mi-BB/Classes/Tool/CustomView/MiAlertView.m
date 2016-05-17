//
//  MiAlertView.m
//  LJMall
//
//  Created by YuanMiaoHeng on 15/10/22.
//  Copyright (c) 2015年 蒋林. All rights reserved.
//
#define kDuration 0.25
#define kLeftBtnDefaultColor [UIColor whiteColor]
#define kLetfBtnHightLighColor [UIColor denimColor]
#define kRightBtnDefaultColor [UIColor whiteColor]
#define kRightBtnHightLighColor [UIColor denimColor]

#import "MiAlertView.h"
#import "Header.h"

@interface MiAlertView ()

@property(nonatomic,weak) UIView *bgView;

@end

@implementation MiAlertView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
       
    }
    return self;
}
#pragma mark 简单保守流
- (instancetype)initWithTitle:(NSString *)title LeftTitle:(NSString *)letfTitle rightTitle:(NSString *)rightTitle
{
    if (self = [super init]) {
        // 拿到 window
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        // 加一层黑色背景
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        [window addSubview:bgView];
        bgView.alpha = 0;
        [UIView animateWithDuration:kDuration animations:^{
        }];
        bgView.backgroundColor = [UIColor blackColor];
        bgView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapG = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bgViewClick:)];
        [bgView addGestureRecognizer:tapG ];
        self.bgView = bgView;

        self.layer.cornerRadius = 5;
        self.clipsToBounds = YES;
         [window addSubview:self];
        // 自己加进去window
        self.frame = CGRectMake(ScreenWidth * 0.5, ScreenHeight * 0.5, 0.1, 0.1);

        [UIView animateWithDuration:kDuration animations:^{
            
//            self.transform = CGAffineTransformMakeScale(2700, 1200);
            self.frame = CGRectMake((ScreenWidth - 270) / 2, ScreenHeight * 0.5 - 50 , 270, 120);

            bgView.alpha = 0.4;
        } completion:^(BOOL finished) {
            if (self.rightBlock) {
                [self setupSubViewWithTitle:title LeftTitle:letfTitle rightTitle:rightTitle rightTitlecomplete:self.rightBlock];
            }
            else
            {
                [self setupSubViewWithTitle:title LeftTitle:letfTitle rightTitle:rightTitle rightTitlecomplete:nil];
            }
            self.backgroundColor = [UIColor whiteColor];
            
            [UIView animateWithDuration:0.1 animations:^{
                self.transform = CGAffineTransformMakeScale(1.2, 1.2);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.1 animations:^{
                    self.transform = CGAffineTransformMakeScale(1.0, 1.0);
                }];
            }] ;
        }];
    }
    return self;
}

#pragma mark 变态暴力流
+ (void)alertWithTitle:(NSString *)title LeftTitle:(NSString *)letfTitle rightTitle:(NSString *)rightTitle rightTitlecomplete:(void(^)())rightTitleClickHandle;
{
    MiAlertView *alert = [[MiAlertView alloc] initWithTitle:title LeftTitle:letfTitle rightTitle:rightTitle];
    if (rightTitleClickHandle) {
        alert.rightBlock = rightTitleClickHandle;
    }
}


+ (void)alertWithTitle:(NSString *)title complete:(void(^)())rightTitleClickHandle;
{
    MiAlertView *alert = [[MiAlertView alloc] initWithTitle:title LeftTitle:@"取消" rightTitle:@"确定"];
    if (rightTitleClickHandle) {
        alert.rightBlock = rightTitleClickHandle;
    }
}


#pragma mark 简单保守流
- (instancetype)initWithTitle:(NSString *)title LeftTitle:(NSString *)letfTitle rightBtn:(UIButton *)rightBtn
{
    if (self = [super init]) {
        // 拿到 window
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        // 加一层黑色背景
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        [window addSubview:bgView];
        bgView.alpha = 0;
        [UIView animateWithDuration:kDuration animations:^{
        }];
        bgView.backgroundColor = [UIColor blackColor];
        bgView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapG = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bgViewClick:)];
        [bgView addGestureRecognizer:tapG ];
        self.bgView = bgView;
        
        self.layer.cornerRadius = 5;
        self.clipsToBounds = YES;
        [window addSubview:self];
        // 自己加进去window
        self.frame = CGRectMake(ScreenWidth * 0.5, ScreenHeight * 0.5, 0.1, 0.1);
        
        [UIView animateWithDuration:kDuration animations:^{
            
            //            self.transform = CGAffineTransformMakeScale(2700, 1200);
            self.frame = CGRectMake((ScreenWidth - 270) / 2, ScreenHeight * 0.5 - 50 , 270, 120);
            
            bgView.alpha = 0.4;
        } completion:^(BOOL finished) {
            if (self.rightBlock) {
                [self setupSubViewWithTitle:title LeftTitle:letfTitle rightBtn:rightBtn rightTitlecomplete:self.rightBlock];
            }
            else
            {
                [self setupSubViewWithTitle:title LeftTitle:letfTitle rightBtn:rightBtn rightTitlecomplete:nil];
            }
            self.backgroundColor = [UIColor whiteColor];
            
            [UIView animateWithDuration:0.1 animations:^{
                self.transform = CGAffineTransformMakeScale(1.2, 1.2);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.1 animations:^{
                    self.transform = CGAffineTransformMakeScale(1.0, 1.0);
                }];
            }] ;
        }];
    }
    return self;
}



#pragma mark 子控件
- (void)setupSubViewWithTitle:(NSString *)title LeftTitle:(NSString *)letfTitle rightTitle:(NSString *)rightTitle rightTitlecomplete:(void(^)())rightTitleClickHandle
{
    UILabel *titleLabel = [[UILabel alloc] init];
    [self addSubview:titleLabel];
    titleLabel.text =  title;
    titleLabel.backgroundColor = [UIColor whiteColor];
    titleLabel.frame =  CGRectMake(5, 5, self_W - 10, 120 - 44 - 0.5 - 10);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.textColor = [UIColor grayColor];
    titleLabel.numberOfLines = 0;
    
    UIView *diver = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLabel.frame) + 5,self_W, 0.5)];
    [self addSubview:diver];
    diver.backgroundColor = [UIColor lightGrayColor];
    
    UIButton *leftBtn = [UIButton buttonWithType:0];
    [self addSubview:leftBtn];
    [leftBtn setTitle:letfTitle forState:(UIControlStateNormal)];
    [leftBtn setTitleColor: [UIColor blackColor] forState:(UIControlStateNormal)] ;
    leftBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    leftBtn.tag = 10;
    leftBtn.frame = CGRectMake(0, 120 - 44 , (self_W - 0.5) * 0.5, 44);
    leftBtn.backgroundColor = kLeftBtnDefaultColor;
    [leftBtn addTarget:self action:@selector(btnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [leftBtn addTarget:self action:@selector(hightLightBackgroungHanddle:) forControlEvents:(UIControlEventTouchDown)];
    [leftBtn addTarget:self action:@selector(dragOutsideBackgroungHanddle:) forControlEvents:(UIControlEventTouchDragOutside)];

    if (self.leftTitleColor) {
        [leftBtn  setTitleColor:self.leftTitleColor forState:(UIControlStateNormal)] ;
    }
    
    UIView *btnDiver = [[UIView alloc] init];
    btnDiver.frame = CGRectMake(CGRectGetMaxX(leftBtn.frame), CGRectGetMaxY(diver.frame) , 0.5, 44 );
    btnDiver.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:btnDiver];
    
    UIButton *rightBtn = [UIButton buttonWithType:0];
//    if(self.rightBtn)
//    {
//        rightBtn = self.rightBtn;
//    }
    [self addSubview:rightBtn];
    [rightBtn setTitle:rightTitle forState:(UIControlStateNormal)];
    [rightBtn setTitleColor:[UIColor salmonColor] forState:(UIControlStateNormal)] ;
    rightBtn.backgroundColor = kRightBtnDefaultColor;
    rightBtn.titleLabel.font = leftBtn.titleLabel.font;
    rightBtn.tag = 11;
    rightBtn.frame = CGRectMake( CGRectGetMaxX(leftBtn.frame) + 0.5, leftBtn.frame.origin.y, leftBtn.frame.size.width, 44);
    if (self.rightTitleBackgroupColor ) {
        rightBtn.backgroundColor = self.rightTitleBackgroupColor;
    }
  
    
    [rightBtn addTarget:self action:@selector(btnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [rightBtn addTarget:self action:@selector(hightLightBackgroungHanddle:) forControlEvents:(UIControlEventTouchDown)];
    [rightBtn addTarget:self action:@selector(dragOutsideBackgroungHanddle:) forControlEvents:(UIControlEventTouchDragOutside)];

    
    
   // 传递block
    self.rightBlock = rightTitleClickHandle;
    
    
    if (self.titleFontSize) {
        titleLabel.font = [UIFont systemFontOfSize:self.titleFontSize];
    }
    
    if (self.rightTitleColor) {
        [rightBtn setTitleColor:self.rightTitleColor forState:(UIControlStateNormal)] ;
    }
    
    if (self.leftTitleBackgroupColor) {
        leftBtn.backgroundColor = self.leftTitleBackgroupColor;
    }
    
    if (self.rightTitleBackgroupColor) {
        rightBtn.backgroundColor = self.rightTitleBackgroupColor;
    }
    
    if (self.titleColor) {
        titleLabel.textColor = self.titleColor;
    }
}

#pragma mark 子控件2
- (void)setupSubViewWithTitle:(NSString *)title LeftTitle:(NSString *)letfTitle rightBtn:(UIButton *)rightBtn rightTitlecomplete:(void(^)())rightTitleClickHandle
{
    UILabel *titleLabel = [[UILabel alloc] init];
    [self addSubview:titleLabel];
    titleLabel.text =  title;
    titleLabel.backgroundColor = [UIColor whiteColor];
    titleLabel.frame =  CGRectMake(5, 5, self_W - 10, 120 - 44 - 0.5 - 10);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.textColor = [UIColor grayColor];
    titleLabel.numberOfLines = 0;
    
    UIView *diver = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLabel.frame) + 5,self_W, 0.5)];
    [self addSubview:diver];
    diver.backgroundColor = [UIColor lightGrayColor];
    
    UIButton *leftBtn = [UIButton buttonWithType:0];
    [self addSubview:leftBtn];
    [leftBtn setTitle:letfTitle forState:(UIControlStateNormal)];
    [leftBtn setTitleColor: [UIColor blackColor] forState:(UIControlStateNormal)] ;
    leftBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    leftBtn.tag = 10;
    leftBtn.frame = CGRectMake(0, 120 - 44 , (self_W - 0.5) * 0.5, 44);
    leftBtn.backgroundColor = kLeftBtnDefaultColor;
    [leftBtn addTarget:self action:@selector(btnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [leftBtn addTarget:self action:@selector(hightLightBackgroungHanddle:) forControlEvents:(UIControlEventTouchDown)];
    [leftBtn addTarget:self action:@selector(dragOutsideBackgroungHanddle:) forControlEvents:(UIControlEventTouchDragOutside)];
    
    if (self.leftTitleColor) {
        [leftBtn  setTitleColor:self.leftTitleColor forState:(UIControlStateNormal)] ;
    }
    
    UIView *btnDiver = [[UIView alloc] init];
    btnDiver.frame = CGRectMake(CGRectGetMaxX(leftBtn.frame), CGRectGetMaxY(diver.frame) , 0.5, 44 );
    btnDiver.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:btnDiver];
    
//    UIButton *rightBtn = [UIButton buttonWithType:0];
    //    if(self.rightBtn)
    //    {
    //        rightBtn = self.rightBtn;
    //    }
    [self addSubview:rightBtn];
//    [rightBtn setTitle:rightTitle forState:(UIControlStateNormal)];
//    [rightBtn setImage:IMAGE(@"goThere") forState:(UIControlStateNormal)];
    [rightBtn setTitleColor:[UIColor warmGrayColor] forState:(UIControlStateNormal)] ;
    rightBtn.backgroundColor = kRightBtnDefaultColor;
    rightBtn.titleLabel.font = leftBtn.titleLabel.font;
    rightBtn.adjustsImageWhenHighlighted = NO;
    rightBtn.tag = 11;
    rightBtn.frame = CGRectMake( CGRectGetMaxX(leftBtn.frame) + 0.5, leftBtn.frame.origin.y, leftBtn.frame.size.width, 44);
    if (self.rightTitleBackgroupColor ) {
        rightBtn.backgroundColor = self.rightTitleBackgroupColor;
    }
    
    
    [rightBtn addTarget:self action:@selector(btnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [rightBtn addTarget:self action:@selector(hightLightBackgroungHanddle:) forControlEvents:(UIControlEventTouchDown)];
    [rightBtn addTarget:self action:@selector(dragOutsideBackgroungHanddle:) forControlEvents:(UIControlEventTouchDragOutside)];
    
    
    
    // 传递block
    self.rightBlock = rightTitleClickHandle;
    
    
    if (self.titleFontSize) {
        titleLabel.font = [UIFont systemFontOfSize:self.titleFontSize];
    }
    
    if (self.rightTitleColor) {
        [rightBtn setTitleColor:self.rightTitleColor forState:(UIControlStateNormal)] ;
    }
    
    if (self.leftTitleBackgroupColor) {
        leftBtn.backgroundColor = self.leftTitleBackgroupColor;
    }
    
    if (self.rightTitleBackgroupColor) {
        rightBtn.backgroundColor = self.rightTitleBackgroupColor;
    }
    
    if (self.titleColor) {
        titleLabel.textColor = self.titleColor;
    }
}



#pragma mark - 点击
- (void)btnClick:(UIButton *)btn
{
    if (btn.tag == 10) {
        btn.backgroundColor = kLeftBtnDefaultColor;
        if (self.leftTitleBackgroupColor) {
            btn.backgroundColor = self.leftTitleBackgroupColor;
        }
        if (self.leftBlock) {
            self.leftBlock();
        }
        [self dismiss];
    }
    else
    {
        btn.backgroundColor = kRightBtnDefaultColor;
        if (self.rightTitleBackgroupColor) {
            btn.backgroundColor = self.rightTitleBackgroupColor;
        }
        if (self.rightBlock) {
            self.rightBlock();
        }
        [self dismiss];
    }
}

- (void)hightLightBackgroungHanddle:(UIButton *)btn
{
    if (btn.tag == 10) {
        btn.backgroundColor = kLetfBtnHightLighColor;
        if (self.leftHightedLightBackgroungColor) {
            btn.backgroundColor = self.leftHightedLightBackgroungColor;
        }
    }
    else
    {
        btn.backgroundColor = kRightBtnHightLighColor;
        if (self.rightHightedLightBackgroungColor) {
            btn.backgroundColor = self.rightHightedLightBackgroungColor;
        }
    }
}

- (void)dragOutsideBackgroungHanddle:(UIButton *)btn
{
    if (btn.tag == 10) {
        btn.backgroundColor = kLeftBtnDefaultColor;
        if (self.leftHightedLightBackgroungColor) {
            btn.backgroundColor = self.leftHightedLightBackgroungColor;
        }
    }
    else
    {
        btn.backgroundColor = kRightBtnDefaultColor;
        if (self.leftHightedLightBackgroungColor) {
            btn.backgroundColor = self.leftHightedLightBackgroungColor;
        }
    }
}


- (void)bgViewClick:(UITapGestureRecognizer *)tap
{
    [self dismiss];
}


- (void)dismiss
{
    [UIView animateWithDuration:0.25 animations:^{
        self.transform = CGAffineTransformMakeScale(0.01, 0.01);
        self.alpha = 0;
        self.bgView.alpha = 0;
        
    } completion:^(BOOL finished) {
        [self.bgView removeFromSuperview];
        [self removeFromSuperview];
    }];

}

@end
