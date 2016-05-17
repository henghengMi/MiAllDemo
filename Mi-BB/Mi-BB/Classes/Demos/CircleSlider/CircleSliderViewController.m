//
//  CircleSliderViewController.m
//  Mi-BB
//
//  Created by YuanMiaoHeng on 16/4/20.
//  Copyright © 2016年 Mi. All rights reserved.
//

#import "CircleSliderViewController.h"
#import "CircleSlider.h"
@interface CircleSliderViewController ()

@end

@implementation CircleSliderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor pinkLipstickColor];
    
    CGFloat margin = 29;
    CircleSlider *slider = [[CircleSlider alloc] initWithFrame:CGRectMake(margin, 100, ScreenWidth - margin * 2, ScreenWidth - margin * 2)];
    [self.view addSubview:slider];
    slider.backgroundColor = [UIColor clearColor];
    [slider addTarget:self action:@selector(SliderValuechanged:) forControlEvents:(UIControlEventValueChanged)];

}

- (void)SliderValuechanged:(CircleSlider *)slider
{
    NSLog(@"%f",slider.currentValue);
}


@end
