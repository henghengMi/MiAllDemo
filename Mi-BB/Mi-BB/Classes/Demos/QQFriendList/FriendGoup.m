//
//  FriendGoup.m
//  Esc_QQ好友列表
//
//  Created by 袁妙恒 on 15/7/17.
//  Copyright (c) 2015年 袁妙恒. All rights reserved.
//

#import "FriendGoup.h"
#import "Friend.h"
@implementation FriendGoup


+ (instancetype)groupWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        // 1.注入所有属性
        [self setValuesForKeysWithDictionary:dict];
        
        // 2.特殊处理friends属性
        NSMutableArray *friendArray = [NSMutableArray array];
        for (NSDictionary *dict in self.friends) {
            Friend *friend = [Friend friendWithDictionary:dict];
            [friendArray addObject:friend];
        }
        self.friends = friendArray;
    }

    return self;
}



@end
