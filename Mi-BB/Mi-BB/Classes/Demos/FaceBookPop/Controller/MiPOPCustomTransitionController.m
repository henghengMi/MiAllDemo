//
//  MiPOPCustomController.m
//  Mi-BB
//
//  Created by YuanMiaoHeng on 16/5/4.
//  Copyright © 2016年 Mi. All rights reserved.
//

#import "MiPOPCustomTransitionController.h"
#import "PresentingAnimator.h"
#import "DismissingAnimator.h"
#import "ModalViewController.h"

@interface MiPOPCustomTransitionController() <UIViewControllerTransitioningDelegate>

@end

@implementation MiPOPCustomTransitionController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addPresentButton];
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source
{
    return [PresentingAnimator new];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [DismissingAnimator new];
}

#pragma mark - Private Instance methods

- (void)addPresentButton
{
    UIButton *presentButton = [UIButton buttonWithType:UIButtonTypeSystem];
    presentButton.translatesAutoresizingMaskIntoConstraints = NO;
    [presentButton setTitle:@"Present Modal View Controller" forState:UIControlStateNormal];
    [presentButton addTarget:self action:@selector(present:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:presentButton];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:presentButton
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.f
                                                           constant:0.f]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:presentButton
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterY
                                                         multiplier:1.f
                                                           constant:0.f]];
}

- (void)present:(id)sender
{
    ModalViewController *modalViewController = [ModalViewController new];
    modalViewController.transitioningDelegate = self;
    modalViewController.modalPresentationStyle = UIModalPresentationCustom;
    
    [self.navigationController presentViewController:modalViewController
                                            animated:YES
                                          completion:NULL];
}

@end
