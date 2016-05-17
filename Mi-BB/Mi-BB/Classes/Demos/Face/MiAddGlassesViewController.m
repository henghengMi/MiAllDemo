//
//  MiAddGlassesViewController.m
//  Mi-BB
//
//  Created by YuanMiaoHeng on 16/4/28.
//  Copyright © 2016年 Mi. All rights reserved.
//

#import "MiAddGlassesViewController.h"

@interface MiAddGlassesViewController ()<AVCaptureVideoDataOutputSampleBufferDelegate>
@property (nonatomic ,strong) AVCaptureSession *session;
@property (strong) AVCaptureDevice *videoDevice;
@property (strong) AVCaptureDeviceInput *videoInput;
@property (strong) AVCaptureVideoDataOutput *frameOutput;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) CIContext *context;
@property (nonatomic, strong) CIDetector *faceDetector;
@property (nonatomic, strong) UIImageView *glasses;
@property(nonatomic,strong) UIImageView *mouthImgView;

@end

@implementation MiAddGlassesViewController
@synthesize session = _session;
@synthesize videoInput = _videoInput;
@synthesize videoDevice = _videoDevice;
@synthesize frameOutput = _frameOutput;
@synthesize imageView = _imageView;
@synthesize context = _context;
@synthesize faceDetector = _faceDetector;
@synthesize glasses = _glasses;

#pragma mark - lazy initializer

- (UIImageView *)mouthImgView
{
    if (!_mouthImgView) {
        _mouthImgView = [[UIImageView alloc] init];
        _mouthImgView.backgroundColor = [UIColor redColor];
        _mouthImgView.frame = CGRectMake(40, 40, 20, 20);
    }
    return _mouthImgView;
}

- (CIContext *)context
{
    if (!_context) {
        _context = [CIContext contextWithOptions:nil];
    }
    return _context;
}

- (CIDetector *)faceDetector
{
    if (!_faceDetector) {
        // setup the accuracy of the detector
        NSDictionary *detectorOptions = [NSDictionary dictionaryWithObjectsAndKeys:
                                         CIDetectorAccuracyLow, CIDetectorAccuracy, nil];
        
        _faceDetector = [CIDetector detectorOfType:CIDetectorTypeFace context:nil options:detectorOptions];
    }
    return _faceDetector;
}

#pragma mark - AVCaptureVideoDataOutputSampleBufferDelegate

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection
{
    
    CVPixelBufferRef pixelBufferRef = CMSampleBufferGetImageBuffer(sampleBuffer);
    CIImage *ciImage = [CIImage imageWithCVPixelBuffer:pixelBufferRef];
    
    // pass detector the image:
    
    NSArray *features = [self.faceDetector featuresInImage:ciImage];
    bool faceFound = false;
    
    for (CIFaceFeature * face in features) {
        if (face.hasLeftEyePosition && face.hasRightEyePosition) {
                         NSLog(@"有眼");
            CGPoint eyeCenter = CGPointMake((face.leftEyePosition.x + face.rightEyePosition.x) * 0.5,
                                            (face.rightEyePosition.y + face.rightEyePosition.y) * 0.5);
            
            // set the glasses position based on mouth position:
            double scalex = self.imageView.bounds.size.height / ciImage.extent.size.width;
            double scaley = self.imageView.bounds.size.width / ciImage.extent.size.height;
            self.glasses.center = CGPointMake(scaley * eyeCenter.y - self.glasses.bounds.size.height/4.0, scalex * eyeCenter.x);
            
            // set the angle of the glasses using eye deltas:
            double deltax = face.leftEyePosition.x - face.rightEyePosition.x;
            double deltay = face.leftEyePosition.y - face.rightEyePosition.y;
            double angle = atan2(deltax, deltay);
            self.glasses.transform = CGAffineTransformMakeRotation(angle + M_PI);
            
            //set size based on distance between the two eyes:
            double scale = 3.0 * sqrt(deltax * deltax + deltay *deltay);
            self.glasses.bounds = CGRectMake(0, 0, scale, scale);
            faceFound = true;
            
            //            break;
        }
        
        if (face.hasMouthPosition) {
            NSLog(@"有嘴");
            
            double scalex = self.mouthImgView.bounds.size.height / ciImage.extent.size.width;
            double scaley = self.mouthImgView.bounds.size.width / ciImage.extent.size.height;
            self.mouthImgView.center = CGPointMake(scaley * face.mouthPosition.y - self.glasses.bounds.size.height / 6 + ciImage.extent.size.width * 0.5 , - (scalex * face.mouthPosition.x) +  ciImage.extent.size.height * 0.5 );
            
            //            self.mouthImgView.center =  face.mouthPosition;
//            NSLog(@"%@",NSStringFromCGPoint(self.mouthImgView.center));
        }
        
        
    }
    
    if (faceFound) {
        self.glasses.hidden = NO;
    }
    else {
        self.glasses.hidden = YES;
    }
    // apply hue adjustment filtering
    CIFilter *filter = [CIFilter filterWithName:@"CIHueAdjust"];
    [filter setDefaults];
    [filter setValue:ciImage forKey:kCIInputImageKey];
    [filter setValue:[NSNumber numberWithFloat:2.0] forKey:@"inputAngle"];
    
    CIImage * result = [filter valueForKey:kCIOutputImageKey];
    
    CGImageRef cgImageRef = [self.context createCGImage:result fromRect:ciImage.extent];
    self.imageView.image = [UIImage imageWithCGImage:cgImageRef scale:1.0 orientation:UIImageOrientationRight];
    CGImageRelease(cgImageRef);
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    
    [self.view addSubview:self.mouthImgView];
    
    self.session = [[AVCaptureSession alloc] init];
    // resolution for the preset
    self.session.sessionPreset = AVCaptureSessionPreset640x480;
    
    // setup video device
    self.videoDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // setup video input
    NSError *error = nil;
    self.videoInput = [AVCaptureDeviceInput deviceInputWithDevice:self.videoDevice error:&error];
    
    // setup frame output
    self.frameOutput = [[AVCaptureVideoDataOutput alloc] init];
    // set the frame  output pixel format type - 32 BRGA
    self.frameOutput.videoSettings = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:kCVPixelFormatType_32BGRA] forKey:(id)kCVPixelBufferPixelFormatTypeKey];
    
    [self.session addInput:self.videoInput];
    [self.session addOutput:self.frameOutput];
    [self.frameOutput setSampleBufferDelegate:self queue:dispatch_get_main_queue()];
    [self.session startRunning];
    //
    self.glasses = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"glasses.png"]];
    self.glasses.hidden = YES;
    self.glasses.frame = CGRectMake(100, 100, 100, 100);
    [self.imageView addSubview:self.glasses];
//    [self.view insertSubview:self.glasses aboveSubview:self.imageView];
    
   
}

- (void)viewDidUnload
{
    self.imageView = nil;
    [super viewDidUnload];
}


@end
