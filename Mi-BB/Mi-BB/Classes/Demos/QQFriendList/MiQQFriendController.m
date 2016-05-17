//
//  MiQQFriendController.m
//  Mi-BB
//
//  Created by YuanMiaoHeng on 16/4/22.
//  Copyright © 2016年 Mi. All rights reserved.
//

#import "MiQQFriendController.h"
#import "Friend.h"
#import "FriendGoup.h"
#import "CustomTableViewHeaderFooterView.h"
#import "MyCell.h"

@interface MiQQFriendController ()<CustomTableViewHeaderFooterViewDelegate>
@property(nonatomic,strong) NSArray * groups;
@end

@implementation MiQQFriendController

- (NSArray *)groups
{
    
    if (_groups == nil)
    {
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"friends.plist" ofType:nil]];
        
        NSMutableArray *groupArr = [NSMutableArray array];
        
        for (NSDictionary *dic in dictArray) {
            FriendGoup *group = [FriendGoup groupWithDict:dic];
            [groupArr addObject:group];
        }
        
        // 为了安全性;
        _groups = groupArr;
        
    }
    
    return _groups;
    
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 设置tableView的高和头部的高
    self.tableView.rowHeight = 60;
    
    self.tableView.sectionHeaderHeight = 60;
    
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
    
    
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    FriendGoup *g = self.groups[section];
    
    
    
    
    return (g.opened ?  g.friends.count : 0);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MyCell *cell = [MyCell cellWithTableView:tableView];
    
    
    FriendGoup * g = self.groups[indexPath.section];
    
    Friend * f = g.friends[indexPath.row];
    
    cell.aFriend = f;
    
    
    return cell;
    
}


//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//
//    FriendGoup *g = self.groups[section];
//
//    return g.name;
//
//}


#pragma mark - 设置头部的View
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    CustomTableViewHeaderFooterView *header = [CustomTableViewHeaderFooterView headerFooterViewWithTableView:tableView];
    
    // 传递模型
    header.friendGoup = self.groups [section];
    
    header.delegate = self;
    
    return header;
    
}

- (void)btnClictWithCustomTableViewHeaderFooterView:(CustomTableViewHeaderFooterView *)header
{
    [self.tableView reloadData];
    
}


@end
