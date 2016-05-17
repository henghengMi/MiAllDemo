//
//  MiPOPFlatButtonController.m
//  Mi-BB
//
//  Created by YuanMiaoHeng on 16/5/4.
//  Copyright © 2016年 Mi. All rights reserved.
//


#import "MiPOPFlatButtonController.h"
#import "VBFPopFlatButton.h"

#define NUM_BUTTON_STATES 21

@interface MiPOPFlatButtonController ()
@property (nonatomic, strong) VBFPopFlatButton *flatRoundedButton;
@property (nonatomic, strong) VBFPopFlatButton *flatPlainButton;

@end

@implementation MiPOPFlatButtonController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor robinEggColor];
    

    [self addFlatRoundedBtn];
    [self addflatPlainBtn];
    [self addTypeButton];
}

- (void)addTypeButton
{
    int row = 7;
    int clumns = 3;
    int flap = 8.0f;
    CGFloat w = (ScreenWidth - (clumns +1) * flap) / clumns;
    CGFloat h = 44;
    
    UIButton *okBtn = [UIButton buttonWithType:0];
    [self.view addSubview:okBtn];
    [okBtn setTitle:@"Random" forState:(UIControlStateNormal)];
    [okBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [okBtn addTarget:self action:@selector(buttonPressed:) forControlEvents:(UIControlEventTouchUpInside)];
    okBtn.tag = NUM_BUTTON_STATES;
    okBtn.backgroundColor = MiRandomColor;
    okBtn.frame = CGRectMake((ScreenWidth - w) * 0.5, 140, w, h);
    
    
    NSArray *titles = @[
                        @"丨",@"＋",@"一",
                        @"x",@"<",@">",
                        @"三",@"Down",@"↑",
                        @"⌄",@"⌃",@"↓",
                        @"丨丨",@"▷",@"◁",
                        @"△",@"▽",@"✓",
                        @"<<",@">>",@"☐"
                        ];
    
    for (int i = 0; i < 21; i ++) {

        int xI = i % clumns;
        int yI = i / clumns;
        UIButton *button = [UIButton buttonWithType:0];
        button.tag = i;
        [button setTitle:titles[i] forState:(UIControlStateNormal)];
        [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        button.frame = CGRectMake(xI * (w + flap) + flap, yI * (h + flap) + 200, w, h);
        button.backgroundColor = MiRandomColor;
        [self.view addSubview:button];
        [button addTarget:self action:@selector(buttonPressed:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    
    
}

#pragma mark addFlatRoundedBtn
- (void)addFlatRoundedBtn
{
    self.flatRoundedButton = [[VBFPopFlatButton alloc]initWithFrame:CGRectMake(120, 50, 30, 30)
                                                         buttonType:buttonMenuType
                                                        buttonStyle:buttonRoundedStyle
                                              animateToInitialState:YES];
    self.flatRoundedButton.roundBackgroundColor = [UIColor whiteColor];
    self.flatRoundedButton.lineThickness = 3;
    self.flatRoundedButton.lineRadius = 1;
    self.flatRoundedButton.tintColor = [UIColor robinEggColor];
    [self.flatRoundedButton addTarget:self
                               action:@selector(flatRoundedButtonPressed)
                     forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.flatRoundedButton];
}

#pragma mark addflatPlainBtn
- (void)addflatPlainBtn
{
    self.flatPlainButton = [[VBFPopFlatButton alloc]initWithFrame:CGRectMake(220, 50, 30, 30)
                                                       buttonType:buttonAddType
                                                      buttonStyle:buttonPlainStyle
                                            animateToInitialState:NO];
    self.flatPlainButton.lineThickness = 2;
    self.flatPlainButton.tintColor = [UIColor whiteColor];
    [self.flatPlainButton addTarget:self
                             action:@selector(flatPlainButtonPressed)
                   forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.flatPlainButton];
}

- (void)buttonPressed:(UIButton *)sender {
    if (sender.tag != NUM_BUTTON_STATES) {
        [self.flatRoundedButton animateToType:sender.tag];
        [self.flatPlainButton animateToType:sender.tag];
    } else {
        [self.flatRoundedButton animateToType:arc4random() % NUM_BUTTON_STATES];
        [self.flatPlainButton animateToType:arc4random() % NUM_BUTTON_STATES];
    }
}

- (void) flatRoundedButtonPressed {
    NSLog(@"Button pressed");
    [self.flatRoundedButton animateToType:arc4random() % NUM_BUTTON_STATES];
}

- (void) flatPlainButtonPressed {
    NSLog(@"Button pressed");
    [self.flatPlainButton animateToType:arc4random() % NUM_BUTTON_STATES];
}

@end
