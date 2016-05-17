//
//  MiCutImageController.m
//  Mi-BB
//
//  Created by YuanMiaoHeng on 16/4/20.
//  Copyright © 2016年 Mi. All rights reserved.
//

#import "MiCutImageController.h"

#import "MiActionSheet.h"


@interface MiCutImageController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property(nonatomic,strong) NSMutableArray *viewsArray;
@property (strong, nonatomic)  UIImageView *orignalImgView;
@property (strong, nonatomic)  UIImageView *leftImgView;
@property (strong, nonatomic)  UIImageView *rightImgView;
@property (weak, nonatomic)  UIButton *lastBtn;

@property(assign, nonatomic) int animationType;

@property(assign, nonatomic) CGFloat duration;

@property(weak, nonatomic)  UILabel *valueLabel;

@end

@implementation MiCutImageController


- (NSMutableArray *)viewsArray
{
    if (_viewsArray == nil) {
        _viewsArray = [NSMutableArray array];
    }
    return _viewsArray;
}

/*
 * 300 * 200
 */

- (UIImage *)cutWithView:(UIView *)view Rect:(CGRect)rect
{
    // 1.开启图形上下文
    CGSize imageSize = view.bounds.size;
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    
    // 2.将某个view的所有内容渲染到图形上下文中
    CGContextRef context = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:context];
    
    // 3.取得图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    CGImageRef subimageRef = CGImageCreateWithImageInRect(image.CGImage, rect);
    
    // 截到的图片
    UIImage *subImage = [UIImage imageWithCGImage:subimageRef];
    
    //    [UIImagePNGRepresentation(subImage) writeToFile:@"/Users/yuanmiaoheng/Desktop/view.png" atomically:YES];
    // 4.关闭上下文
    UIGraphicsEndImageContext();
    
    return subImage;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.duration = 3.5f;
    
    self.view.backgroundColor = [UIColor tealColor];
    // 原始
    self.orignalImgView = [[UIImageView alloc] init];
    self.orignalImgView.image = [UIImage imageNamed:@"chaoren2"];
    [self.view addSubview:self.orignalImgView];
    self.orignalImgView.contentMode = UIViewContentModeScaleAspectFill;
    self.orignalImgView.clipsToBounds = YES;
    self.orignalImgView.layer.cornerRadius = 4;
    CGFloat imgH = (self.orignalImgView.image.size.height * (ScreenWidth - 20)) / self.orignalImgView.image.size.width;
    self.orignalImgView.frame = CGRectMake((ScreenWidth - 340) * 0.5, 100, 340, 250);
    self.orignalImgView.alpha = 1;
    [MBProgressHUD showMessage:@"正在初始化数据"];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self cutImgView:self.orignalImgView];
    });
    [self setupGoButton];
    [self setupnSlider];
    [self setupAnimationButton];
    
   
    
    
}

- (void)setupnSlider
{
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(20, ScreenHeight - 44 - 20 - 64 - 20 - 50, ScreenWidth - 40, 50)];
    [self.view addSubview:slider];
    slider.minimumValue = 1.0f;
    slider.maximumValue = 20.0f;
    [slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:(UIControlEventValueChanged)];
    slider.value = self.duration;
    [slider setValue:self.duration];
    
     UILabel *valueLabel = [[UILabel alloc] initWithFrame:CGRectMake((ScreenWidth - 200) * 0.5, slider.y - 30 - 10, 200, 30)];
     valueLabel.text = [NSString stringWithFormat:@"动画时间%.2fs",self.duration];
     [self.view addSubview:valueLabel];
     valueLabel.backgroundColor = MiRandomColorRGBa(0.3);
     valueLabel.textColor = [UIColor whiteColor];
     valueLabel.font = [UIFont systemFontOfSize:14];
    valueLabel.textAlignment = NSTextAlignmentCenter;
    self.valueLabel =  valueLabel;
}

