//
//  MiWaterLayout.m
//  Mi瀑布流（CollectionView）
//
//  Created by YuanMiaoHeng on 16/1/19.
//  Copyright © 2016年 LianJiang. All rights reserved.
//

#import "MiWaterLayout.h"

@interface MiWaterLayout ()

@property(nonatomic,strong)NSMutableDictionary *maxYDic;

@property(nonatomic,strong)NSMutableArray *attrsArray;

@end

/** 默认 间距 */
static const CGFloat defaultMargin = 5;
/** 默认列数 */
static const int defaultcolumnsCount = 3;

@implementation MiWaterLayout

- (NSMutableArray *)attrsArray
{
    if (!_attrsArray) {
        self.attrsArray = [[NSMutableArray alloc] init];
    }
    return _attrsArray;
}


- (NSMutableDictionary *)maxYDic {
    if (!_maxYDic) {
        _maxYDic = [NSMutableDictionary dictionary];
        for (int i = 0; i < self.columnsCount; i ++) {
            _maxYDic[[NSString stringWithFormat:@"%d",i]] = @(0);
        }
    }
    return  _maxYDic;
}

- (instancetype)init
{
    if ([super init]) {
        self.columnMargin = defaultMargin;
        self.rowMargin = defaultMargin;
        self.sectionInsets = UIEdgeInsetsMake(defaultMargin, defaultMargin, defaultMargin, defaultMargin);
        self.columnsCount = defaultcolumnsCount;
        
    }
    return self;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

- (void)prepareLayout
{
    [super prepareLayout];
    
    // 1. 清空最大Y值
    for (int i = 0 ; i < self.columnsCount; i ++) {
        NSString *colum = [NSString stringWithFormat:@"%d", i];
        self.maxYDic[colum] = @(self.sectionInsets.top);
    }
    
    
    // 清空数组 （不然好卡）
    [self.attrsArray removeAllObjects];
    
    // 计算所有Cell的属性
    int count = (int)[self.collectionView numberOfItemsInSection:0];
    for (int i = 0; i < count; i ++) {
        UICollectionViewLayoutAttributes *attr = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        [self.attrsArray addObject:attr];
    }
}

/** 算 ContentSize **/
- (CGSize)collectionViewContentSize
{
    __block NSString *maxColumn = @"0";
    [self.maxYDic enumerateKeysAndObjectsUsingBlock:^(NSString *column, NSNumber *maxY, BOOL *stop) {
        if ([maxY floatValue] > [self.maxYDic[maxColumn] floatValue]) {
            maxColumn = column;
        }
    }];
    return CGSizeMake(0, [self.maxYDic[maxColumn] floatValue] + self.sectionInsets.bottom);
}

/**
 *  返回indexPath这个位置Item的布局属性
 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 找出最短的那一列
 __block  NSString *minColumn = @"0";
    [self.maxYDic enumerateKeysAndObjectsUsingBlock:^(id  column , NSNumber *maxY, BOOL *stop) {
        // 假设第0行为最短的。
        if ([maxY floatValue] < [self.maxYDic[minColumn] floatValue]) {
            minColumn = column;
        }
    }];
    
    // 计算尺寸、位置
    CGFloat width = (self.collectionView.frame.size.width - self.sectionInsets.left - self.sectionInsets.right - (self.columnsCount - 1) * self.columnMargin) / (self.columnsCount);
    CGFloat height = [self.delegate waterLayout:self width:width indexPath:indexPath]; // 给宽和index给代理，让代理返回高（代理外面可以拿到模型的宽高）
    CGFloat x = self.sectionInsets.left + (width + self.columnMargin) * [minColumn integerValue];
    CGFloat y = [self.maxYDic[minColumn] floatValue]+ self.rowMargin; // ??

    // 更新此列的MaxY
    self.maxYDic[minColumn] = @(y + height);
    
    UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attr.frame = CGRectMake(x, y, width, height);
    return attr;
}

/**
 *  返回rect范围内的布局属性
 */
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.attrsArray;
}

@end
