//
//  ProductCell.m
//  Mi瀑布流（CollectionView）
//
//  Created by YuanMiaoHeng on 16/1/19.
//  Copyright © 2016年 LianJiang. All rights reserved.
//

#import "ProductCell.h"

#import "Product.h"

#import "UIImageView+WebCache.h"

@interface ProductCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end

@implementation ProductCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setP:(Product *)p
{
    _p = p;
    
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:p.img] placeholderImage:[UIImage imageNamed:@"loading"]];
//    [self.imgView sd_setImageWithURL:[NSURL URLWithString:@"http://s13.mogujie.cn/b7/bao/131012/vud8_kqywordekfbgo2dwgfjeg5sckzsew_310x426.jpg_200x999.jpg"]];
    
    self.priceLabel.text = p.price;
}

@end
