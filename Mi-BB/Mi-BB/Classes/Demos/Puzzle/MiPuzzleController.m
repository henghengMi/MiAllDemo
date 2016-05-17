//
//  MiPuzzleController.m
//  Mi-BB
//
//  Created by YuanMiaoHeng on 16/4/19.
//  Copyright © 2016年 Mi. All rights reserved.
//

#import "MiPuzzleController.h"

#define clumns 3
#define row  3
#define imgCount 11

#import "MiPuzzleController.h"
#import "UIView+Extension.h"
#import "MBProgressHUD+MJ.h"
#import "UIView+Animation.h"
#import "UIView+BluerEffect.h"
#import "UIView+Spring.h"
#import "UIView+AnimationTransition.h"

@interface MiPuzzleController ()
{
    CGFloat _minD;
    CGRect _beginRect;
    int _benginIndex;
    CGRect _clickViewRect;
}

@property(nonatomic,weak)  UIImageView *puzzleImgView ;
@property(nonatomic,weak)  UIView *puzzleBgView;
@property (weak, nonatomic)  UIImageView *bgView;
@property (weak, nonatomic)  UIScrollView *scrollView;
@property(nonatomic,strong)  NSMutableArray *imgeViewsArrary ;
@property(nonatomic,strong)  NSMutableArray *chaosImgeViewsArrary ;
@property(nonatomic,strong)  NSMutableArray *frames ;
@property(nonatomic,weak)  UIView *topView ;
@property(nonatomic,strong)  NSMutableArray *smallImgeViewsArrary ;
@property(nonatomic,weak) UIVisualEffectView *effectView;
@property(nonatomic,weak)  UIButton *goBtn ;
@property(nonatomic,weak)  UIButton * gobackBtn;
@property(nonatomic,weak)  UIImageView * clickSmallView;

@end



@implementation MiPuzzleController

- (NSMutableArray *)smallImgeViewsArrary
{
    if (_smallImgeViewsArrary == nil) {
        _smallImgeViewsArrary = [NSMutableArray array];
    }
    return _smallImgeViewsArrary;
}

- (NSMutableArray *)imgeViewsArrary
{
    if (_imgeViewsArrary == nil) {
        _imgeViewsArrary = [NSMutableArray array];
    }
    return _imgeViewsArrary;
}

- (NSMutableArray *)chaosImgeViewsArrary
{
    if (_chaosImgeViewsArrary == nil) {
        _chaosImgeViewsArrary = [NSMutableArray array];
    }
    return _chaosImgeViewsArrary;
}

- (NSMutableArray *)frames
{
    if (_frames == nil) {
        _frames = [NSMutableArray array];
    }
    return _frames;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.navigationController.navigationBarHidden = NO;
//    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    
    _minD = 10000;
    
    [self setupBgView];
    [self setupTopView];
    [self setupSmallViews];
    [self setupPuzzleView];
}

//- (UIImage *)imagesNamedFromCustomBundle:(NSString *)imgName
//{
//    NSString *bundlePath = [[NSBundle mainBundle].resourcePath stringByAppendingPathComponent:@"dzs_Image.Bundle"];
//    NSLog(@"bundlePath:%@",bundlePath);
//    
//    NSString *img_path = [bundlePath stringByAppendingPathComponent:imgName];
//    
//    return [UIImage imageWithContentsOfFile:img_path];
//    
//}

- (void)setupBgView
{
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:bgView];
    self.bgView = bgView;
    self.bgView.clipsToBounds = YES;
    self.bgView.contentMode = UIViewContentModeScaleAspectFill;
    self.bgView.image = [UIImage imageByBundleWithImageName:@"dzs0.jpg"];
    
    //    [self.bgView BluerEffect];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    effectView.alpha = 0.9;
    effectView.frame = self.view.bounds;
    [self.bgView addSubview:effectView];
    self.effectView = effectView;
}

