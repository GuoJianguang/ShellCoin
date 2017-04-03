//
//  BussessMapViewController.h
//  天添薪
//
//  Created by ttx on 16/1/7.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import "BaseViewController.h"
#import "MerchantModel.h"
#import <MAMapKit/MAMapKit.h>




@interface BussessMapViewController : BaseViewController

@property (nonatomic, strong)MerchantModel *dataModel;

//@property (nonatomic, strong) MAMapView *mapView;


/* 起始点经纬度. */
@property (nonatomic) CLLocationCoordinate2D startCoordinate;
/* 终点经纬度. */
@property (nonatomic) CLLocationCoordinate2D destinationCoordinate;



@property (weak, nonatomic) IBOutlet UIView *naviView;

@property (weak, nonatomic) IBOutlet UILabel *name_label;

@property (weak, nonatomic) IBOutlet UILabel *address_label;

@property (weak, nonatomic) IBOutlet UIView *naviBtn_view;

@property (weak, nonatomic) IBOutlet UIButton *naviBtn;
- (IBAction)naviBtn:(UIButton *)sender;

@end
