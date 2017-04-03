//
//  BussessMapViewController.m
//  天添薪
//
//  Created by ttx on 16/1/7.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import "BussessMapViewController.h"
#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import "CommonUtility.h"
#import "MANaviRoute.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>




const NSString *RoutePlanningViewControllerStartTitle       = @"起点";
const NSString *RoutePlanningViewControllerDestinationTitle = @"终点";
const NSInteger RoutePlanningPaddingEdge                    = 20;

@interface BussessMapViewController ()<UIActionSheetDelegate,MAMapViewDelegate,AMapSearchDelegate>


@property (nonatomic, strong) AMapSearchAPI *search;


@property (nonatomic, strong) AMapRoute *route;

/* 当前路线方案索引值. */
@property (nonatomic) NSInteger currentCourse;

/* 路线方案个数. */
@property (nonatomic) NSInteger totalCourse;


/* 用于显示当前路线方案. */
@property (nonatomic) MANaviRoute * naviRoute;
@property (nonatomic, strong) MAPointAnnotation *startAnnotation;
@property (nonatomic, strong) MAPointAnnotation *destinationAnnotation;

//是否已经规划路线
@property (nonatomic,assign)BOOL isGuihua;

@property (nonatomic, strong) MAMapView *mapView;

@end

@implementation BussessMapViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.naviBar.title = @"路线";

    
    CGRect rect = CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64 - 50);
    self.mapView = [[MAMapView alloc] initWithFrame:rect];
    [self.mapView setDelegate:self];
    [self.view addSubview:self.mapView];
    
    [self.mapView setUserTrackingMode:MAUserTrackingModeFollow animated:YES];
    [AMapServices sharedServices].apiKey = MAP_APPKEY_APPSTORE;
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;
    
    [self addDefaultAnnotations];
    
    ///把地图添加至view
    

    self.naviBtn_view.layer.cornerRadius = CGRectGetHeight(self.naviBtn_view.bounds)/2;
    self.naviBtn_view.layer.masksToBounds = YES;
    
    self.name_label.text = self.dataModel.name;

    self.address_label.text = self.dataModel.address;
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];


}


#pragma mark - 在地图上加起始点和终点
- (void)addDefaultAnnotations
{
    MAPointAnnotation *startAnnotation = [[MAPointAnnotation alloc] init];
    startAnnotation.coordinate = self.startCoordinate;
    startAnnotation.title      = (NSString*)RoutePlanningViewControllerStartTitle;
    startAnnotation.subtitle   = @"当前位置";
    self.startAnnotation = startAnnotation;
    
    MAPointAnnotation *destinationAnnotation = [[MAPointAnnotation alloc] init];
    destinationAnnotation.coordinate = self.destinationCoordinate;
    destinationAnnotation.title      = (NSString*)RoutePlanningViewControllerDestinationTitle;
    destinationAnnotation.subtitle   = self.dataModel.name;;
    self.destinationAnnotation = destinationAnnotation;
    
    [self.mapView addAnnotation:startAnnotation];
    [self.mapView addAnnotation:destinationAnnotation];
}


#pragma mark - 开始搜索路线
- (void)searchRoutePlanningDrive
{
    self.isGuihua = YES;
    self.startAnnotation.coordinate = self.startCoordinate;
    self.destinationAnnotation.coordinate = self.destinationCoordinate;
    
    AMapDrivingRouteSearchRequest *navi = [[AMapDrivingRouteSearchRequest alloc] init];
    //    navi.waypoints = @[[AMapGeoPoint locationWithLatitude:45.780563 longitude:126.651764]];
    //    navi.requireExtension = YES;
    //    navi.strategy = 5;
    /* 出发点. */
    navi.origin = [AMapGeoPoint locationWithLatitude:self.startCoordinate.latitude
                                           longitude:self.startCoordinate.longitude];
    /* 目的地. */
    navi.destination = [AMapGeoPoint locationWithLatitude:self.destinationCoordinate.latitude
                                                longitude:self.destinationCoordinate.longitude];
    
    [self.search AMapDrivingRouteSearch:navi];

}

