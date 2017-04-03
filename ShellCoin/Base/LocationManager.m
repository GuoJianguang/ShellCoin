//
//  LocationManager.m
//  YN
//
//  Created by inphase on 15/11/17.
//  Copyright © 2015年 inphase. All rights reserved.
//
#import "LocationManager.h"
//#import "LocationModel.h"

@interface LocationManager()<AMapLocationManagerDelegate>
@end

@implementation LocationManager

@synthesize gdLocationManager = _gdLocationManager;

- (instancetype)init
{ 
    self = [super init];
    if (self) {
        _locationManager = [[CLLocationManager alloc]init];
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.delegate = self;
        
        //高德定位
        self.gdLocationManager = [[AMapLocationManager alloc]init];
        self.gdLocationManager.delegate = self;
    }
    return self;
}

+(LocationManager *)sharedLocationManager {

    static LocationManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[LocationManager alloc]init];
    });
    
    return instance;
}


#pragma mark - 使用系统自带定位

-(void)startLocation {

    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        [_locationManager requestWhenInUseAuthorization];
    }
//    [SVProgressHUD showWithStatus:@"正在定位..."];
//    [_locationManager startUpdatingLocation];
    _stopedUpdateLocation = NO;
}


#pragma mark - location manager delegate
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {

//    NSLog(@"---%f",manager.location.coordinate.latitude);
    [ShellCoinUserInfo shareUserInfos].locationCoordinate = manager.location.coordinate;
    // 已经不需要再定位了
    if (_stopedUpdateLocation) {
        [manager stopUpdatingLocation];
        return;
    }
    
    if ([locations count] > 0) {
        self.currentLocation = [locations lastObject];
    }
    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:[locations lastObject] completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *mark = [placemarks objectAtIndex:0];
        NSString *city = mark.locality;
        if(city) {
            [_locationManager stopUpdatingLocation];
            _stopedUpdateLocation = YES;
            self.currentCity = city;
            self.location = [NSString stringWithFormat:@"%@%@%@",mark.administrativeArea,mark.locality,mark.subLocality];
            self.areaName = mark.subLocality;

            if (self.finishLocation) {
                self.finishLocation(city,self.areaName,nil,YES);
            }
        }
        else {
            if (self.finishLocation) {
//                self.finishLocation(nil,@"",nil,NO);
            }
        }
    }];
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
//    [SVProgressHUD dismiss];
//    [[UIAlertViewHelper shareAlterHelper]showTint:@"定位失败,您可以手动选择城市" duration:1.5];
    
    if (self.finishLocation) {
        self.finishLocation(nil,@"",nil,NO);
    }
}


#pragma mark - 使用高德地图定位

- (void)startLocationWithGDManager
{
    [self.gdLocationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    self.gdLocationManager.locationTimeout =2;
    //   逆地理请求超时时间，最低2s，此处设置为2s
    self.gdLocationManager.reGeocodeTimeout = 2;
    [self.gdLocationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        [ShellCoinUserInfo shareUserInfos].locationCoordinate = location.coordinate;
        if (error)
        {
            NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
            
            if (error.code == AMapLocationErrorLocateFailed)
            {
                self.finishLocation(@"成都市",regeocode.district,nil,YES);
                
                return;
            }
        }
        NSLog(@"location:%@", location);
        
        if (regeocode)
        {
            self.currentCity = regeocode.city;
            NSLog(@"reGeocode:%@", regeocode);
            self.finishLocation(regeocode.city,regeocode.district,nil,YES);
            
        }
    }];
}


@end
