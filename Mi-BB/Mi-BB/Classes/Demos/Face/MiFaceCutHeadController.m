//
//  MiFaceCutHeadController.m
//  Mi-BB
//
//  Created by YuanMiaoHeng on 16/4/28.
//  Copyright © 2016年 Mi. All rights reserved.
//

#import "MiFaceCutHeadController.h"
#import "KLFaceDetector.h"
#import "MiActionSheet.h"

#define FACEIMGVIEW_TAG     100001

@interface MiFaceCutHeadController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    CIDetector *Facedetector;
    CIContext *context;
    CIImage *beginImage;
    UIPopoverController *popOver;
}
@property (nonatomic, strong) UIImageView * faceImgView;

@property (nonatomic, strong) UIImageView * bottomImgView;

@end

@implementation MiFaceCutHeadController

#pragma mark - LifeCycle
//- (void)loadView
//{
//    CGRect bounds = [[UIScreen mainScreen] bounds];
//    UIView * view = [[UIView alloc] initWithFrame:bounds];
//    [view setBackgroundColor:[UIColor whiteColor]];
//    [self setView:view];
//}


- (UIImageView *)bottomImgView
{
    if (!_bottomImgView) {
        _bottomImgView = [[UIImageView alloc] init];
//        _bottomImgView.alpha = 0;
        _bottomImgView.frame = CGRectMake((ScreenWidth - 160 ) * 0.5 ,CGRectGetMaxY(self.faceImgView.frame) + 20, 160, 120);
        _bottomImgView.backgroundColor = [UIColor redColor];
    }
    return _bottomImgView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self UI];
}

- (void)UI
{
    UIImage * img = [UIImage imageNamed:@"yuner.jpg"];
    NSAssert((img), @"Img not found");
//    CGSize imgSize = [img size];
//    CGSize imgViewSize = CGSizeMake(self.view.frame.size.height/2.0*imgSize.width/imgSize.height, self.view.frame.size.height/2.0);
    self.faceImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 5, ScreenWidth, ScreenHeight * 0.65)];
    [self.faceImgView setImage:img];
    [self.view addSubview:self.faceImgView];
    self.faceImgView.userInteractionEnabled = YES;
    [self.faceImgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapFace:)]];
//    self.faceImgView.clipsToBounds = YES;
    self.faceImgView.contentMode = UIViewContentModeScaleAspectFit;
    
    UIButton * getFaceBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [getFaceBtn setBackgroundColor:[UIColor lightGrayColor]];
    [getFaceBtn setFrame:CGRectMake(10, CGRectGetMaxY(self.faceImgView.frame) + 10, 90, 30)];
    [getFaceBtn setTitle:@"GetFace" forState:UIControlStateNormal];
    [getFaceBtn addTarget:self action:@selector(getFace:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:getFaceBtn];
    [self.view addSubview:self.bottomImgView];
}

#pragma mark - Action
- (void)getFace:(UIButton *)btn {
    //remove the previous face imageView first
    [[self.view viewWithTag:FACEIMGVIEW_TAG] removeFromSuperview];
    
    CGSize imgSize = CGSizeMake(160, 120); // you can change this size to whatever you like
    [btn setTitle:@"Working..." forState:UIControlStateNormal];
    [KLFaceDetector getImageWithFaceForImage:self.faceImgView.image withSize:imgSize shouldFast:YES completionHandler:^(UIImage * faceImg) {
        [btn setTitle:@"GetFace" forState:UIControlStateNormal];
        [self.bottomImgView setImage:faceImg];
    }];
    
    //Another way to use KLFaceDetector, Don't specify the shouldFast paramter, default is NO, this may take more time
    
//        [KLFaceDetector getImageWithFaceForImage:self.faceImgView.image withSize:imgSize completionHandler:^(UIImage * faceImg) {
//            UIImageView * imgView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(btn.frame)+15, CGRectGetMaxY(self.faceImgView.frame)+25, imgSize.width, imgSize.height)];
//            [imgView setBackgroundColor:[UIColor darkGrayColor]];
//            [imgView setTag:FACEIMGVIEW_TAG];
//            [imgView setImage:faceImg];
//            [self.view addSubview:imgView];
//        }];
}


#pragma mark 点图片
- (void)tapFace:(UIGestureRecognizer *)tap
{
    
    MiActionSheet *action = [[MiActionSheet alloc] initWithTitle:@"更换个人封面" cancelButtonTitle:@"取消" otherButtonTitles:@[@"照相",@"从相册中获取"]];
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

#pragma mark  照相或者选完照片后的处理
- (void)choiceImageHanddleWithImage:(UIImage *)compressImg
{
    NSData *data = UIImageJPEGRepresentation(compressImg, 0.5); // 压缩转为Data
    self.faceImgView.image = [UIImage imageWithData:data];
    
    
    
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



@end
