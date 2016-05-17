//
//  MiWaterViewController.m
//  Mi-BB
//
//  Created by YuanMiaoHeng on 16/4/21.
//  Copyright © 2016年 Mi. All rights reserved.
//

#import "MiWaterViewController.h"
#import "MJExtension.h"
#import "Product.h"
#import "MJRefresh.h"
#import "ProductCell.h"
#import "MiWaterLayout.h"

@interface MiWaterViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,MiWaterLayoutDelegate>
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,weak) UICollectionView *collectionV;

@end


static NSString *const ID = @"water";

@implementation MiWaterViewController

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
        _dataArray = [NSMutableArray arrayWithArray:[Product objectArrayWithFilename:@"1.plist"]];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MiWaterLayout *waterLayout =[[MiWaterLayout alloc] init];
    waterLayout.rowMargin = 5;
    waterLayout.columnMargin = 5;
    waterLayout.columnsCount = 3;
    waterLayout.sectionInsets = UIEdgeInsetsMake(0, 5, 5, 5);
    
    waterLayout.delegate = self;
    UICollectionView *collectionV = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64) collectionViewLayout:waterLayout];
    [self.view addSubview:collectionV];
    [collectionV registerNib:[UINib nibWithNibName:@"ProductCell" bundle:nil] forCellWithReuseIdentifier:ID];
    collectionV.delegate = self;
    collectionV.dataSource = self;
    collectionV.backgroundColor = [UIColor whiteColor];
    self.collectionV = collectionV;
    
    [collectionV addFooterWithTarget:self action:@selector(loadMore)];
    
}


-(void)loadMore
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSArray * newDataArray = [NSMutableArray arrayWithArray:[Product objectArrayWithFilename:@"1.plist"]];
        [_dataArray addObjectsFromArray:newDataArray];
        [self.collectionV reloadData];
        [self.collectionV footerEndRefreshing];
    });
}

- (CGFloat)waterLayout:(MiWaterLayout *)waterLayout width:(CGFloat)width indexPath:(NSIndexPath *)indexPath
{
    Product *p = self.dataArray[indexPath.item];
    return width * p.h / p.w;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ProductCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    cell.p = self.dataArray[indexPath.item];
    
    return cell;
}


@end
