//
//  ImageCell.m
//  CollectionView自定义布局01
//
//  Created by YuanMiaoHeng on 16/1/18.
//  Copyright © 2016年 LianJiang. All rights reserved.
//

#import "ImageCell.h"

@interface ImageCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@end

@implementation ImageCell

- (void)awakeFromNib
{
    self.imgView.layer.borderWidth = 3;
    self.imgView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.imgView.layer.cornerRadius = 5;
    self.imgView.clipsToBounds = YES;
}

- (void)setImgName:(NSString *)imgName
{
    _imgName = [imgName copy];
    self.imgView.image = [UIImage imageByBundleWithImageName:imgName];
}

@end