#pragma mark 根据装有图片名字的数组摆放Ui
- (void)setupSmallViews
{
    // scrollView
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth - 5, 90)];
    [self.view addSubview:scrollView];
    scrollView.backgroundColor = [UIColor clearColor];
    self.scrollView = scrollView;
    
    int marginX = 5;
    int marginY = 5;
    for (int i = 0; i < imgCount; i ++) {
        UIImageView *smallView = [[UIImageView alloc] init];
        [scrollView addSubview:smallView];
        smallView.clipsToBounds = YES;
        smallView.contentMode = UIViewContentModeScaleAspectFill;
        smallView.image = [UIImage imageByBundleWithImageName:[NSString stringWithFormat:@"dzs%d.jpg",i]];
        smallView.userInteractionEnabled = YES;
        smallView.frame = CGRectMake((80 + marginX) * i + 5, marginY, 80, 80);
        smallView.alpha = 0;
        smallView.tag = i + 10;
        [UIView animateWithDuration:0.5 animations:^{
            smallView.alpha = 1;
        }];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSmall:)];
        [smallView addGestureRecognizer:tap];
    }
    
    scrollView.contentSize = CGSizeMake( CGRectGetMaxX( scrollView.subviews.lastObject.frame), 1);
}

- (void)setupGo
{
    if (self.goBtn == nil) {
        UIButton *goBtn = [UIButton buttonWithType:0];
        [goBtn setTitle:@"Go!!!" forState:(UIControlStateNormal)];
        [goBtn setTitleColor:MiRandomColor forState:(UIControlStateNormal)];
        [self.view addSubview:goBtn];
        goBtn.frame = CGRectMake(ScreenWidth - 100 - ((ScreenWidth - 300)/2), 100 + 20, 100, 30);
        goBtn.backgroundColor = MiRandomColorRGBA;
        goBtn.layer.cornerRadius = 4;
        goBtn.clipsToBounds = YES;
        goBtn.showsTouchWhenHighlighted = YES;
        goBtn.alpha = 0;
        self.goBtn = goBtn;
        [goBtn addTarget:self action:@selector(goClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [UIView animateWithDuration:2 animations:^{
            goBtn.alpha = 1;
        }completion:^(BOOL finished) {
            [goBtn zoomWithDuration:2.0 repeatCount:1 values:@[@(1.0),@(1.5),@(0.8),@(1.0)]];
        }];
    }
    else
    {
        [UIView animateWithDuration:2 animations:^{
            self.goBtn.alpha = 1;
        }completion:^(BOOL finished) {
            [self.goBtn zoomWithDuration:2.0 repeatCount:1 values:@[@(1.0),@(1.5),@(0.8),@(1.0)]];
        }];
    }
}

- (void)setupGoBackButton
{
    if (self.gobackBtn == nil) {
        UIButton *goBtn = [UIButton buttonWithType:0];
        [goBtn setTitle:@"Goback!" forState:(UIControlStateNormal)];
        [goBtn setTitleColor:MiRandomColor forState:(UIControlStateNormal)];
        [self.view addSubview:goBtn];
        goBtn.frame = CGRectMake(ScreenWidth - 100 - ((ScreenWidth - 300)/2), 100 + 30 - 20 + 100, 100, 30);
        goBtn.backgroundColor = MiRandomColorRGBA;
        goBtn.layer.cornerRadius = 4;
        goBtn.clipsToBounds = YES;
        goBtn.showsTouchWhenHighlighted = YES;
        goBtn.alpha = 0;
        self.gobackBtn = goBtn;
        [goBtn addTarget:self action:@selector(gobackClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [UIView animateWithDuration:2 animations:^{
            goBtn.alpha = 1;
        } completion:^(BOOL finished) {
            [goBtn zoomWithDuration:2.5 repeatCount:1 values:@[@(1),@(1.5),@(0.8),@(1.5),@(1)]];
        }];
    }
    
    else
    {
        [UIView animateWithDuration:2 animations:^{
            self.gobackBtn.alpha = 1;
        }completion:^(BOOL finished) {
            [self.gobackBtn zoomWithDuration:2.5 repeatCount:1 values:@[@(1),@(1.5),@(0.8),@(1.5),@(1)]];
        }];
    }
}


- (void)gobackClick:(UIButton *)btn
{
    /*
     * 1. topView回来，
     * 2. View 旋转飞回去
     */
    [self.goBtn zoomWithDuration:1 repeatCount:2 values:@[@(1.0),@(1.8),@(0.2),@(1.0)]];
    [self.gobackBtn zoomWithDuration:1.5 repeatCount:1 values:@[@(1.0),@(0.5),@(1.5),@(1.0)]];
    for (int i = 0; i < self.chaosImgeViewsArrary.count; i ++) {
        UIImageView *imgView = self.chaosImgeViewsArrary[i];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(i - 1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [imgView circleWithDuration:0.25 + (i * 2)];
        });
        [UIView animateWithDuration:1.5 animations:^{
            imgView.frame = self.clickSmallView.frame;
            imgView.alpha = 0;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.25 animations:^{
            }];
            [imgView stopCircle];
        }];
    };
    
    [self.clickSmallView zoomWithDuration:1.5 repeatCount:1 values:@[@(1.8),@(1)]];
    // 点击的view 开始转
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.clickSmallView circleWithDuration:0.25];
    });
    // 开始回收其他东东
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.clickSmallView zoomWithDuration:2.5 repeatCount:1 values:@[@(1.8),@(0.5),@(1)]];
        [UIView animateWithDuration:3 animations:^{
            self.topView.transform = CGAffineTransformIdentity;
            self.scrollView.transform = CGAffineTransformIdentity;
            self.clickSmallView.transform = CGAffineTransformIdentity;
            self.gobackBtn.alpha = 0;
            self.goBtn.alpha = 0;
            self.effectView.alpha = 1.0;
            
        } completion:^(BOOL finished) {
            self.clickSmallView.x = _clickViewRect.origin.x;
            [self.clickSmallView stopCircle];
            [self.scrollView addSubview:self.clickSmallView];
            [self.scrollView insertSubview:self.clickSmallView atIndex:self.clickSmallView.tag - 10];
            self.clickSmallView.userInteractionEnabled = YES;
            
        }];
    });
    
}

