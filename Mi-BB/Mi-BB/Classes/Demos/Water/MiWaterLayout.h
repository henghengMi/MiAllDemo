//
//  MiWaterLayout.h
//  Mi瀑布流（CollectionView）
//
//  Created by YuanMiaoHeng on 16/1/19.
//  Copyright © 2016年 LianJiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MiWaterLayout;

@protocol MiWaterLayoutDelegate <NSObject>

/** 把宽度 和 indexPath 给代理 ，代理返回高度给内部设置*/
- (CGFloat)waterLayout:(MiWaterLayout *)waterLayout width:(CGFloat)width indexPath:(NSIndexPath *)indexPath;

@end

@interface MiWaterLayout : UICollectionViewFlowLayout

/** 列数 **/
@property(nonatomic, assign) CGFloat columnsCount;
/** 列距 **/
@property(nonatomic, assign) CGFloat columnMargin;
/** 行距 **/
@property(nonatomic, assign) CGFloat rowMargin;
/** 上下左右边距 **/
@property(nonatomic, assign) UIEdgeInsets sectionInsets;

@property(nonatomic, weak) id<MiWaterLayoutDelegate>  delegate ;

@end
