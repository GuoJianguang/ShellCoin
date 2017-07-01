//
//  OnlinePayResultView.m
//  ShellCoin
//
//  Created by Guo on 2017/4/4.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "MallPayResultView.h"
#import "BuyRecodViewController.h"
#import "MyorderViewController.h"



@implementation MallPayResultView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self = [[NSBundle mainBundle]loadNibNamed:@"MallPayResultView" owner:nil options:nil][0];
        self.autResultTitleLabel.textColor = MacoColor;
        self.autResultTitleLabel.adjustsFontSizeToFitWidth = YES;
        self.autResultLabel.textColor = MacoDetailColor;
        [self.checkBill setTitleColor:MacoTitleColor forState:UIControlStateNormal];
        [self.backBtn setTitleColor:MacoTitleColor forState:UIControlStateNormal];
        self.backgroundColor = [UIColor colorFromHexString:@"#faf8f6"];

    }
    return  self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.autResultLabel.adjustsFontSizeToFitWidth = YES;
    self.autResultLabel.numberOfLines = 2;
    
    if (TWitdh > 320) {
        self.leading.constant = 40;
        self.trailing.constant = 40;
    }else{
        self.leading.constant = 40;
        self.trailing.constant = 40;
    }
}


- (IBAction)backBtn:(id)sender{
    [self.viewController.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)checkBill:(id)sender {
    MyorderViewController *billVC = [[MyorderViewController alloc]init];
    billVC.orderType = Myorder_type_waitSendGoods;
    billVC.isFormMall = YES;
    [self.viewController.navigationController pushViewController:billVC animated:YES];
//    [self removeFromSuperview];20
    
}


- (void)setPayType:(Mall_PayTYpe )payType
{
    _payType = payType;

}

@end
