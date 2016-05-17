//
//  Product.m
//  Mi瀑布流（CollectionView）
//
//  Created by YuanMiaoHeng on 16/1/19.
//  Copyright © 2016年 LianJiang. All rights reserved.
//

#import "Product.h"

@implementation Product

+ (instancetype)productWithDic:(NSDictionary *)dic
{
    
    return [[Product alloc] initWithDic:dic];
}

- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dic];
        
    }
    return self;
    
}
@end
