//
//  MiPOPFoldController.m
//  Mi-BB
//
//  Created by YuanMiaoHeng on 16/5/4.
//  Copyright © 2016年 Mi. All rights reserved.
//

#import "MiPOPFoldController.h"
#import "FoldingView.h"

@interface MiPOPFoldController()
- (void)addFoldView;
@property(nonatomic) FoldingView *foldView;
@end

@implementation MiPOPFoldController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addFoldView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.foldView poke];
}

#pragma mark - Private instance methods

- (void)addFoldView
{
    CGFloat padding = 30.f;
    CGFloat width = CGRectGetWidth(self.view.bounds) - padding * 2;
    CGRect frame = CGRectMake(0, 0, width, width  );
    
    self.foldView = [[FoldingView alloc] initWithFrame:frame
                                                 image:[UIImage imageNamed:@"icon1"]];
    self.foldView.center = CGPointMake(self.view.centerX, self.view.centerY - 64);
    [self.view addSubview:self.foldView];
}

@end


