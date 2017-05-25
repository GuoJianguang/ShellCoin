//
//  SureDiscoverOrderTableViewCell.m
//  ShellCoin
//
//  Created by mac on 2017/5/25.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "SureDiscoverOrderTableViewCell.h"
#import "SelectShippingAddressViewController.h"

@implementation SureDiscoverOrderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.wechatImage.image = [UIImage imageNamed:@"icon_wechat_payment_sel"];
    self.wechatBtn.selected = YES;
    self.wechatLabel.textColor = MacoColor;
    self.wechatMarkBtn.hidden = NO;
    
    self.aliPayMarkBtn.hidden = YES;
    self.aliPayLabel.textColor  = MacoTitleColor;
    self.aliPayMarkBtn.hidden  = YES;
    self.aliPaytBtn.selected = NO;
    self.aliPayImage.image = [UIImage imageNamed:@"icon_zhifubao_nor"];
    
    self.name.textColor = self.phone.textColor = self.addressLabel.textColor = self.goodsName.textColor = self.goodsInfoLabel.textColor = self.paywayLabel.textColor = self.goodsNumber.textColor=MacoTitleColor;
    self.goodsAmount.textColor = MacoColor;
    self.address.textColor = self.goodsPrice.textColor = MacoDetailColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (IBAction)wechatBtn:(UIButton *)sender
{
    self.wechatImage.image = [UIImage imageNamed:@"icon_wechat_payment_sel"];
    self.wechatBtn.selected = YES;
    self.wechatLabel.textColor = MacoColor;
    self.wechatMarkBtn.hidden = NO;
    
    self.aliPayLabel.textColor  = MacoTitleColor;
    self.aliPayMarkBtn.hidden  = YES;
    self.aliPaytBtn.selected = NO;
    self.aliPayImage.image = [UIImage imageNamed:@"icon_zhifubao_nor"];
}

- (IBAction)aliPay:(UIButton *)sender
{
    self.aliPayImage.image = [UIImage imageNamed:@"icon_zhifubao_sel"];
    self.aliPaytBtn.selected = YES;
    self.aliPayLabel.textColor = MacoColor;
    self.aliPayMarkBtn.hidden = NO;
    
    
    self.wechatLabel.textColor  = MacoTitleColor;
    self.wechatMarkBtn.hidden  = YES;
    self.wechatBtn.selected = NO;
    self.wechatImage.image = [UIImage imageNamed:@"icon_wechat_payment_nor"];
}

- (IBAction)editAddressBtn:(UIButton *)sender {
    
    SelectShippingAddressViewController *addressVC = [[SelectShippingAddressViewController alloc]init];
    [self.viewController.navigationController pushViewController:addressVC animated:YES];
}
@end