- (void)goClick:(UIButton *)btn
{
    [self.chaosImgeViewsArrary removeAllObjects];
    
    NSMutableArray *tempArray = [NSMutableArray array];
    [tempArray addObjectsFromArray:self.imgeViewsArrary];
    // 1. 打乱顺序
    for (int i = 0; i < self.imgeViewsArrary.count ; i ++) {
        // 随机抽出一个数字
        int  randomNum = arc4random_uniform(self.imgeViewsArrary.count - i);
        UIImageView *randomImgView = tempArray[randomNum];
        // 取出元素放到另一个数组中
        [tempArray removeObjectAtIndex:randomNum];
        [self.chaosImgeViewsArrary addObject:randomImgView];
        // 直到取完为止
    }
    
    // 2. 将imgView渲上去
    for (int i = 0; i < self.chaosImgeViewsArrary.count; i ++) {
        UIImageView *chaosImgView = self.chaosImgeViewsArrary[i];
        [self.view addSubview:chaosImgView];
        [chaosImgView circleWithDuration:0.25];
        [UIView animateWithDuration:0.15 animations:^{
            chaosImgView.frame = [self.frames[i] CGRectValue];
        } completion:^(BOOL finished) {
            [chaosImgView stopCircle];
        }];
        chaosImgView.userInteractionEnabled = YES;
        // 加拖动手势
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
        [chaosImgView addGestureRecognizer:pan];
    }
}



#pragma mark 成功后的处理。
-(void)successHanddle
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD showTitle:@"😱天才!你怎么做到的?"];
    });
    
}

#pragma mark - 配置拼图View
- (void)setupPuzzleView
{
    UIImageView *puzzleImgView = [[UIImageView alloc] init];
    [self.view addSubview:puzzleImgView];
    puzzleImgView.width = 300;
    puzzleImgView.height = 300;
    puzzleImgView.x = ScreenWidth * 0.5 -  puzzleImgView.width * 0.5;
    puzzleImgView.y = ScreenHeight - 300 - 100;//ScreenHeight * 0.5 - puzzleImgView.height * 0.5  ;
    self.puzzleImgView = puzzleImgView;
    puzzleImgView.clipsToBounds = YES;
    puzzleImgView.contentMode = UIViewContentModeScaleAspectFill;
    //    puzzleImgView.alpha = 0.01;
    
}
#pragma mark  头View
- (void)setupTopView {
    UIView *choiceView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 90)];
    [self.view addSubview:choiceView];
    choiceView.backgroundColor = MiRandomColorRGBA;
    self.topView = choiceView;
}

