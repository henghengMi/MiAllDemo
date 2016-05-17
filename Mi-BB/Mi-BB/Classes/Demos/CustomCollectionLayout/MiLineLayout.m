//
//  MiLineLayout.m
//  CollectionView自定义布局01
//
//  Created by YuanMiaoHeng on 16/1/18.
//  Copyright © 2016年 LianJiang. All rights reserved.
//

#import "MiLineLayout.h"



static const CGFloat itemWH = 100;

@implementation MiLineLayout

- (instancetype)init
{
    if ([super init]) {

    }
    return self;
}

- (void)prepareLayout
{
    [super prepareLayout];
    
    self.itemSize = CGSizeMake(itemWH, itemWH);
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.minimumLineSpacing = 80;
    
    // 1. 开头和末尾切掉一半（第一和最后显示在中间）
    CGFloat inset = (self.collectionView.bounds.size.width - self.itemSize.width) * 0.5;
    self.sectionInset = UIEdgeInsetsMake(0, inset, 0, inset);
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

/**
 *  用来设置collectionView停止滚动那一刻的位置
 *  proposedContentOffset  原本collectionView停止滚动的那一刻的位置
 *  返回值为 停留在什么位置（contenOffset）
 *  velocity : 滚动速度（左右）
 */
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    // 应该算出最后停留的中点X 和 当前可视范围中哪几个item的中点的X距离 最短
    
    // 1.最后停留的中点X
    CGFloat centX = proposedContentOffset.x + self.collectionView.bounds.size.width * 0.5;
    
    // 最后停留的矩形范围
    CGRect lastRect ;
    lastRect.origin = proposedContentOffset;
    lastRect.size = self.collectionView.frame.size;

    // 取出这个范围内的属性
    NSArray *array =  [self layoutAttributesForElementsInRect:lastRect];
    
    // 取出距离最小的那个item
    CGFloat adjustOffsetX = MAXFLOAT;
    for (UICollectionViewLayoutAttributes *attr in array) {
        // 求出最小的距离
        if ( ABS(attr.center.x - centX) < ABS(adjustOffsetX)) {
            adjustOffsetX = attr.center.x - centX;
        }
    }
    return CGPointMake(adjustOffsetX + proposedContentOffset.x, proposedContentOffset.y);
}

/**  2个中点的距离是150就开始放大，其他情况缩小 **/
static CGFloat const distance = 150;
/**  缩放系数，越大中间的图片就越大 **/
static CGFloat const scaleK = 0.6;

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    // 屏幕最中间的X
    CGFloat centX = self.collectionView.contentOffset.x + self.collectionView.bounds.size.width * 0.5;
    
    // 可见的Rect
    CGRect visiableRect;
    visiableRect.size = self.collectionView.frame.size;
    visiableRect.origin = self.collectionView.contentOffset;
    
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    // UICollectionViewLayoutAttributes 拿出布局的属性来设置
    for (UICollectionViewLayoutAttributes *attr in array) {
        // 不在屏幕上 不执行下面语句（性能优化）
        if (!CGRectIntersectsRect(visiableRect, attr.frame)) continue;
        // 2. 到中间就缩放 --> 越靠近中间就缩放比例就越大 （间距越小缩放比例就越大）
        // 每个item的中点
        CGFloat itemCenterX = attr.center.x;
        // 2.1.1 间距 ABS(itemCenterX - centX)
        // 缩放
            CGFloat scale = 1 + scaleK * (1 - ABS(itemCenterX  - centX) / distance);  // 150 是距离2个中点是150就开始缩小（Bug就没有了）
#warning 如果用了transform3D 没法点击。。
                attr.transform = CGAffineTransformMakeScale(scale, scale);


    }
    return array;
}
@end
