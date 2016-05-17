//
//  MiActionCell.m
//  LJMall
//
//  Created by YuanMiaoHeng on 15/10/14.
//  Copyright (c) 2015年 蒋林. All rights reserved.
//

#import "Header.h"
#import "MiActionCell.h"

@interface MiActionCell ()



@end

@implementation MiActionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
 
      
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIButton *titleButton = [UIButton buttonWithType:0];
        [self.contentView addSubview:titleButton];
        [titleButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        self.titleButton = titleButton;
        self.titleButton.titleLabel.font = [UIFont systemFontOfSize:17];
        titleButton.userInteractionEnabled = NO;
        
        UIView *line = [[UIView alloc] init];
        [self.contentView addSubview:line];
        self.line = line;
        line.backgroundColor = MiColor(235, 235, 241);
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.titleButton.x = 0;
    self.titleButton.y = 0;
    self.titleButton.width = self_W;
    self.titleButton.height = self_H;
    
    self.line.height = 1;
    self.line.x = 0;
    self.line.y = self_H - self.line.height;
    self.line.width = self_W;
}


- (void)setFrame:(CGRect)frame
{
    if (self.isCancelCell) {
        frame.origin.y += 5;
    }
    [super setFrame:frame];
}

@end
