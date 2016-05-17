//
//  MiGraffitiController.m
//  Mi-BB
//
//  Created by YuanMiaoHeng on 16/4/22.
//  Copyright © 2016年 Mi. All rights reserved.
//

#import "MiGraffitiController.h"
#import "scrawlView.h"
#import "UIImage+screen.h"
#import "MBProgressHUD+MJ.h"

@interface MiGraffitiController ()

@property (weak, nonatomic) IBOutlet scrawlView *scarawlView;
@property (weak, nonatomic) IBOutlet UISlider *slider;

@end

@implementation MiGraffitiController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.scarawlView.lineW = 5;
}

- (IBAction)back {
    [self.scarawlView back];
}

- (IBAction)clear {
     [self.scarawlView clear];
}

- (IBAction)save {
    UIImage *img = [UIImage clipTheView:self.scarawlView];
    
    //保存到相册中
    UIImageWriteToSavedPhotosAlbum(img, self, @selector(image:didFinishSavingWithError:contextInfo:), @"123");
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        NSLog(@"保存图片失败");
        [MBProgressHUD showError:@"保存图片失败"];
    }
    else
    {
        [MBProgressHUD showSuccess:@"保存图片成功"];
    }
}

- (IBAction)sliderValueChanged:(UISlider *)sender {
       self.scarawlView.lineW = sender.value;
}

- (IBAction)changeColorButtonPressed:(id)sender {

    self.scarawlView.linecolor = MiRandomColor;
}

@end
