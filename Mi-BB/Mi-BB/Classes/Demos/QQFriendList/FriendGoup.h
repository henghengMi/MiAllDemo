//
//  FriendGoup.h
//  Esc_QQ好友列表
//
//  Created by 袁妙恒 on 15/7/17.
//  Copyright (c) 2015年 袁妙恒. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Friend.h"
@interface FriendGoup : NSObject



@property (nonatomic, copy) NSString *name;
/**
 *  数组中装的都是MJFriend模型
 */
@property (nonatomic, strong) NSArray *friends;
@property (nonatomic, assign) int online;


@property (nonatomic, assign , getter=isOpened) BOOL  opened;


+ (instancetype)groupWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;

@end
