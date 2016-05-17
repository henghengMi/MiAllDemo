//
//  MiCustomLayoutController.m
//  Mi-BB
//
//  Created by YuanMiaoHeng on 16/4/23.
//  Copyright © 2016年 Mi. All rights reserved.
//

#import "MiCustomLayoutController.h"
#import "MiLineLayout.h"
#import "ImageCell.h"
#import "MiStackingLayout.h"
#import "MiCircleLayout.h"

@interface MiCustomLayoutController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,strong)NSMutableArray *imgs;
@property(nonatomic,weak)UICollectionView *collectionV;
@end

static NSString *const ID = @"img";

@implementation MiCustomLayoutController


- (NSMutableArray *)imgs
{
    if (_imgs == nil) {
        _imgs = [NSMutableArray array];
        for (int i = 0; i < 12; i ++) {
            [_imgs  addObject:[NSString stringWithFormat:@"dzs%d.jpg",i]];
        }
    }
    return _imgs;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect rect = CGRectMake((self.view.bounds.size.width - 280 ) * 0.5, 30, 280, 200);
    UICollectionView *collectionV = [[UICollectionView alloc] initWithFrame:rect collectionViewLayout:[[MiCircleLayout alloc] init]];
    collectionV.dataSource = self;
    collectionV.delegate = self;
    [self.view addSubview:collectionV];
    // 注册Cell
    [collectionV registerNib:[UINib nibWithNibName:@"ImageCell" bundle:nil] forCellWithReuseIdentifier:ID];
    self.collectionV = collectionV;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imgs.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.imgName = self.imgs[indexPath.item];
    return cell;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if ([self.collectionV.collectionViewLayout isKindOfClass:[MiCircleLayout class]]) {
        [self.collectionV setCollectionViewLayout:[[MiStackingLayout alloc] init] animated:YES];
    }
    else if ([self.collectionV.collectionViewLayout isKindOfClass:[MiStackingLayout class]])
    {
        [self.collectionV setCollectionViewLayout:[[MiLineLayout alloc] init] animated:YES];
    }
    else if  ([self.collectionV.collectionViewLayout isKindOfClass:[MiLineLayout class]])
    {
        [self.collectionV setCollectionViewLayout:[[MiCircleLayout alloc] init] animated:YES];
    }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.imgs removeObjectAtIndex:indexPath.item];
    [collectionView deleteItemsAtIndexPaths:@[indexPath]];
}

@end