- (void)sliderValueChanged:(UISlider *)slider
{
    self.duration = slider.value;
    self.valueLabel.text = [NSString stringWithFormat:@"动画时间%.2fs",self.duration];
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    MiActionSheet *action = [[MiActionSheet alloc] initWithTitle:@"更换图片" cancelButtonTitle:@"取消" otherButtonTitles:@[@"照相",@"从相册中获取"]];
    __weak typeof (self)weakSelf =  self;
    
    action.titleBtnClick  = ^ (NSInteger index) {
        if (index == 0) { // 点击了拍照
            // 设置为相机模式
            UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
            
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                picker.sourceType =UIImagePickerControllerSourceTypeCamera;
                // 代理
                picker.delegate = weakSelf;
                picker.allowsEditing = YES;
                // 类型
                picker.sourceType = sourceType;
                // 显示
                [weakSelf presentViewController:picker animated:YES completion:nil];
            }
        }
        else if(index == 1) // 点击了从手机相册选择
        {
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            // 代理
            picker.delegate = weakSelf;
            // 选择后图片可被编辑
            picker.allowsEditing = YES;
            // 类型
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            // 显示
            [weakSelf presentViewController:picker animated:YES completion:nil];
        }
    };
}


#pragma mark - 相册回调
#pragma mark  UIImagePickerController的代理方法
// 点击了选中就会调用
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // 关闭相册界面
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    // 如果是照相
    if(picker.sourceType == UIImagePickerControllerSourceTypeCamera)
    {
        // 拿到照片
        UIImage *img = [info objectForKey:@"UIImagePickerControllerEditedImage"];
        //        self.iconImg = img;
        UIImageOrientation imageOrientation = img.imageOrientation;
        
        if(imageOrientation!=UIImageOrientationUp)
        {
            // 原始图片可以根据照相时的角度来显示，但UIImage无法判定，于是出现获取的图片会向左转９０度的现象。
            // 以下为调整图片角度的部分
            UIGraphicsBeginImageContext(img.size);
            [img drawInRect:CGRectMake(0, 0, img.size.width, img.size.height)];
            img = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            // 调整图片角度完毕
        }
        UIImageWriteToSavedPhotosAlbum(img, nil, nil, nil);
        
        [self choiceImageHanddleWithImage:img];
    }
    
    // 如果是相册
    else if (picker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary) // 相机库
    {
        // 拿到图
        UIImage *img = [info objectForKey:@"UIImagePickerControllerEditedImage"];
        //        self.iconImg = img;
        // 剪完之后的图片
        [self choiceImageHanddleWithImage:img];
    }
}


#pragma mark 对图片尺寸进行压缩
-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize

{
    // Create a graphics image context
    
    UIGraphicsBeginImageContext(newSize);

    // Tell the old image to draw in this new context, with the desired
    // new size
    
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    // Get the new image from the context
    
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    // End the context
    
    UIGraphicsEndImageContext();
    // Return the new image.
    
    return newImage;
}


#pragma mark  照相或者选完照片后的处理
- (void)choiceImageHanddleWithImage:(UIImage *)compressImg
{
//   UIImage * imageNew = [self imageWithImage:self.orignalImgView.image scaledToSize:self.orignalImgView.size];
    
    NSData *imageData = UIImageJPEGRepresentation(compressImg,0.1);
    
    self.orignalImgView.image = [UIImage imageWithData:imageData];
    [MBProgressHUD showMessage:@"正在初始化照片"];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self cutImgView:self.orignalImgView];
    });
  
}

- (void)setupGoButton
{
    UIButton *goButton = [UIButton buttonWithType:0];
    [goButton setTitle:@"Go" forState:(UIControlStateNormal)];
    [goButton addTarget:self action:@selector(boomClick:) forControlEvents:(UIControlEventTouchUpInside)];
    goButton.frame = CGRectMake(30, ScreenHeight - 44 - 20 - 64, ScreenWidth - 60, 44);
    goButton.backgroundColor = MiRandomColorRGBa(0.8);
    [self.view addSubview:goButton];
    goButton.clipsToBounds = YES;
    goButton.layer.cornerRadius = 5;
}

