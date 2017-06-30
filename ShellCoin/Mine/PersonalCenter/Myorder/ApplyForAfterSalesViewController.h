//
//  ApplyForAfterSalesViewController.h
//  ShellCoin
//
//  Created by mac on 2017/6/15.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "BaseViewController.h"
#import "MyorderViewController.h"
@class OrderModel;

@interface ApplyForAfterSalesViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIView *view3;
@property (weak, nonatomic) IBOutlet UIView *view4;

@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *label4;

@property (weak, nonatomic) IBOutlet UITextField *logCommpanuyTF;

@property (weak, nonatomic) IBOutlet UITextField *refundResonTF;
@property (weak, nonatomic) IBOutlet UITextField *logNumberTF;
@property (weak, nonatomic) IBOutlet UITextField *refundExpainTF;

@property (nonatomic, strong)OrderModel *dataModel;
- (IBAction)selcetCommpayBtn:(UIButton *)sender;

@property (nonatomic, assign)Myorder_type  orderType;

@end
