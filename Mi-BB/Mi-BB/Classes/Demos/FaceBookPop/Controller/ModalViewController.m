//
//  ModalViewController.m
//  Popping
//
//  Created by André Schneider on 16.05.14.
//  Copyright (c) 2014 André Schneider. All rights reserved.
//

#import "ModalViewController.h"
#import "UIColor+CustomColors.h"
#import "Masonry.h"
#import "VBFDownloadButton.h"
#import "VBFPopUpMenu.h"

@interface ModalViewController()
@property (nonatomic, strong) NSMutableArray *subviews;
- (void)addDismissButton;
- (void)dismiss:(id)sender;
@end

@implementation ModalViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self add2Divisions];
    self.view.layer.cornerRadius = 8.f;
    self.view.backgroundColor = [UIColor customBlueColor];
    [self addDismissButton];
    
//    [self addimageView];
}

- (void)addimageView
{
    UIImageView *imgView = [[UIImageView alloc] init];
    imgView.image = [UIImage imageNamed:@"ttbb"];
    imgView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:imgView];
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(100);
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(self.view.mas_centerY);
    }];
    
}

#pragma mark - Private Instance methods

- (void)addDismissButton
{
    UIButton *dismissButton = [UIButton buttonWithType:UIButtonTypeSystem];
    dismissButton.translatesAutoresizingMaskIntoConstraints = NO;
    dismissButton.tintColor = [UIColor whiteColor];
    dismissButton.titleLabel.font = [UIFont fontWithName:@"Avenir" size:20];
    [dismissButton setTitle:@"Dismiss" forState:UIControlStateNormal];
    [dismissButton addTarget:self action:@selector(dismiss:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dismissButton];

    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:dismissButton
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.f
                                                           constant:0.f]];

    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"V:[dismissButton]-|"
                               options:0
                               metrics:nil
                               views:NSDictionaryOfVariableBindings(dismissButton)]];
}

- (void)dismiss:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}




- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
 
    [self addControls];
    
}

- (void) add2Divisions {
    for (int i = 0; i < 2; i++) {
        CGSize subviewSize = CGSizeMake(CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) / 2 - 30);
        UIView *subScreen = [[UIView alloc]initWithFrame:CGRectMake(0,
                                                                    i * subviewSize.height,
                                                                    subviewSize.width,
                                                                    subviewSize.height )];
        subScreen.backgroundColor = [UIColor yellowGreenColor];
        subScreen.layer.borderColor = [UIColor customBlueColor].CGColor;
        subScreen.layer.borderWidth = 1.0;
        [self.view addSubview:subScreen];
        if (!self.subviews) {
            self.subviews = [[NSMutableArray alloc]initWithObjects:subScreen, nil];
        } else {
            [self.subviews addObject:subScreen];
        }
    }
}

- (void) addControls {
    
    //Download control
    UIView *firstView = self.subviews[0];
    
    
    
    VBFDownloadButton *downloadButton = [[VBFDownloadButton alloc]initWithButtonDiameter:60
                                                                                  center:firstView.center
                                                                                   color:[UIColor salmonColor]
                                                                       progressLineColor:[UIColor oldLaceColor]
                                                                            downloadIcon:[UIImage imageNamed:@"ttbb"]
                                                                      progressViewLength:ScreenWidth - 10];
    [self.view addSubview:downloadButton];
   
    
    // 弹出菜单
    UIView *secondView = self.subviews[1];

    NSArray *icons = @[[UIImage imageNamed:@"icon1"],[UIImage imageNamed:@"icon2"],[UIImage imageNamed:@"icon3"],[UIImage imageNamed:@"ttbb"]];
     VBFPopUpMenu *popUp = [[VBFPopUpMenu alloc]initWithFrame:secondView.frame
                                                   direction:M_PI
                                                   iconArray:icons];
    [self.view addSubview:popUp];
}



- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    for (UIView *subview in self.subviews) {
        [subview removeFromSuperview];
    }
}


@end
