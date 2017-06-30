//
//  AfterSalesDetailViewController.h
//  ShellCoin
//
//  Created by mac on 2017/6/15.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "BaseViewController.h"

@class OrderModel;

@interface AfterSalesDetailViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UILabel *shellCoinLabel;

@property (weak, nonatomic) IBOutlet UILabel *buyCardLabel;
@property (weak, nonatomic) IBOutlet UILabel *payWayLabel;
@property (weak, nonatomic) IBOutlet UILabel *backTotalLabel;
@property (weak, nonatomic) IBOutlet UILabel *shellCoin;

@property (weak, nonatomic) IBOutlet UILabel *buyCard;
@property (weak, nonatomic) IBOutlet UILabel *payWay;
@property (weak, nonatomic) IBOutlet UILabel *backTotal;
@property (weak, nonatomic) IBOutlet UILabel *aderessLabel;
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIView *view3;
@property (weak, nonatomic) IBOutlet UIView *view4;
@property (weak, nonatomic) IBOutlet UILabel *label1;

@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *label4;

@property (weak, nonatomic) IBOutlet UITextField *storeNameTF;

@property (weak, nonatomic) IBOutlet UITextField *backWayTF;
@property (weak, nonatomic) IBOutlet UITextField *resonTF;
@property (weak, nonatomic) IBOutlet UITextField *expainTF;


@property (nonatomic, strong)OrderModel *dataModel;

@end
