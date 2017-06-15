//
//  OrderDetailTableViewCell.m
//  ShellCoin
//
//  Created by mac on 2017/6/14.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "OrderDetailTableViewCell.h"
#import "ApplyForAfterSalesViewController.h"
#import "LogisticsViewController.h"
#import "BuyRecodTableViewCell.h"
#import "WaitAfterForSalesViewController.h"


@implementation OrderDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.sureShippBtn.titleLabel.adjustsFontSizeToFitWidth = self.checkLogBtn.titleLabel.adjustsFontSizeToFitWidth = self.applyAfterSalesBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    self.sureShippBtn.layer.borderWidth = 1;
    self.sureShippBtn.layer.borderColor = MacoColor.CGColor;
    [self.sureShippBtn setTitleColor:MacoColor forState:UIControlStateNormal];
    self.sureShippBtn.layer.masksToBounds = YES;
    self.sureShippBtn.layer.cornerRadius = 86/2.6/2.;
    
    self.checkLogBtn.layer.borderWidth = 1;
    self.checkLogBtn.layer.borderColor =MacoTitleColor.CGColor;
    [self.checkLogBtn setTitleColor:MacoTitleColor forState:UIControlStateNormal];
    self.checkLogBtn.layer.masksToBounds = YES;
    self.checkLogBtn.layer.cornerRadius = 86/2.6/2.;
    
    
    self.applyAfterSalesBtn.layer.borderWidth = 1;
    self.applyAfterSalesBtn.layer.borderColor =MacoTitleColor.CGColor;
    [self.applyAfterSalesBtn setTitleColor:MacoTitleColor forState:UIControlStateNormal];
    self.applyAfterSalesBtn.layer.masksToBounds = YES;
    self.applyAfterSalesBtn.layer.cornerRadius = 86/2.6/2.;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (IBAction)checkStore:(UIButton *)sender {
    
}
- (IBAction)sureShippBtn:(UIButton *)sender {
    [[NSNotificationCenter defaultCenter]postNotificationName:@"orderDetailsureReceiving" object:nil];
}
- (IBAction)checkLogBtn:(UIButton *)sender {
    LogisticsViewController *logisticsVC = [[LogisticsViewController alloc]init];
    BuyRecodeModel *model = [[BuyRecodeModel alloc]init];
    model.buyId = @"2017053114392602100001";
    model.logisticsCompany = @"顺丰快递";
    model.logisticsNumber = @"602714487633";
    model.logisticsCompanyCode = @"SF";
    model.deliverFlag = @"1";
    logisticsVC.dataModel = model;
    [self.viewController.navigationController pushViewController:logisticsVC animated:YES];
}
- (IBAction)applyAfterSalesBtn:(UIButton *)sender {
    
    
    WaitAfterForSalesViewController *waitVC = [[WaitAfterForSalesViewController alloc]init];
    [self.viewController.navigationController pushViewController:waitVC animated:YES];
    return;
    ApplyForAfterSalesViewController *applyVC = [[ApplyForAfterSalesViewController alloc]init];
    [self.viewController.navigationController pushViewController:applyVC animated:YES];
}



- (void)setOrderType:(Myorder_type)orderType
{
    switch (orderType) {
        case Myorder_type_waitSendGoods:
        {
            self.checkLogBtnWidth.constant = 0;
            self.checkLogBtn.hidden = YES;
            self.sureShippBthWidth.constant = 0;
            self.sureShippBtn.hidden = YES;
        }
            break;
        case Myorder_type_waitReceiveGoods:
        {
            
        }
            break;
        case Myorder_type_compelte:
        {
            self.sureShippBthWidth.constant = 0;
            self.sureShippBtn.hidden = YES;
            self.checkLogBtnWidth.constant = 0;
            self.checkLogBtn.hidden = YES;
        }
            break;
        default:
            break;
    }
}


@end
