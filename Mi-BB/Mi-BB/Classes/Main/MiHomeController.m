//
//  MiHomeController.m
//  Mi-BB
//
//  Created by YuanMiaoHeng on 16/4/19.
//  Copyright © 2016年 Mi. All rights reserved.
//

#import "MiHomeController.h"
#import "MiHomeCell.h"

#import "MiPuzzleController.h"
#import "BoomViewController.h"
#import "CircleSliderViewController.h"
#import "MiCutImageController.h"
#import "MiWaterViewController.h"
#import "DynamicViewController.h"
#import "MiGradientCircleController.h"
#import "MiQQFriendController.h"
#import "MiDiceViewController.h"
#import "MiGraffitiController.h"
#import "MiWYNewsHomeController.h"
#import "MiAccelerometerController.h"
#import "MiCustomLayoutController.h"
#import "MiWhereMeController.h"
#import "MiNavigationHanddleController.h"
#import "JXTNavigationController.h"
#import "MiYYKitUseController.h"
#import "MiFaceHomeController.h"
#import "MiYYTextHomeViewController.h"
#import "MiFaceBookPOPHomeController.h"
#import "MiAsynDisplayKitDemoController.h"

@interface MiHomeController ()

@property(nonatomic,strong)NSArray *titles;
@property(nonatomic,strong)NSArray *dataArray;
@property(nonatomic,strong)NSArray *vcs;

@end

@implementation MiHomeController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initData];
    [self setupNavgation];
    [self.navigationController pushViewController:[[MiFaceBookPOPHomeController alloc] init] animated:YES];
}

-(void)setupNavgation
{
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:[UIButton LJTitleButtonWithTitle:@"网易" target:self selector:@selector(navleftBtnClick)]];
    self.navigationItem.leftBarButtonItem  = leftItem;
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:[UIButton LJTitleButtonWithTitle:@"玩导航" target:self selector:@selector(navrightBtnClick)]];
    self.navigationItem.rightBarButtonItem  = rightItem;
    
}

- (void)navrightBtnClick
{
    MiNavigationHanddleController * vc = [[MiNavigationHanddleController alloc] init];
    JXTNavigationController * nav = [[JXTNavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)navleftBtnClick
{
    [self presentViewController:[[MiWYNewsHomeController alloc] init] animated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}


- (void)initData
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"BB";
    self.titles = @[@"FaceBook POP",@"AsynDisplayKitDemo",@"puzzle",@"boom",@"CircleSlider",@"MiGradientCircle",@"cutImageAnimation",@"Water",@"Dynamic",@"QQFriendList",@"Dice",@"Graffiti",@"加速计",@"自定义布局",@"我在哪里？",@"YYKit使用",@"人脸"];
    self.vcs = @[[MiFaceBookPOPHomeController class],
                 [MiAsynDisplayKitDemoController class],
                 [MiPuzzleController class],
                 [BoomViewController class],
                 [CircleSliderViewController class],
                 [MiGradientCircleController class],
                 [MiCutImageController class],
                 [MiWaterViewController class],
                 [DynamicViewController class],
                 [MiQQFriendController class],
                 [MiDiceViewController class],
                 [MiGraffitiController class],
                 [MiAccelerometerController class],
                 [MiCustomLayoutController class],
                 [MiWhereMeController class],
                 [MiYYKitUseController class],
                 [MiFaceHomeController class]
                 ];
}

#pragma mark tableView dataSource & dalegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"Home";
    
    MiHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) cell = [[MiHomeCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    cell.textLabel.text = self.titles[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    Class vc = self.vcs[indexPath.row];
    if (vc) {
        UIViewController *viewController = [[vc alloc] init];
        [self.navigationController pushViewController:viewController animated:YES];
        viewController.title = self.titles[indexPath.row];
    }
}

@end
