//
//  MiCircleLayout.m
//  CollectionView自定义布局01
//
//  Created by YuanMiaoHeng on 16/1/19.
//  Copyright © 2016年 LianJiang. All rights reserved.
//  圆形布局

#import "MiCircleLayout.h"

@implementation MiCircleLayout

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    // 主要算出每一个Item的中点。
    
    
    attr.size = CGSizeMake(50, 50);
    
    // 半径
    CGFloat radius = 80;
    
    // 圆心
    CGPoint radiusCenter = CGPointMake(self.collectionView.frame.size.width * 0.5, self.collectionView.frame.size.height * 0.5);
    
    // 平均角度
    CGFloat avgAngle = M_PI * 2 / [self.collectionView numberOfItemsInSection:0];
    
    // 每个item的角度
    CGFloat angle = indexPath.item * avgAngle;
    
    // 每一个Item的中点。
    attr.center = CGPointMake(radiusCenter.x + radius * cosf(angle), radiusCenter.y - radius * sinf(angle));

    return attr;
}


- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < [self.collectionView numberOfItemsInSection:0]; i ++) {
        UICollectionViewLayoutAttributes *attr = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        [array addObject:attr];
    }
    return array;
}


@end
