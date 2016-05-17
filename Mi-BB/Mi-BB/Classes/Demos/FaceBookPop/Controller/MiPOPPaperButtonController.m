//
//  MiPOPPaperButtonController.m
//  Mi-BB
//
//  Created by YuanMiaoHeng on 16/5/4.
//  Copyright © 2016年 Mi. All rights reserved.
//


#import "MiPOPPaperButtonController.h"
#import "PaperButton.h"
#import <POP/POP.h>
#import "UIColor+CustomColors.h"

@interface MiPOPPaperButtonController()
@property(nonatomic) UILabel *titleLabel;
- (void)addBarButton;
- (void)addTitleLabel;
- (void)animateTitleLabel:(id)sender;
- (void)setTitleLabel;
@end

@implementation MiPOPPaperButtonController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addBarButton];
    [self addTitleLabel];
}

# pragma mark - Private Instance methods

- (void)addBarButton
{
    PaperButton *button = [PaperButton button];
    [button addTarget:self action:@selector(animateTitleLabel:) forControlEvents:UIControlEventTouchUpInside];
    button.tintColor = [UIColor raspberryColor];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    self.navigationItem.rightBarButtonItem = barButton;
}

- (void)addTitleLabel
{
    self.titleLabel = [UILabel new];
    self.titleLabel.font = [UIFont fontWithName:@"Avenir-Light" size:26.f];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = [UIColor customGrayColor];
    [self setTitleLabel];
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.titleLabel];
    
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"H:|-[_titleLabel]-|"
                               options:0
                               metrics:nil
                               views:NSDictionaryOfVariableBindings(_titleLabel)]];
    
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"V:|-(80)-[_titleLabel]"
                               options:0
                               metrics:nil
                               views:NSDictionaryOfVariableBindings(_titleLabel)]];
}

- (void)animateTitleLabel:(id)sender
{
        CGFloat toValue = CGRectGetMidX(self.view.bounds);
    
        POPSpringAnimation *onscreenAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionX];
        onscreenAnimation.toValue = @(toValue);
        onscreenAnimation.springBounciness = 10.f;
    
        POPBasicAnimation *offscreenAnimation = [POPBasicAnimation easeInAnimation];
        offscreenAnimation.property = [POPAnimatableProperty propertyWithName:kPOPLayerPositionX];
        offscreenAnimation.toValue = @(-toValue);
        offscreenAnimation.duration = 0.2f;
        [offscreenAnimation setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
            [self setTitleLabel];
            [self.titleLabel.layer pop_addAnimation:onscreenAnimation forKey:@"onscreenAnimation"];
        }];
        [self.titleLabel.layer pop_addAnimation:offscreenAnimation forKey:@"offscreenAnimation"];
}

- (void)setTitleLabel
{
    NSString *title = @"List";
    if ([self.titleLabel.text isEqualToString:title]) {
        title = @"Menu";
    }
    self.titleLabel.text = title;
}

@end
