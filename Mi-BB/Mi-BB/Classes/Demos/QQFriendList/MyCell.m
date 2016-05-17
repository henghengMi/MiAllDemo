//
//  MyCell.m
//  Esc_QQ好友列表
//
//  Created by 袁妙恒 on 15/7/17.
//  Copyright (c) 2015年 袁妙恒. All rights reserved.
//

#import "MyCell.h"
#import "Friend.h"
@implementation MyCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    
    static NSString * ID = @"cell";
    
    MyCell *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    
    if (header == nil) {
        header = [[MyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    return header;
    
    
}

- (void)setAFriend:(Friend *)aFriend{
   
    _aFriend = aFriend;
    
    self.imageView.image = [UIImage imageNamed:aFriend.icon];
    
    self.textLabel.text = aFriend.name;
    
    self.detailTextLabel.text = aFriend.intro;
    
}

@end
