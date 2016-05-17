//
//  UIImage+Mi.h
//  MyNewsItem
//
//  Created by 袁妙恒 on 15/6/18.
//  Copyright (c) 2015年 袁妙恒. All rights reserved.

//  防止图片拉伸的image的分类
#import <UIKit/UIKit.h>

@interface UIImage (Mi)

+ (UIImage *)resizedImageWithName:(NSString *)name;
+ (UIImage *)resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top;

- (void)resizedImage;

/*
 *  将图片压缩成想要的尺寸
 */
+ (UIImage*)imageWithImageCompress:(UIImage*)image scaledToSize:(CGSize)newSize;

/*
 * 将图片存进Document中后
 * FixName 后缀名
 */
- (void)saveImageWithFixName:(NSString *)FixName;


/**
 *  颜色变图片。
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

/**
 *
 * 图片缩放成指定的尺寸
 */
- (UIImage*)scaleToSize:(CGSize)size;


/**
 *  传入名字拿到bundle里面的图片
 */
+ (UIImage *)imageByBundleWithImageName:(NSString *)imageName;


/**
 *  传入图片名字、bundleName 拿到bundle里面的图片
 */
+ (UIImage *)imageWithImageName:(NSString *)imageName bundleName:(NSString *)bundleName;


@end