#pragma mark - 配置9宫
- (void)setupJiuGongWithTapView:(UIView *)tapView
{
    [self.frames removeAllObjects];
    [self.imgeViewsArrary removeAllObjects];
    [self.chaosImgeViewsArrary removeAllObjects];
    self.puzzleImgView.hidden = NO;
    
    // 分成9宫格带间隔
    CGFloat clumnsMargin = 2;
    CGFloat rowMargin = 2;
    CGFloat cellWith =  (self.puzzleImgView.width - ((clumns - 1 )* clumnsMargin) ) / clumns;
    CGFloat cellHeight = (self.puzzleImgView.height - ((row - 1) * rowMargin)) / row;
    UIImageView *tapImgView = (UIImageView *)tapView;
    self.puzzleImgView.image = tapImgView.image;
    
    for (int i = 0; i < clumns * row; i ++) {
        int iX = i % clumns;
        int iY = i / clumns;
        CGRect rect = CGRectMake(iX * (cellWith- clumnsMargin )  * 2, iY * (cellHeight - rowMargin) * 2, cellWith * 2, cellHeight * 2);
        UIImage *cutImg = [self cutWithView:self.puzzleImgView rect:rect];
        UIImageView *cutImgView = [[UIImageView alloc] init];
        cutImgView.tag = i ;
        cutImgView.image = cutImg;
        cutImgView.userInteractionEnabled = YES;
        //        cutImgView.alpha = 0;
        cutImgView.frame = tapView.frame;
        [cutImgView circleWithDuration:i * 1];
        cutImgView.alpha = 1;
        
        [UIView animateWithDuration:2 animations:^{
            cutImgView.frame = CGRectMake(iX * (cellWith + clumnsMargin ) + self.puzzleImgView.x, iY *(cellHeight + rowMargin) + self.puzzleImgView.y, cellWith , cellHeight );
            cutImgView.alpha = 1;
        } completion:^(BOOL finished) {
            [cutImgView stopCircle];
        }];
        
        [self.frames addObject:[NSValue valueWithCGRect:cutImgView.frame]];
        
        [self.view addSubview:cutImgView];
        [self.imgeViewsArrary addObject:cutImgView];
        [self.chaosImgeViewsArrary addObject:cutImgView];
    }
    self.puzzleImgView.hidden = YES;
}

#pragma mark - 点🐔小图
- (void)tapSmall:(UITapGestureRecognizer *)tap
{
    UIImageView *tapView = (UIImageView *)tap.view;
    
    _clickViewRect = tapView.frame;
    tapView.userInteractionEnabled = NO;
    self.clickSmallView = tapView;
#warning 将在scrollView的x 转化为View的x
    [self.view addSubview:tapView];
    self.clickSmallView.x = _clickViewRect.origin.x - self.scrollView.contentOffset.x;
    
    NSLog(@"tapView.frame%@",NSStringFromCGRect(tapView.frame));
    [tapView circleWithDuration:0.25];
    
    CGFloat tapViewTx = 65 - tapView.x;
    CGFloat tapViewTy = 135 - tapView.y;
    [self setupGo];
    [self setupGoBackButton];
    
    [UIView animateWithDuration:2 animations:^{
        tapView.transform  = CGAffineTransformMakeTranslation(tapViewTx, tapViewTy);
        //{65, 135}, {80, 80}
        self.scrollView.transform = CGAffineTransformMakeTranslation(0, -self.scrollView.height);
        self.topView.transform = CGAffineTransformMakeTranslation(0, -self.topView.height);
        self.effectView.alpha = 2.0;
    } completion:^(BOOL finished) {
        [tapView zoomWithDuration:3 repeatCount:1 values:@[@(1),@(2.0),@(0.8),@(1.8)]];
        [self setupBgViewWithTapView:tapView];
        [self setupJiuGongWithTapView:tapView];
        [tapView stopCircle];
        
        NSLog(@"%@",NSStringFromCGRect(tapView.frame));
    }];
}

- (void)setupBgViewWithTapView:(UIImageView *)tapView
{
    self.bgView.image = tapView.image;
    [UIView animateWithDuration:3.0f animations:^{
        self.bgView.alpha = 1;
        self.effectView.alpha = 0.9;
    }];
    
}

