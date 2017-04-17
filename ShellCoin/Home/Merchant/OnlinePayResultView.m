//
//  OnlinePayResultView.m
//  ShellCoin
//
//  Created by Guo on 2017/4/4.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "OnlinePayResultView.h"
#import "BillViewController.h"

@implementation OnlinePayResultView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self = [[NSBundle mainBundle]loadNibNamed:@"OnlinePayResultView" owner:nil options:nil][0];
    }
    return  self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.autResultLabel.textColor = self.successLabel.textColor = MacoTitleColor;
    self.autResultLabel.adjustsFontSizeToFitWidth = YES;
    self.autResultLabel.numberOfLines = 2;
    
    if (TWitdh > 320) {
        self.ViewHeight.constant = (TWitdh-100)*(550/520.);
    }else{
        self.ViewHeight.constant = (TWitdh-100)*(650/520.);
    }
}


- (IBAction)backBtn:(id)sender{
    [self.viewController.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)checkBill:(id)sender {
    BillViewController *billVC = [[BillViewController alloc]init];
    [self.viewController.navigationController pushViewController:billVC animated:YES];
    [self removeFromSuperview];
}

- (IBAction)sureBtn:(UIButton *)sender {
    
    if (self.payType == Merchant_PayTYpe_YuE) {
        return;
    }
    [self.viewController.navigationController popViewControllerAnimated:YES];
    [self removeFromSuperview];
}

- (void)setPayType:(Merchant_PayTYpe)payType
{
    _payType = payType;
    switch (payType) {
        case Merchant_PayTYpe_YuE:
            self.lineView.hidden=self.backBtn.hidden = self.checkBill.hidden = NO;
            [self.sureBtn setTitle:@"" forState:UIControlStateNormal];
            break;
        case Merchant_PayTYpe_Cash:
            [self.sureBtn setTitle:@"返回" forState:UIControlStateNormal];
            self.lineView.hidden=self.backBtn.hidden = self.checkBill.hidden = YES;
            self.sureBtn.hidden = NO;
            break;
            
        default:
            break;
    }
}

@end