- (void)setupAnimationButton
{
    int count = 3;
    for (int i = 0 ; i < count; i ++) {
        UIButton *btn = [[UIButton alloc] init];
        [btn setTitle:[NSString stringWithFormat:@"动画%d",i] forState:(UIControlStateNormal)];
        btn.tag = 100 + i;
        [btn setBackgroundImage:[UIImage imageWithColor:MiColorRGBA(0, 0, 0, 0.5)] forState:(UIControlStateNormal)];
        [btn setBackgroundImage:[UIImage imageWithColor:MiColorRGBA(0, 0, 0, 0.5)] forState:(UIControlStateHighlighted)];
        [btn setBackgroundImage:[UIImage imageWithColor:MiRandomColor] forState:(UIControlStateSelected)];
        [self.view addSubview:btn];
        CGFloat margin = (ScreenWidth - 80 * count ) / (count + 1);
        btn.frame = CGRectMake(margin +  (80 + margin) * i, 30, 80, 44);
        btn.clipsToBounds = YES;
        btn.layer.cornerRadius = 5;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        if (i == 0) {
            [self btnClick:btn];
        }
    }
}

#pragma mark 选动画类型按钮
- (void)btnClick:(UIButton *)btn
{
    if ([btn isEqual:_lastBtn]) return;
        
   self.animationType = (int)btn.tag - 100;
    
    if (![btn isEqual:_lastBtn]) {
        btn.selected = YES;
        _lastBtn.selected = NO;
        _lastBtn = btn;
    }
}

#pragma mark 分割为小格子
- (void)cutImgView:(UIImageView *)imgView
{
    // 移除
    for (int i = 0; i < self.viewsArray.count; i ++) {
        UIImageView *imgView = self.viewsArray[i];
        [imgView removeFromSuperview];
    }
    [self.viewsArray removeAllObjects];

    
    // 分割为多个小格子
    CGFloat imgViewW =  self.orignalImgView.width ;
    CGFloat imgViewH =  self.orignalImgView.height ;
    // 小格子宽高
    int W = 20;
    int H = 25;
    // 总共分多少次
    int totoleCount = (imgViewW  / W) * (imgViewH  / H) ;
    // 多少列
    int clumns = imgViewW  / W;
    // 多少行
    //    int row = imgViewH / H;
    for (int i = 0 ; i <totoleCount ; i ++ ) {
        int iX = i % clumns;
        int iY= i / clumns;
        CGRect rect = CGRectMake(W*iX*2 , H* 2* iY , W * 2, H *2);
        UIImage * img = [self cutWithView:self.orignalImgView Rect:rect];
        UIImageView *smallImgView = [[UIImageView alloc] initWithFrame:CGRectMake(W*iX + self.orignalImgView.x, H*iY + self.orignalImgView.y, W , H)];
        smallImgView.image = img;
        [self.view addSubview:smallImgView];
        smallImgView.backgroundColor = MiRandomColor;
        smallImgView.alpha = 0;
        [self.viewsArray addObject:smallImgView];
    }
    
    [MBProgressHUD hideHUD];
     NSLog(@"---------- 切完 ---------");
    
//    [UIView animateWithDuration:1.5f animations:^{
//        self.orignalImgView.alpha = 1;
//    }];
//    
    
}

// 点击按钮
#pragma mark 点击执行动画
- (void)boomClick:(UIButton *)btn {
    //   移除
    [UIView animateWithDuration:self.duration  animations:^{
        self.orignalImgView.alpha = 0;
    } completion:^(BOOL finished) {
        
    }];
    
    for (int i = 0; i < self.viewsArray.count; i ++) {
        UIImageView *imgView = self.viewsArray[i];
      
        if (self.animationType == 0) {
            [self testAnimation1:imgView i:i];
        }else if (self.animationType == 1)
        {
            [self testAnimation2:imgView i:i];

        } else
        {
            [self testAnimation3:imgView i:i];
        }
    }
    
}

