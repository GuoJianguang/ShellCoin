//
//  LocationManager.h
//  YN
//
//  Created by inphase on 15/11/17.
//  Copyright © 2015年 inphase. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <AMapLocationKit/AMapLocationKit.h>

typedef void(^LocationFinish)(NSString *city,NSString *areaName,NSError*error,BOOL success);


@interface LocationManager : NSObject<CLLocationManagerDelegate>

@property (nonatomic,strong) CLLocationManager *locationManager;
-(void) startLocation;
+(LocationManager*) sharedLocationManager;

@property (nonatomic,strong) CLLocation *currentLocation;


// 区域名称 eg. 武侯区
@property (nonatomic,copy) NSString *areaName;
// 城市
@property (nonatomic,copy) NSString *currentCity;
// 位置
@property (nonatomic,copy) NSString *location;

// 是否应该停止定位
@property(nonatomic,assign) BOOL stopedUpdateLocation;




// 定位结束，获得地址，或者失败回调
@property (nonatomic,copy) LocationFinish finishLocation;


//使用高德的定位
@property (nonatomic, strong) AMapLocationManager *gdLocationManager;


- (void)startLocationWithGDManager;

@end
