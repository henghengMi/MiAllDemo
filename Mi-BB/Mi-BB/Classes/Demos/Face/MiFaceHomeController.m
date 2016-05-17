//
//  MiFaceHomeController.m
//  Mi-BB
//
//  Created by YuanMiaoHeng on 16/4/28.
//  Copyright © 2016年 Mi. All rights reserved.
//

#import "MiFaceHomeController.h"

#import "MiFaceCutHeadController.h"
#import "MiAddGlassesViewController.h"
@interface MiFaceHomeController ()
@property(nonatomic,strong)NSArray *titles;
@property(nonatomic,strong)NSArray *dataArray;
@property(nonatomic,strong)NSArray *vcs;

@end

@implementation MiFaceHomeController


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
    self.titles = @[@"剪切头像",@"戴眼镜"];
    self.vcs = @[
                 [MiFaceCutHeadController class],
                 [MiAddGlassesViewController class]
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
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
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
