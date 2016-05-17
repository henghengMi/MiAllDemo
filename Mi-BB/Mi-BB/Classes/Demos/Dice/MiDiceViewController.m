//
//  MiDiceViewController.m
//  Mi-BB
//
//  Created by YuanMiaoHeng on 16/4/22.
//  Copyright © 2016年 Mi. All rights reserved.
//

#import "MiDiceViewController.h"
#import "MiPop.h"
#import "UIView+Animation.h"
#import "UIView+Spring.h"
@interface MiDiceViewController ()

@property(strong, nonatomic) UIImageView *diceImgView;

@property(strong, nonatomic)NSMutableArray *imgnames;

@property(strong, nonatomic)NSMutableArray *labels;

@property(assign, nonatomic)NSInteger flps;

@property(assign, nonatomic)CGFloat k;

@property(strong, nonatomic)  NSTimer *timer;

@end

@implementation MiDiceViewController


- (NSTimer *)timer
{
    if (_timer == nil) {
        _timer =  [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(timeSel) userInfo:nil repeats:YES];
    }
    return _timer;
}

- (CGFloat)k
{
    if (_k == 0) {
        _k = 1;
    }
    return _k;
}

- (void)timeSel
{
    
    self.k += 0.5 ;
    NSLog(@"k:%f",self.k);
}

- (NSMutableArray *)labels
{
    if (_labels == nil) {
        _labels = [NSMutableArray array];
        
        // 生成4个label
        for (int i = 0; i < 6; i ++) {
            
            UILabel *label = [[UILabel alloc] init];
            label.tag = i + 10;
            CGFloat labelH = 30;
            label.frame = CGRectMake(10, (labelH+10) * i + 20, self.view.frame.size.width - 20, labelH);
            [self.view addSubview:label];
            [_labels addObject:label];
            label.textColor = [UIColor tealColor];
        }
        
    }
    return _labels;
}

- (NSMutableArray *)imgnames
{
    if (_imgnames == nil) {
        _imgnames = [NSMutableArray array];
        
        // img加进数组
        for (int i = 0 ; i < 6; i++) {
            NSString *imgname = [NSString stringWithFormat:@"dice_img_%d",i];
            UIImage *img = [UIImage imageNamed:imgname];
            [self.imgnames addObject:img];
        }
        
    }
    return _imgnames;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self setupDiceImageView];
    [self setupClearButton];
    
}

- (void)setupClearButton
{
    UIButton *clearBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, ScreenHeight - 64 - 44 - 20, ScreenWidth - 40, 44)];
    [self.view addSubview:clearBtn];
    [clearBtn addTarget:self action:@selector(clearBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [clearBtn setTitle:@"Clear" forState:(UIControlStateNormal)];
    [clearBtn setTitleColor:MiRandomColor forState:(UIControlStateNormal)];
    clearBtn.layer.borderWidth = 1;
    clearBtn.layer.borderColor = MiRandomColor.CGColor;
}

- (void)setupDiceImageView
{
    self.diceImgView = [[UIImageView alloc] init];
    self.diceImgView.frame = CGRectMake((ScreenWidth - 40) * 0.5, ScreenHeight * 0.5 + 30, 40, 40);
    self.diceImgView.contentMode = UIViewContentModeScaleAspectFit;
    
    // 设置初始图片
    self.diceImgView.image = self.imgnames[0];
    // 数组里面要装images
    self.diceImgView.animationImages = self.imgnames;
    
    self.diceImgView.animationDuration = 0.25;
    [self.view addSubview:self.diceImgView];
}

#pragma mark - 点击开始
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [MiPop removeAllofLabel];
    [MiPop removeAllsAnimation];
    [self.diceImgView startAnimating];
    
    // 计算按住秒数，K随着时间越长就越大
    self.timer;
    
}


#pragma mark - 点击结束
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 停止、清空定时器
    [self.timer invalidate];
    self.timer = nil;
    
    
    // 色子上跳
    [self.diceImgView SpringFromOriginalToDx:0 endDy: (- (100) )];
    
    
    
    //
    //    [self.diceImgView SpringFromOriginalToDx:0 endDy: (- (2 * self.k) )];
    //    [self.diceImgView SpringFromOriginalToDx:0 endDy: (+ (2 * self.k) )];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 色子下跳
        [self.diceImgView SpringFromOriginalToDx:0 endDy:+ (100 )];
        
        // 显示
        for (UILabel *label in self.labels) {
            
            label.alpha = 1;
            
        }
        
        // 停止动画
        [self.diceImgView stopAnimating];
        // 随机数
        int randomNum = arc4random_uniform(6) + 1;
        
        // 随机一张
        self.diceImgView.image = self.imgnames[randomNum - 1];
        
        // 从数组拿出label
        UILabel *currenLabel =  self.labels[self.flps];
        
        // 设置label的 text
        currenLabel.text = [NSString stringWithFormat:@"第%ld位屌丝的点数为:%d",self.flps + 1,randomNum ];
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:currenLabel.text];
        [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:40] range:NSMakeRange(currenLabel.text.length- 1, 1)];
        [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor cinnamonColor] range:NSMakeRange(currenLabel.text.length- 1, 1)];
        currenLabel.attributedText = attrStr;
        
        // 为label弹出增加动画
        currenLabel.alpha = 0;
        [UIView animateWithDuration:1.5 animations:^{
            currenLabel.alpha = 1;
        }];
        
        
        // 弹出处理
        if ((randomNum ) <=2 ) {
            [MiPop showKaca:[NSString stringWithFormat:@"😱%d",randomNum ]];
        }
        
        
        else if((randomNum ) >=3 && (randomNum ) <=5 )
        {
            [MiPop show:[NSString stringWithFormat:@"😜%d",randomNum ]];
            //  [MiPop showFade:[NSString stringWithFormat:@"😘😘😘%d",randomNum + 1]];
        }
        else
        {
            [MiPop showCongratulate:[NSString stringWithFormat:@"🙏%d",randomNum ]];
        }
        
        // 计数
        self.flps++;
        
        if (self.flps == 6) {
            self.flps = 0;
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.diceImgView zoomWithDuration:1 repeatCount:1 values:@[@1,@10,@1]];
        });
        
    });
    
    // 系数置1
    self.k = 1;
    
}

#pragma mark - 清空
- (void)clearBtnClick:(id)btn {
    for (UILabel *label in self.labels) {
        
        label.alpha = 0;
        label.text = @"";
        self.flps = 0;
        
    }
    [MiPop removeAllsAnimation];
    [MiPop removeAllofLabel];
    
}
@end
