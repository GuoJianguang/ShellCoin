//
//  SureDiscoverOrderTableViewCell.m
//  ShellCoin
//
//  Created by mac on 2017/5/25.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "SureDiscoverOrderTableViewCell.h"
#import "SelectShippingAddressViewController.h"

@implementation DiscoverGoodsDetailModel

+ (id)modelWithDic:(NSDictionary *)dic
{
    DiscoverGoodsDetailModel *model = [[DiscoverGoodsDetailModel alloc]init];
    model.name = NullToSpace(dic[@"name"]);
    model.slideImages = NullToSpace(dic[@"slideImages"]);
    model.picDescs = NullToSpace(dic[@"picDescs"]);
    model.txtDesc = NullToSpace(dic[@"txtDesc"]);
    model.cashAmount = NullToNumber(dic[@"cashAmount"]);
    model.expectAmount = NullToNumber(dic[@"expectAmount"]);
    model.consumeAmount = NullToNumber(dic[@"consumeAmount"]);
    model.freeFeight = NullToNumber(dic[@"freeFeight"]);
    model.hasInventory = NullToNumber(dic[@"hasInventory"]);
    model.coverImage = NullToSpace(dic[@"coverImage"]);
    model.freight = NullToNumber(dic[@"freight"]);
    return model;
}

@end

@implementation SureDiscoverOrderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.wechatImage.image = [UIImage imageNamed:@"icon_wechat_payment_sel"];
    self.wechatBtn.selected = YES;
    self.wechatLabel.textColor = MacoColor;
    self.wechatMarkBtn.hidden = NO;
    
    self.aliPayMarkBtn.hidden = YES;
    self.aliPayLabel.textColor  =  MacoTitleColor;
    self.aliPayMarkBtn.hidden  = YES;
    self.aliPaytBtn.selected = NO;
    self.aliPayImage.image = [UIImage imageNamed:@"icon_zhifubao_nor"];
    
    self.name.textColor = self.phone.textColor = self.addressLabel.textColor = self.goodsName.textColor = self.goodsInfoLabel.textColor = self.paywayLabel.textColor = self.goodsNumber.textColor=MacoTitleColor;
    self.goodsAmount.textColor = MacoColor;
    self.address.textColor = self.goodsPrice.textColor = MacoDetailColor;
    
    self.pay_type = DiscoverPayway_type_wechat;
    
    [self.addAddressBtn setTitleColor:MacoTitleColor forState:UIControlStateNormal];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}




- (void)setDataModel:(DiscoverGoodsDetailModel *)dataModel
{
    _dataModel = dataModel;
    [self.goodsImage sd_setImageWithURL:[NSURL URLWithString:_dataModel.coverImage] placeholderImage:LoadingErrorDefaultImageCircular];
    self.goodsName.text = _dataModel.name;
    
    self.goodsPrice.text = [NSString stringWithFormat:@"¥%.2f",[_dataModel.cashAmount doubleValue] + [_dataModel.expectAmount doubleValue]];
    self.goodsNumber.text = [NSString stringWithFormat:@"*%ld",self.number];
    self.goodsAmount.text = [NSString stringWithFormat:@"¥%.2f",([_dataModel.cashAmount doubleValue] + [_dataModel.expectAmount doubleValue])*self.number];
}

- (void)setAddressModel:(ShippingAddressModel *)addressModel
{
    _addressModel = addressModel;

    if (!_addressModel.addressId) {
        self.name.hidden = YES;
        self.address.hidden = YES;
        self.phone.hidden = YES;
        self.addAddressBtn.hidden = NO;
    }else{
        self.name.hidden = NO;
        self.address.hidden = NO;
        self.phone.hidden = NO;
        self.addAddressBtn.hidden = YES;
        self.name.text = [NSString stringWithFormat:@"收货人:%@",NullToSpace(_addressModel.name)];
        self.phone.text = [NSString stringWithFormat:@"%@",NullToSpace(_addressModel.phone)];
        self.address.text = [NSString stringWithFormat:@"收货地址:%@",NullToSpace(_addressModel.addressDetail)];
    }


}


- (IBAction)wechatBtn:(UIButton *)sender
{
    self.pay_type = DiscoverPayway_type_wechat;
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
    self.pay_type = DiscoverPayway_type_alipay;
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
- (IBAction)addAddressBtn:(UIButton *)sender {
    SelectShippingAddressViewController *addressVC = [[SelectShippingAddressViewController alloc]init];
    [self.viewController.navigationController pushViewController:addressVC animated:YES];
}
@end