#pragma mark 动画3
- (void)testAnimation3:(UIImageView *)imgView i:(int)i
{
    // 分割为多个小格子
    CGFloat imgViewW =  self.orignalImgView.image.size.width ;
//    CGFloat imgViewH =  self.orignalImgView.image.size.height ;
    
    // 小格子宽高
    int W = 5;
//    int H = 5;
    // 总共分多少次
//    int totoleCount = (imgViewW  / W) * (imgViewH  / H);
    // 多少列
    int clumns = imgViewW  / W;
    // 多少行
//     int row = imgViewH / H;
    
    int iX = i % clumns;
    int iY= i / clumns;
    
    [UIView animateWithDuration:self.duration animations:^{
        imgView.alpha = 1;
        imgView.layer.transform = CATransform3DMakeTranslation(iX, iY, 0);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:self.duration  animations:^{
            imgView.layer.transform = CATransform3DIdentity;
        }];
    }];
}

#pragma mark 动画2
- (void)testAnimation2:(UIImageView *)imgView i:(int)i
{
    
    if (i % 4 == 0) {
        [UIView animateWithDuration:self.duration animations:^{
            imgView.alpha = 1;
            imgView.layer.transform = CATransform3DMakeRotation(M_PI_2, 0, 1, 0);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:self.duration animations:^{
                imgView.layer.transform = CATransform3DIdentity;
            }];
        }];
    }
    
    if (i % 4 == 1) {
        [UIView animateWithDuration:self.duration animations:^{
            imgView.alpha = 1;
            
            imgView.layer.transform = CATransform3DMakeRotation(M_PI, 1, 0, 0);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:self.duration animations:^{
                imgView.layer.transform = CATransform3DIdentity;
            }];
        }];
    }
    
    if (i % 4 == 2) {
        [UIView animateWithDuration:self.duration animations:^{
            imgView.alpha = 1;
            
            imgView.layer.transform = CATransform3DMakeRotation(M_PI_2, 0.5, 0.5, 0.5);
        }completion:^(BOOL finished) {
            [UIView animateWithDuration:self.duration animations:^{
                imgView.layer.transform = CATransform3DIdentity;
            }];
        }];
    }
    
    if (i % 4 == 3) {
        [UIView animateWithDuration:self.duration animations:^{
            imgView.alpha = 1;
            imgView.layer.transform = CATransform3DMakeRotation(M_PI, 0.2, 0.4, 0.8);
        }completion:^(BOOL finished) {
            [UIView animateWithDuration:self.duration animations:^{
                imgView.layer.transform = CATransform3DIdentity;
            }];
        }];
    }
}

#pragma mark 动画1
- (void)testAnimation1:(UIImageView *)imgView i:(int)i
{
    if (i %3 == 0) {
        [UIView transitionWithView:imgView duration:self.duration options:(UIViewAnimationOptionTransitionCurlDown) animations:^{
            imgView.alpha = 1;
        } completion:nil];
    }
    if (i %3 == 1) {
        [UIView transitionWithView:imgView duration:self.duration options:(UIViewAnimationOptionTransitionCurlUp) animations:^{
            imgView.alpha = 1;
        } completion:nil];
    }
    if (i % 3 == 2) {
        [UIView transitionWithView:imgView duration:self.duration options:(UIViewAnimationOptionTransitionFlipFromBottom) animations:^{
            imgView.alpha = 1;
        } completion:nil];
    }
    if (i % 3 == 3) {
        [UIView transitionWithView:imgView duration:self.duration options:(UIViewAnimationOptionTransitionFlipFromTop) animations:^{
            imgView.alpha = 1;
        } completion:nil];
    }
}


- (void)jiugong
{
    // 原始
    //    self.orignalImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 100, 300, 300)];
    //        [self.view addSubview:self.orignalImgView];
    //    self.orignalImgView.image = [UIImage imageNamed:@"8.jpg"];
    //    self.orignalImgView.hidden = YES;
    
    int clumns = 6;
    int row = 9;
    
    int wh = 30;
    for (int i = 0; i < clumns * row; i ++) {
        int xI = i % clumns;
        int yI = i / clumns;
        UIImageView *imgView = [[UIImageView alloc] init];
        [self.view addSubview:imgView];
        
        //        imgView.image = [self cutWithView:self.orignalImgView Rect:CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)]
        imgView.frame = CGRectMake(xI * wh + 100 , yI * wh  + 100, wh, wh);
        imgView.backgroundColor = MiRandomColor;
        
    }
    
}



@end
