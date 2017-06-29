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
    MyorderViewController *billVC = [[MyorderViewController alloc]init];
    [self.viewController.navigationController pushViewController:billVC animated:YES];
    [self removeFromSuperview];
}

- (IBAction)sureBtn:(UIButton *)sender {
    
    
    [self.viewController.navigationController popViewControllerAnimated:YES];
    [self removeFromSuperview];
}

- (void)setPayType:(Mall_PayTYpe )payType
{
    _payType = payType;
    switch (payType) {
        case Mall_PayTYpe_wechat:
            self.lineView.hidden=self.backBtn.hidden = self.checkBill.hidden = NO;
            [self.sureBtn setTitle:@"" forState:UIControlStateNormal];
            break;
        case Mall_PayTYpe_alipay:
            self.lineView.hidden=self.backBtn.hidden = self.checkBill.hidden = NO;
            [self.sureBtn setTitle:@"" forState:UIControlStateNormal];
            break;
        case Mall_PayTYpe_blance:
            self.lineView.hidden=self.backBtn.hidden = self.checkBill.hidden = NO;
            [self.sureBtn setTitle:@"" forState:UIControlStateNormal];
            break;
        default:
            break;
    }
}

@end
