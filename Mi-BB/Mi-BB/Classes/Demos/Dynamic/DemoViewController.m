//
//  DemoViewController.m
//  02.UIDynamic演练
//
//  Created by apple on 13-12-24.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "DemoViewController.h"
#import "DemoView.h"
#import "SnapView.h"
#import "PushView.h"
#import "AttachmentView.h"
#import "SpringView.h"
#import "CollisionView.h"

@interface DemoViewController ()

@end

@implementation DemoViewController

//- (void)loadView
//{
//    self.view = [[DemoView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"功能代号： %d", self.function);
    // 在此根据实际的功能代号加载实际的视图
    CGRect rect = CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64);

    DemoView *demoView = nil;
    switch (self.function) {
        case kDemoFunctionSnap:
            demoView = [[SnapView alloc] initWithFrame:rect];
            break;
        case kDemoFunctionPush:
            demoView = [[PushView alloc] initWithFrame:rect];
            break;
        case kDemoFunctionAttachment:
            demoView = [[AttachmentView alloc] initWithFrame:rect];
            break;
        case kDemoFunctionSpring:
            demoView = [[SpringView alloc] initWithFrame:rect];
            break;
        case kDemoFunctionCollision:
            demoView = [[CollisionView alloc] initWithFrame:rect];
            break;
        default:
            break;
    }
    
    [self.view addSubview:demoView];
}


@end
