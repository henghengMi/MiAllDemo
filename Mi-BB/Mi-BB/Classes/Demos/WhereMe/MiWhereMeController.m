//
//  MiWhereMeController.m
//  Mi-BB
//
//  Created by YuanMiaoHeng on 16/4/23.
//  Copyright © 2016年 Mi. All rights reserved.
//

#import "MiWhereMeController.h"
#import <CoreLocation/CoreLocation.h>

@interface MiWhereMeController ()<CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *label;
@property(nonatomic,strong) CLLocationManager *mgr;
@end

@implementation MiWhereMeController

- (CLLocationManager *)mgr
{
    if (!_mgr) {
        _mgr = [[CLLocationManager alloc] init];
        
        // 代理
        _mgr.delegate = self;
        
        
        //   // 位置间隔之后重新定位
        //    _mgr.distanceFilter = 10;
        //
        //    // 定位精确度
        _mgr.desiredAccuracy = kCLLocationAccuracyBest;
        
    }
    return _mgr;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self makePosition];
}

#pragma mark 定位
- (IBAction)makePosition {
    
    [MBProgressHUD showMessage:@"正在找你。" toView:self.view];
    
    // 如果是ios8要主动授权，并且infoPlist文件要配置  Location Usage Description : 请求授权时说明
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        
        // 请求授权
        [self.mgr requestWhenInUseAuthorization];
        //        // 开始更新位置
        //        [self.mgr startUpdatingLocation];
    }
    else
    {
        // 开始更新位置
        [self.mgr startUpdatingLocation];
    }
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0) {
        //        self.mgr.allowsBackgroundLocationUpdates = YES;
    }

    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self makePosition];
}

// 改变授权状态。
-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    
    /*
     用户从未选择过权限
     kCLAuthorizationStatusNotDetermined
     
     无法使用定位服务，该状态用户无法改变
     kCLAuthorizationStatusRestricted,
     
     用户拒绝使用定位服务，或者定位服务总开关处于关闭状态
     kCLAuthorizationStatusDenied,
     
     用户允许该程序无论何时都可以使用地理信息
     kCLAuthorizationStatusAuthorizedAlways NS_ENUM_AVAILABLE(NA, 8_0),
     
     用户同意程序在可见时使用地理位置
     kCLAuthorizationStatusAuthorizedWhenInUse NS_ENUM_AVAILABLE(NA, 8_0),
     */
    
    if (status == kCLAuthorizationStatusNotDetermined) {
        NSLog(@"等待用户授权");
        
    } else if (status == kCLAuthorizationStatusAuthorizedAlways ||
               status == kCLAuthorizationStatusAuthorizedWhenInUse)
    {
        NSLog(@"ios8授权成功");
        [self.mgr startUpdatingLocation];
        
    }
    else
    {
        NSLog(@"授权失败、或者定位开关没开");
    }
}


- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    
    NSLog(@"更新了位置");
    CLLocation *location = [locations lastObject];
    
    // 拿到经纬度
    CLLocationCoordinate2D coordinate = location.coordinate;
    NSLog(@"经度：%f 纬度: %f", coordinate.longitude ,coordinate.latitude);
    
    // 反地理编码
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        NSLog(@"placemarks %ld",placemarks.count);
        if (placemarks.count == 0 || error) return ;
        CLPlacemark *pm = [placemarks firstObject];
        
        // 城市名处理
        if (pm.locality) { //不是直辖市如广州 locality 属性才是城市名
            NSLog(@"%@",pm.locality);
        } else // 是直辖市如北京 administrativeArea 属性才能正确显示城市名
        {
            NSLog(@"%@",pm.administrativeArea);
        }
        
        NSString *detailAddress = [pm.addressDictionary[@"FormattedAddressLines"] firstObject];
        NSString *name = pm.name;
        // 具体地址 拼接 名字
        self.label.text = [NSString stringWithFormat:@"地址：%@ \n名字：%@",detailAddress,name];
         NSLog(@"  self.label.text%@",  self.label.text);
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
    }];
    
    // 2.停止定位
    [manager stopUpdatingLocation];
    
}
@end
