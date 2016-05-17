//
//  Product.h
//  Mi瀑布流（CollectionView）
//
//  Created by YuanMiaoHeng on 16/1/19.
//  Copyright © 2016年 LianJiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Product : NSObject


@property (nonatomic, assign) CGFloat w;
@property (nonatomic, assign) CGFloat h;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *price;


+ (instancetype)productWithDic:(NSDictionary *)dic;
- (instancetype)initWithDic:(NSDictionary *)dic;

@end
