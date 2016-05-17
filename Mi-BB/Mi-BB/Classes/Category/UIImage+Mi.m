//
//  UIImage+Mi.m
//  MyNewsItem
//
//  Created by 袁妙恒 on 15/6/18.
//  Copyright (c) 2015年 袁妙恒. All rights reserved.
//

#import "UIImage+Mi.h"

@implementation UIImage (Mi)

+ (UIImage *)resizedImageWithName:(NSString *)name {
    return [self resizedImageWithName:name left:0.5 top:0.5];
}

+ (UIImage *)resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top {
    UIImage *image = [self imageNamed:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width * left topCapHeight:image.size.height * top];
}

- (void )resizedImage
{
    [self stretchableImageWithLeftCapWidth:0.5 * self.size.width topCapHeight:0.5 * self.size.height];
    
}


+ (UIImage*)imageWithImageCompress:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}

- (void)saveImageWithFixName:(NSString *)FixName;
{
    NSData * imageData = UIImagePNGRepresentation(self);

    NSString *imgPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES)[0] stringByAppendingPathComponent:FixName];
    
    [imageData writeToFile:imgPath atomically:NO];
}

/**
 *  颜色变图片。
 */
+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


- (UIImage*)scaleToSize:(CGSize)size
{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}

+ (UIImage *)imageByBundleWithImageName:(NSString *)imageName
{
    NSString *bundlePath = [[NSBundle mainBundle].resourcePath stringByAppendingPathComponent:@"dzs_Image.Bundle"];
    NSString *img_path = [bundlePath stringByAppendingPathComponent:imageName];
    return [UIImage imageWithContentsOfFile:img_path];
}


+ (UIImage *)imageWithImageName:(NSString *)imageName bundleName:(NSString *)bundleName
{
    NSString *bundlePath = [[NSBundle mainBundle].resourcePath stringByAppendingPathComponent:bundleName];
    NSString *img_path = [bundlePath stringByAppendingPathComponent:imageName];
    return [UIImage imageWithContentsOfFile:img_path];
}

@end
