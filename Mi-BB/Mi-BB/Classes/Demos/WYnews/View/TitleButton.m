//
//  TitleButton.m
//  Mi网易新闻
//
//  Created by YuanMiaoHeng on 15/11/13.
//  Copyright © 2015年 LianJiang. All rights reserved.
//

#import "TitleButton.h"
@implementation TitleButton


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}


+ (instancetype)title:(NSString *)title
{
    TitleButton *titleButton = [[TitleButton alloc] init];
    
    [titleButton setImage:[UIImage imageNamed:@"navbar_netease"]forState:(UIControlStateNormal)];
    [titleButton setTitle:title forState:(UIControlStateNormal)];
    titleButton.titleLabel.font = [UIFont boldSystemFontOfSize:21];
    titleButton.enabled = NO;
    titleButton.adjustsImageWhenHighlighted = NO;
    titleButton.height = titleButton.currentImage.size.height;
    titleButton.width =     [title boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName : titleButton.titleLabel.font} context:nil].size.width + titleButton.currentImage.size.width + 5;
    titleButton.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);

    return titleButton;
}

@end
