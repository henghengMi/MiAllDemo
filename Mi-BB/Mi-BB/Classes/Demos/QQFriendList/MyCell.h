//
//  MyCell.h
//  Esc_QQ好友列表
//
//  Created by 袁妙恒 on 15/7/17.
//  Copyright (c) 2015年 袁妙恒. All rights reserved.
//

#import <UIKit/UIKit.h>


@class Friend;
@interface MyCell : UITableViewCell


@property(nonatomic, strong) Friend *aFriend;

+ (instancetype)cellWithTableView:(UITableView *)tableView;


@end