- (UIImage *)cutWithView:(UIView *)cutView rect:(CGRect)rect
{
    // 1.开启图形上下文
    CGSize imageSize = cutView.size;
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    
    // 2.将某个view的所有内容渲染到图形上下文中
    CGContextRef context = UIGraphicsGetCurrentContext();
    [cutView.layer renderInContext:context];
    
    // 3.取得图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    CGImageRef subimageRef = CGImageCreateWithImageInRect(image.CGImage, rect);
    UIImage *subImage = [UIImage imageWithCGImage:subimageRef];
    
    // 4.关闭上下文
    UIGraphicsEndImageContext();
    
    return subImage;
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

#pragma mark  拖动
- (void)pan:(UIPanGestureRecognizer *)pan
{
    // 首先能拖动View
    // 将view动起来。
    UIImageView *panView =  (UIImageView *)pan.view ;
    [self.view insertSubview:panView atIndex:self.view.subviews.count];
    CGPoint panPoint =  [pan translationInView:self.view];
    
    if (pan.state  == UIGestureRecognizerStateBegan) { // 开始
        // 记录frame
        _beginRect = panView.frame;
        // 记录开始拖的view的index
#warning 记录开始拖的view的index
        for (int i = 0; i < self.frames.count; i++) {
            // 开始的点和View都能拿到。
            if ([panView isEqual:self.chaosImgeViewsArrary[i]]) {
                _benginIndex = i;
            }
        }
    }
    else if (pan.state == UIGestureRecognizerStateEnded || pan.state == UIGestureRecognizerStateEnded)
    {
        CGFloat tx =  panView.transform.tx;
        CGFloat ty =  panView.transform.ty;
        if (tx <0)  tx = -panView.transform.tx;
        if (ty <0)  ty = -panView.transform.ty;
        
        // 交换
        // 1.1 距离超过宽高的1半  2. view不在外面。
        CGRect overRect = CGRectMake(0, self.puzzleImgView.y - 20, ScreenWidth, self.puzzleImgView.height + 20);
        
        if ((tx > pan.view.width * 0.5 || ty > pan.view.height * 0.5 ) && CGRectContainsPoint(overRect, pan.view.frame.origin)) {

            int iIndex =  [self closeViewIndexWithPanView:pan.view];
            
            NSLog(@"最靠近的view下标:%d",iIndex);
            // 拿出记录了i值的View 和 现在的交换
            UIImageView *exchagedView = self.chaosImgeViewsArrary[iIndex];
            CGRect exchagedViewFrame = [self.frames[iIndex] CGRectValue];
            
            [self.chaosImgeViewsArrary exchangeObjectAtIndex:iIndex withObjectAtIndex:_benginIndex];
            
            [UIView animateWithDuration:0.5 animations:^{
                panView.frame = exchagedViewFrame;
            }];
            [UIView animateWithDuration:0.25 animations:^{
                exchagedView.frame = _beginRect;
            }];
            
            // 没滑一次 算一下tag
            NSMutableString *tagStr = [NSMutableString string];
            NSMutableString *rightStr = [NSMutableString string];
            for (int i = 0 ; i <self.chaosImgeViewsArrary.count; i ++) {
                UIImageView *imgView =  self.chaosImgeViewsArrary[i];
                UIImageView *rightImgView =  self.imgeViewsArrary[i];
                
                [tagStr appendFormat:@"%ld",imgView.tag];
                [rightStr appendFormat:@"%ld",rightImgView.tag];
            }
            
            if ([tagStr isEqualToString:rightStr]) {
                [self successHanddle];
            }
        }
        else // 回原位
        {
            [UIView animateWithDuration:0.25 animations:^{
                pan.view.transform = CGAffineTransformIdentity;
                //                pan.view.frame = _beginRect;
            }];
        }
    }
    else // 拖拽中
    {    // 要累加
        pan.view.transform = CGAffineTransformTranslate(pan.view.transform, panPoint.x, panPoint.y);
        //         清空transform
        [pan setTranslation:CGPointZero inView:pan.view];
    }
}


- (int)closeViewIndexWithPanView:(UIView *)panView
{
    //    if (panView) {
    //        <#statements#>
    //    }
    /*
     * 交换位置
     * 1. 判断到了第几个imgView就插入
     * 2. 遍历frame 判断x.y 的距离？
     */
    int iIndex = 520 ;
    CGFloat minD = 1000.0;
    // 算出距离最小的i值 拿出那个i
    for (int i = 0; i < self.frames.count ; i ++  ) {
        CGRect rect = [self.frames[i] CGRectValue];
        CGFloat x = rect.origin.x ;
        CGFloat y = rect.origin.y ;
        CGFloat pingfanghe = (x - panView.x) * (x - panView.x) + (y - panView.y) * (y - panView.y);
        // 距离
        CGFloat d =  sqrtf(pingfanghe);
        // 拿出全部的距离比较
        if (d < minD) {
            // 比最小值还小
            minD = d;
            // 记录i
            iIndex = i;
        }
        else
        {
            NSLog(@"-----");
        }
        
    }
    return iIndex;
}

@end
