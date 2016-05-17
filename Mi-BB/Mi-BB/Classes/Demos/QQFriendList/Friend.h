//
//  Friend.h
//  Esc_QQ好友列表
//
//  Created by 袁妙恒 on 15/7/17.
//  Copyright (c) 2015年 袁妙恒. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Friend : NSObject

@property(nonatomic, copy)      NSString    *   icon;

@property(nonatomic, copy)      NSString    *   intro;

@property(nonatomic, copy)      NSString    *   name;

@property(nonatomic, assign ,getter=isVip)    int            vip;

+ (instancetype)friendWithDictionary:(NSDictionary *)dic;

- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end