#pragma mark - 定位到当前位置
-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation
updatingLocation:(BOOL)updatingLocation
{
    if(updatingLocation)
    {
        self.startCoordinate = userLocation.coordinate;
        //取出当前位置的坐标
        if (!self.isGuihua) {
            [self.mapView setCenterCoordinate:userLocation.coordinate animated:YES];
            [self searchRoutePlanningDrive];
        }
    }
}


/* 展示当前路线方案. */
- (void)presentCurrentCourse
{
    MANaviAnnotationType type = MANaviAnnotationTypeDrive;
    self.naviRoute = [MANaviRoute naviRouteForPath:self.route.paths[self.currentCourse] withNaviType:type showTraffic:YES startPoint:[AMapGeoPoint locationWithLatitude:self.startAnnotation.coordinate.latitude longitude:self.startAnnotation.coordinate.longitude] endPoint:[AMapGeoPoint locationWithLatitude:self.destinationAnnotation.coordinate.latitude longitude:self.destinationAnnotation.coordinate.longitude]];
    [self.naviRoute addToMapView:self.mapView];
    
    /* 缩放地图使其适应polylines的展示. */
    [self.mapView showOverlays:self.naviRoute.routePolylines edgePadding:UIEdgeInsetsMake(RoutePlanningPaddingEdge, RoutePlanningPaddingEdge, RoutePlanningPaddingEdge, RoutePlanningPaddingEdge) animated:YES];
}

/* 清空地图上已有的路线. */
- (void)clear
{
    [self.naviRoute removeFromMapView];
}
#pragma mark - MAMapViewDelegate

- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id<MAOverlay>)overlay
{
    if ([overlay isKindOfClass:[LineDashPolyline class]])
    {
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:((LineDashPolyline *)overlay).polyline];
        polylineRenderer.lineWidth   = 8;
        polylineRenderer.lineDashPattern = @[@10, @15];
        polylineRenderer.strokeColor = [UIColor redColor];
        
        return polylineRenderer;
    }
    if ([overlay isKindOfClass:[MANaviPolyline class]])
    {
        MANaviPolyline *naviPolyline = (MANaviPolyline *)overlay;
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:naviPolyline.polyline];
        
        polylineRenderer.lineWidth = 8;
        
        if (naviPolyline.type == MANaviAnnotationTypeWalking)
        {
            polylineRenderer.strokeColor = self.naviRoute.walkingColor;
        }
        else if (naviPolyline.type == MANaviAnnotationTypeRailway)
        {
            polylineRenderer.strokeColor = self.naviRoute.railwayColor;
        }
        else
        {
            polylineRenderer.strokeColor = self.naviRoute.routeColor;
        }
        
        return polylineRenderer;
    }
    if ([overlay isKindOfClass:[MAMultiPolyline class]])
    {
        MAMultiColoredPolylineRenderer * polylineRenderer = [[MAMultiColoredPolylineRenderer alloc] initWithMultiPolyline:overlay];
        
        polylineRenderer.lineWidth = 8;
        polylineRenderer.strokeColors = [self.naviRoute.multiPolylineColors copy];
        polylineRenderer.gradient = YES;
        
        return polylineRenderer;
    }
    
    return nil;
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *routePlanningCellIdentifier = @"RoutePlanningCellIdentifier";
        
        MAAnnotationView *poiAnnotationView = (MAAnnotationView*)[self.mapView dequeueReusableAnnotationViewWithIdentifier:routePlanningCellIdentifier];
        if (poiAnnotationView == nil)
        {
            poiAnnotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation
                                                             reuseIdentifier:routePlanningCellIdentifier];
        }
        
        poiAnnotationView.canShowCallout = YES;
        poiAnnotationView.image = nil;
        
        if ([annotation isKindOfClass:[MANaviAnnotation class]])
        {
            switch (((MANaviAnnotation*)annotation).type)
            {
                case MANaviAnnotationTypeRailway:
                    poiAnnotationView.image = [UIImage imageNamed:@"railway_station"];
                    break;
                    
                case MANaviAnnotationTypeBus:
                    poiAnnotationView.image = [UIImage imageNamed:@"bus"];
                    break;
                    
                case MANaviAnnotationTypeDrive:
                    poiAnnotationView.image = [UIImage imageNamed:@"car"];
                    break;
                    
                case MANaviAnnotationTypeWalking:
                    poiAnnotationView.image = [UIImage imageNamed:@"man"];
                    break;
                    
                default:
                    break;
            }
        }
        else
        {
            /* 起点. */
            if ([[annotation title] isEqualToString:(NSString*)RoutePlanningViewControllerStartTitle])
            {
                poiAnnotationView.image = [UIImage imageNamed:@"startPoint"];
            }
            /* 终点. */
            else if([[annotation title] isEqualToString:(NSString*)RoutePlanningViewControllerDestinationTitle])
            {
                poiAnnotationView.image = [UIImage imageNamed:@"endPoint"];
            }
            
        }
        
        return poiAnnotationView;
    }
    
    return nil;
}


