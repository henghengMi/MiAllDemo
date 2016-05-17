//
//  DynamicViewController.m
//  Mi-BB
//
//  Created by YuanMiaoHeng on 16/4/21.
//  Copyright © 2016年 Mi. All rights reserved.
//

#import "DynamicViewController.h"

#import "DemoViewController.h"

@interface DynamicViewController ()
{
    // 功能名称的数组
    NSArray *_functions;
}
@end

@implementation DynamicViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _functions = @[@"吸附行为", @"推动行为", @"刚性附加行为", @"弹性附加行为", @"碰撞检测"];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _functions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"id";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.textLabel.text = _functions[indexPath.row];
    
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


#pragma mark - 代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DemoViewController *controller = [[DemoViewController alloc] init];
    
    // 指定标题
    controller.title = _functions[indexPath.row];
    controller.function = indexPath.row;
    
    [self.navigationController pushViewController:controller animated:YES];
}


@end
