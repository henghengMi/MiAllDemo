//
//  CustomTableViewHeaderFooterView.h
//  Esc_QQ好友列表
//
//  Created by 袁妙恒 on 15/7/17.
//  Copyright (c) 2015年 袁妙恒. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FriendGoup;
@class CustomTableViewHeaderFooterView;
// 协议
@protocol CustomTableViewHeaderFooterViewDelegate <NSObject>

- (void) btnClictWithCustomTableViewHeaderFooterView:(CustomTableViewHeaderFooterView *)header;


@end


@interface CustomTableViewHeaderFooterView : UITableViewHeaderFooterView

@property(nonatomic, strong) FriendGoup *friendGoup;

@property(nonatomic, weak) id <CustomTableViewHeaderFooterViewDelegate> delegate;

+ (instancetype) headerFooterViewWithTableView:(UITableView *)tableView;





@end
