//
//  AddressTableViewCell.m
//  ShellCoin
//
//  Created by mac on 2017/5/25.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "AddressTableViewCell.h"
#import "EditAddressViewController.h"

@implementation ShippingAddressModel

+ (id)modelWithDic:(NSDictionary *)dic
{
    ShippingAddressModel *model = [[ShippingAddressModel alloc]init];
    model.addressId = NullToSpace(dic[@"id"]);
    model.addressDetail = NullToSpace(dic[@"addressDetail"]);
    model.name = NullToSpace(dic[@"name"]);
    model.phone = NullToSpace(dic[@"phone"]);
    model.address = NullToSpace(dic[@"address"]);
    model.province = NullToSpace(dic[@"province"]);
    model.defaultFlag = NullToSpace(dic[@"defaultFlag"]);
    model.zipCode = NullToSpace(dic[@"zipCode"]);
    model.city = NullToSpace(dic[@"city"]);
    model.zone = NullToSpace(dic[@"zone"]);
    model.createTime = NullToSpace(dic[@"createTime"]);
    model.modifyTime = NullToSpace(dic[@"modifyTime"]);
    
    return model;
}

@end

@implementation AddressTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.shippingName.textColor = self.phoneLabel.textColor =MacoTitleColor;
    self.shippingAddress.textColor = MacoDetailColor;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setDataModel:(ShippingAddressModel *)dataModel
{
    _dataModel = dataModel;
    self.shippingName.text = _dataModel.name;
    self.shippingAddress.text = _dataModel.addressDetail;
    self.phoneLabel.text = [NSString stringWithFormat:@"%@",_dataModel.phone];
}
- (IBAction)eidtAddress:(UIButton *)sender {
    EditAddressViewController *editVC = [[EditAddressViewController alloc]init];
    editVC.isAddAddress = NO;
    editVC.addressModel = self.dataModel;
    [self.viewController.navigationController pushViewController:editVC animated:YES];
}
@end
