//
//  CustomTableViewHeaderFooterView.m
//  Esc_QQ好友列表
//
//  Created by 袁妙恒 on 15/7/17.
//  Copyright (c) 2015年 袁妙恒. All rights reserved.
//

#import "CustomTableViewHeaderFooterView.h"
#import "FriendGoup.h"
@interface CustomTableViewHeaderFooterView()

@property(nonatomic, weak) UILabel * rightlabel;

@property(nonatomic, weak) UIButton * button;


@end


@implementation CustomTableViewHeaderFooterView

+ (instancetype) headerFooterViewWithTableView:(UITableView *)tableView
{
    static NSString * ID = @"header";
    
    CustomTableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    
    if (header == nil) {
        header = [[CustomTableViewHeaderFooterView alloc] initWithReuseIdentifier:ID];
    }
    
    return header;
    
}


- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithReuseIdentifier:reuseIdentifier]) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:button];
        self.button = button;
        button.contentMode = UIViewContentModeLeft;
        [button setImage:[UIImage imageNamed:@"buddy_header_arrow"] forState:(UIControlStateNormal)];
        [button setBackgroundImage:[UIImage imageNamed:@"buddy_header_bg"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"buddy_header_bg_highlighted"] forState:UIControlStateHighlighted];
//        [button setTitle:@"我的好友" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(btnClict) forControlEvents:UIControlEventTouchUpInside];
        // 左对齐+内边距调整
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//        button.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0,10);
        button.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        
        // 设置三角形图片转换时不变形
        button.imageView.contentMode = UIViewContentModeScaleAspectFill;
        
        // 超出范围就剪掉。设为NO 就不剪
        button.clipsToBounds = NO;
        
        
        UILabel *label = [[UILabel alloc] init];
        [self.contentView addSubview:label];
        label.textAlignment = NSTextAlignmentRight;
        self.rightlabel = label;
        
    }
    
    return self;
    
}

#pragma mark - 按钮点击之后取反 + 通知控制器刷新代理方法
- (void)btnClict
{
    self.friendGoup.opened = !self.friendGoup.isOpened;
    
//    [self chagngedTrangle];
    
    if ([self.delegate respondsToSelector:@selector(btnClictWithCustomTableViewHeaderFooterView:)]) {
        
        [self.delegate btnClictWithCustomTableViewHeaderFooterView:self];
    }
   
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.button.frame = self.bounds;
    
    
    CGFloat labelY = 0;
    CGFloat labelW = 150;
    CGFloat labelH = self.frame.size.height;
    CGFloat labelX = self.frame.size.width - 10 - labelW;
    
    self.rightlabel.frame = CGRectMake(labelX, labelY, labelW, labelH);
    
}



- (void)setFriendGoup:(FriendGoup *)friendGoup
{
    
    _friendGoup = friendGoup;
    
    [self.button setTitle:friendGoup.name forState:UIControlStateNormal];
    
    
    self.rightlabel.text = [NSString stringWithFormat:@"%d/%ld",friendGoup.online,friendGoup.friends.count];
    
}


#pragma mark - 一个控件被加到父控件的时候会被调用
//- (void)chagngedTrangle
//{
//    // 在这里把三角形转过来
//    
//    if (self.friendGoup.isOpened) {
//         NSLog(@"开");
//        [UIView animateWithDuration:0.25 animations:^{
//            
//            self.button.imageView.transform = CGAffineTransformMakeRotation(M_PI_2);
//            
//        }];
//    }
//    else
//    {
//         NSLog(@"关");
//        [UIView animateWithDuration:0.25 animations:^{
//            
//            self.button.imageView.transform = CGAffineTransformMakeRotation(0);
//            
//        }];
//    }
//}




@end
