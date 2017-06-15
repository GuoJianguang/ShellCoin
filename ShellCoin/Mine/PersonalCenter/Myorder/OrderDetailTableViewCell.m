//
//  OrderDetailTableViewCell.m
//  ShellCoin
//
//  Created by mac on 2017/6/14.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "OrderDetailTableViewCell.h"

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
}
- (IBAction)checkLogBtn:(UIButton *)sender {
}
- (IBAction)applyAfterSalesBtn:(UIButton *)sender {
}
@end
