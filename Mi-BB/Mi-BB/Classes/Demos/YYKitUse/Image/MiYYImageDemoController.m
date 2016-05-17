//
//  MiYYImageDemoController.m
//  Mi-BB
//
//  Created by YuanMiaoHeng on 16/4/26.
//  Copyright © 2016年 Mi. All rights reserved.
//

#import "MiYYImageDemoController.h"
#import "MiYYImageDisplayController.h"
#import "MiYYImageProgressController.h"
#import "MiYYKitPhotoBrowserController.h"
#import "MiYYWebImageController.h"

@interface MiYYImageDemoController ()
@property(nonatomic,strong)NSArray *titles;
@property(nonatomic,strong)NSArray *vcs;
@end

@implementation MiYYImageDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
}

- (void)initData
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"YY图片Demo";
    self.titles = @[@"图片浏览",@"图片轮播/gif",@"图片加载",@"网络加载"];
    self.vcs = @[
                 [MiYYKitPhotoBrowserController class],
                 [MiYYImageDisplayController class],
                 [MiYYImageProgressController class],
                 [MiYYWebImageController class]
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
    static NSString *ID = @"id";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
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
