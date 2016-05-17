//
//  NSString+SizeWithFont.m
//  01-QQ聊天布局
//
//  Created by 袁妙恒 on 15/7/16.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "NSString+SizeWithFont.h"

@implementation NSString (SizeWithFont)
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}
@end
