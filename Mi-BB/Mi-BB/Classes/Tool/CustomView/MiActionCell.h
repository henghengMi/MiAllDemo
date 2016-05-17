//
//  MiActionCell.h
//  LJMall
//
//  Created by YuanMiaoHeng on 15/10/14.
//  Copyright (c) 2015年 蒋林. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MiActionCell : UITableViewCell

@property(nonatomic, weak) UIButton *titleButton ;
@property(nonatomic, assign ,getter = isCancelCell) BOOL cancelCell ;
@property(nonatomic, weak) UIView *line;
@end