#pragma mark - AMapSearchDelegate
- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error
{
    NSLog(@"Error: %@", error);
}

/* 路径规划搜索回调. */
- (void)onRouteSearchDone:(AMapRouteSearchBaseRequest *)request response:(AMapRouteSearchResponse *)response
{
    if (response.route == nil)
    {
        return;
    }
    
    self.route = response.route;
    [self updateTotal];
    self.currentCourse = 0;
    
    
    if (response.count > 0)
    {
        [self presentCurrentCourse];
    }
}
- (void)updateTotal
{
    self.totalCourse = self.route.paths.count;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -  导航按钮点击事件
- (IBAction)naviBtn:(UIButton *)sender
{
    NSString *gaode;
    
    UIActionSheet *sheetView = [[UIActionSheet alloc]initWithTitle:@"请选择地图" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"使用自带地图导航" otherButtonTitles:nil];
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]]) {
        gaode = @"使用高德地图导航";
        [sheetView addButtonWithTitle:gaode];
    }else{
        gaode = nil;
    }
    
    [sheetView showInView:self.view];
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    NSString *type = @"path";
    NSString *sourceApplication = @"THYY";
    NSString *backScheme = @"THYYGaode";
    //源id
    NSString *sid = @"BGVIS1";
    //起点名称
    NSString *sname = @"";
    //目的地id
    NSString *did = @"BGVIS2";
    //起点经纬度
    NSString *lat = @"";
    NSString *lon = @"";
    //终点经纬度
    NSString *dlat = [NSString stringWithFormat:@"%f",self.destinationCoordinate.latitude];
    NSString *dlon = [NSString stringWithFormat:@"%f",self.destinationCoordinate.longitude];
    //终点名称
    NSString *dname = self.dataModel.name;
    //线路类型
    NSString *m = @"0";
    //导航类型
    NSString *t = [NSString stringWithFormat:@"%d",0];
    NSString *dev = @"1";
    
//    MANaviConfig * config = [[MANaviConfig alloc] init];
//    config.destination = self.destinationCoordinate;
//    config.appScheme = backScheme;
//    config.appName = sourceApplication;
//    config.strategy = MADrivingStrategyShortest;
    
    if ([buttonTitle isEqualToString:@"使用自带地图导航"]) {
        //当前的位置
        MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
        //起点
        //目的地的位置
        MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:self.destinationCoordinate addressDictionary:nil]];
        
        toLocation.name = self.dataModel.name;
        NSArray *items = [NSArray arrayWithObjects:currentLocation, toLocation, nil];
        NSDictionary *options = @{ MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving, MKLaunchOptionsMapTypeKey: [NSNumber numberWithInteger:MKMapTypeStandard], MKLaunchOptionsShowsTrafficKey:@YES };
        //打开苹果自身地图应用，并呈现特定的item
        [MKMapItem openMapsWithItems:items launchOptions:options];
        
    }else if ([buttonTitle isEqualToString:@"使用高德地图导航"]){
        NSString *str = [NSString stringWithFormat:@"iosamap://%@?sourceApplication=%@&sid=%@&slat=%@&slon=%@&sname=%@&did=%@&dlat=%@&dlon=%@&dname=%@&dev=%@&m=%@&t=%@",type,sourceApplication,sid,lat,lon,sname,did,dlat,dlon,dname,dev,m,t];
        NSString *str1 = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:str1]];
    }
}








- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [self.mapView clearDisk];
//    self.mapView = nil;
}


@end
