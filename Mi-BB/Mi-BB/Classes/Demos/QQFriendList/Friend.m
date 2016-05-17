//
//  Friend.m
//  Esc_QQ好友列表
//
//  Created by 袁妙恒 on 15/7/17.
//  Copyright (c) 2015年 袁妙恒. All rights reserved.
//

#import "Friend.h"

@implementation Friend


+ (instancetype)friendWithDictionary:(NSDictionary *)dic{
    
    
    return [[self alloc] initWithDictionary:dic];
    
}

- (instancetype)initWithDictionary:(NSDictionary *)dic{
    
    
    if ( self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dic]; // 用KVC把字典里面的值赋给模型的属性
        
    }
    return self;
}


@end
