//
//  MiYYKitPhotoBrowserController.m
//  Mi-BB
//
//  Created by YuanMiaoHeng on 16/4/25.
//  Copyright © 2016年 Mi. All rights reserved.
//

#import "MiYYKitPhotoBrowserController.h"

#import "YYKit.h"
#import "YYPhotoGroupView.h"



@interface MiYYKitPhotoBrowserController ()

@property(nonatomic, strong) NSArray  * imagesURLs;

@property(nonatomic, strong) NSMutableArray * dataArray;

@property(nonatomic, strong) NSMutableArray * imageViews;

@property(nonatomic, strong) NSMutableArray * items;


@end

@implementation MiYYKitPhotoBrowserController

- (NSMutableArray *)imageViews {
    if (!_imageViews) {
        _imageViews = [NSMutableArray array];
    }
    return  _imageViews;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    [self initData];
    [self setupImageWithURLArray:self.imagesURLs];
}

- (void)initData
{
      self.imagesURLs = @[
                         @"http://image.tianjimedia.com/uploadImages/2011/286/8X76S7XD89VU.jpg",
                         @"http://img4.duitang.com/uploads/item/201407/29/20140729224215_nxMFh.jpeg",
                         @"http://imgsrc.baidu.com/forum/pic/item/e6056e224f4a20a45adc7e0790529822700ed0c7.jpg",
                         @"http://imgsrc.baidu.com/forum/w%3D580/sign=0a1868403d6d55fbc5c6762e5d234f40/36d3d539b6003af31608d8fe352ac65c1138b6f9.jpg",
                         @"http://imgsrc.baidu.com/forum/w%3D580/sign=992b220922a446237ecaa56aa8227246/c21cb58f8c5494ee0416576a2ff5e0fe98257ecb.jpg",
                         @"http://img5.duitang.com/uploads/item/201405/01/20140501090601_5u5KX.jpeg",
                         @"http://v1.qzone.cc/pic/201307/30/21/28/51f7bf6a54353735.jpg%21600x600.jpg",
                         @"http://img4.duitang.com/uploads/item/201507/19/20150719010001_jdUkT.thumb.700_0.jpeg",
                         @"http://img4q.duitang.com/uploads/item/201207/08/20120708192855_iy8AS.jpeg"
                         ];
}


- (void)setupImageWithURLArray:(NSArray *)urlArrray
{
    int clumns = 3;
    int row = 3;
    CGFloat wh = 100;
    CGFloat margin = 5;
    
        for (int i = 0; i < clumns * row; i ++) {
            int xI = i % clumns;
            int yI = i / clumns;
            UIImageView *imgView = [[UIImageView alloc] init];
            [self.view addSubview:imgView];
            imgView.frame = CGRectMake(xI * (wh + margin) + 50 , yI * (wh + margin)  + 50, wh, wh);
            imgView.backgroundColor = MiRandomColor;
            imgView.userInteractionEnabled = YES;
            [imgView setImageURL:[NSURL URLWithString:urlArrray[i]]];
            [self.imageViews addObject:imgView];
            imgView.tag = i ;
            
            [imgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTap:)]];
        }
}

- (void)imageTap:(UIGestureRecognizer *)tap
{
    UIImageView *imgView = (UIImageView *)tap.view;
    [self SeePhotoWithpics:self.imageViews didClickImageAtIndex:imgView.tag];
}

/**
 *  查看图片
 *
 *  @param pics  图片imageView
 *  @param index 点击的下标
 *  装有URL的数组
 *  1. 创建item、
    2. 配置item （imgview、url、size、）
    3. 创建YYPhotoGroupView 、把items扔进去
    4. 展示：方法：presentFromImageView
 */
- (void)SeePhotoWithpics:(NSArray *)pics didClickImageAtIndex:(NSUInteger)index {
    UIView *fromView = nil;
    NSMutableArray *items = [NSMutableArray new];
//    WBStatus *status = cell.statusView.layout.status;
//    NSArray<WBPicture *> *pics = status.retweetedStatus ? status.retweetedStatus.pics : status.pics;
    
    for (NSUInteger i = 0, max = pics.count; i < max; i++) {
        UIImageView *imgView = self.imageViews[i];
        YYPhotoGroupItem *item = [YYPhotoGroupItem new];
        item.thumbView = imgView;
        item.largeImageURL = [NSURL URLWithString:self.imagesURLs[i]]  ;
        item.largeImageSize = CGSizeMake(ScreenHeight, ScreenHeight);
        [items addObject:item];
        if (i == index) {
            fromView = imgView;
        }
    }
    
    YYPhotoGroupView *v = [[YYPhotoGroupView alloc] initWithGroupItems:items];
    [v presentFromImageView:fromView toContainer:self.navigationController.view animated:YES completion:nil];
}

@end
