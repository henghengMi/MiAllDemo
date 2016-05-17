//
//  MiFaceBookPOPHomeController.m
//  Mi-BB
//
//  Created by YuanMiaoHeng on 16/5/4.
//  Copyright © 2016年 Mi. All rights reserved.
//

#import "MiFaceBookPOPHomeController.h"
#import "MiPOPButtonController.h"
#import "MiPOPCasualController.h"
#import "MiPOPDecayController.h"
#import "MiHomeCell.h"
#import "MiPOPCircleController.h"
#import "MiPOPImageController.h"
#import "MiPOPCustomTransitionController.h"
#import "MiPOPPaperButtonController.h"
#import "MiPOPFoldController.h"
#import "MiPOPPasswordIndicatorController.h"
#import "MiPOPFlatButtonController.h"

@interface MiFaceBookPOPHomeController ()
@property(nonatomic,strong)NSArray *titles;
@property(nonatomic,strong)NSArray *dataArray;
@property(nonatomic,strong)NSArray *vcs;
@end

@implementation MiFaceBookPOPHomeController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initData];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}


- (void)initData
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Face";
    self.titles = @[@"MiCasual",@"Button",@"Decay",@"Circle",@"image",@"customTransition",@"paperButton",@"Fold",@"PasswordIndicate",@"FlatButton"];
    self.vcs = @[
                 [MiPOPCasualController class],
                 [MiPOPButtonController class],
                 [MiPOPDecayController class],
                 [MiPOPCircleController class],
                 [MiPOPImageController class],
                 [MiPOPCustomTransitionController class],
                 [MiPOPPaperButtonController class],
                 [MiPOPFoldController class],
                 [MiPOPPasswordIndicatorController class],
                 [MiPOPFlatButtonController class]
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
    static NSString *ID = @"faceHome";
    
    MiHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[MiHomeCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
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
