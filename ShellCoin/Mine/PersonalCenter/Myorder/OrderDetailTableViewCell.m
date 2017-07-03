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
#import "OrderModel.h"
#import "StoreDetailViewController.h"

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
    
    self.nameLabel.textColor = self.phoneLabel.textColor = self.addressLabel.textColor = self.store.textColor = self.storeLabel.textColor = self.goodsName.textColor = self.goodsNum.textColor = self.goodsInfo.textColor = self.freight.textColor = self.freightLabel.textColor = self.buyCard.textColor = self.buyCardLabel.textColor = self.shellCoin.textColor = self.shellCoinLabel.textColor = self.actualMoney.textColor = self.actualMoneyLabel.textColor = self.totalMoney.textColor = self.totalMoneyLabel.textColor = MacoTitleColor;
    self.goodsDetail.textColor = self.addressLabel.textColor=MacoDetailColor;

    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (IBAction)checkStore:(UIButton *)sender {
    StoreDetailViewController *storeDetailVC = [[StoreDetailViewController alloc]init];
    storeDetailVC.mchCode = self.dataModel.mchCode;
    [self.viewController.navigationController pushViewController:storeDetailVC animated:YES];
}
- (IBAction)sureShippBtn:(UIButton *)sender {
    if ([self.dataModel.state isEqualToString:@"4"]) {
        //确认收货
        UIAlertController *alertcontroller = [UIAlertController alertControllerWithTitle:@"重要提示" message:@"该订单正在申请售后中，如果确认收货的话，将默认为您取消该订单的售后申请。是否继续？" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"点错了" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            
        }];
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [[NSNotificationCenter defaultCenter]postNotificationName:@"orderDetailsureReceiving" object:nil];

        }];
        [alertcontroller addAction:cancelAction];
        [alertcontroller addAction:otherAction];
        [self.viewController presentViewController:alertcontroller animated:YES completion:NULL];
        
        return;


    }
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"orderDetailsureReceiving" object:nil];
}
- (IBAction)checkLogBtn:(UIButton *)sender {
    LogisticsViewController *logisticsVC = [[LogisticsViewController alloc]init];
    BuyRecodeModel *model = [[BuyRecodeModel alloc]init];
    model.buyId = self.dataModel.orderId;
    model.logisticsCompany = self.dataModel.logisticsCompany;
    model.logisticsNumber = self.dataModel.logisticsNumber;
    model.logisticsCompanyCode = self.dataModel.logisticsCompanyCode;
    model.deliverFlag = @"1";
    logisticsVC.dataModel = model;
    [self.viewController.navigationController pushViewController:logisticsVC animated:YES];

}
- (IBAction)applyAfterSalesBtn:(UIButton *)sender {

    switch ([self.dataModel.state integerValue]) {
        case 4:
        {
            WaitAfterForSalesViewController *waitVC = [[WaitAfterForSalesViewController alloc]init];
            waitVC.dataModel = self.dataModel;
            [self.viewController.navigationController pushViewController:waitVC animated:YES];
            return;
        }
            break;
            
        case 3:
        {
            //删除订单
            UIAlertController *alertcontroller = [UIAlertController alertControllerWithTitle:@"重要提示" message:@"您是否确认要删除该订单" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"点错了" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            }];
            UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                //取消订单
                NSDictionary *parms = @{@"orderId":self.dataModel.orderId,
                                        @"token":[ShellCoinUserInfo shareUserInfos].token};
                [HttpClient POST:@"shop/order/delete" parameters:parms success:^(NSURLSessionDataTask *operation, id jsonObject) {
                    if (IsRequestTrue) {
                        [[JAlertViewHelper shareAlterHelper]showTint:@"删除订单成功" duration:2.];
                        [[NSNotificationCenter defaultCenter]postNotificationName:@"cancelOrder" object:nil];
                        [self.viewController.navigationController popViewControllerAnimated:YES];

                    }
                    
                } failure:^(NSURLSessionDataTask *operation, NSError *error) {
                    [[JAlertViewHelper shareAlterHelper]showTint:@"取消失败，请重试" duration:2.];
                    
                }];
                
            }];
            [alertcontroller addAction:cancelAction];
            [alertcontroller addAction:otherAction];
            [self.viewController presentViewController:alertcontroller animated:YES completion:NULL];
            

            
            return;
        }
            break;
        default:
            break;
    }
    
    ApplyForAfterSalesViewController *applyVC = [[ApplyForAfterSalesViewController alloc]init];
    applyVC.dataModel = self.dataModel;
    applyVC.orderType = self.orderType;
    [self.viewController.navigationController pushViewController:applyVC animated:YES];
}

- (void)setDataModel:(OrderModel *)dataModel
{
    _dataModel = dataModel;
    self.nameLabel.text = _dataModel.receiptPeople;
    self.phoneLabel.text = _dataModel.receiptPhone;
    self.addressLabel.text = _dataModel.receiptAddress;
    
    self.storeLabel.text = _dataModel.mchName;
    
    [self.goodsImage sd_setImageWithURL:[NSURL URLWithString:_dataModel.goodsImage] placeholderImage:LoadingErrorDefaultImageSquare];
    self.goodsName.text = _dataModel.goodsName;
    self.goodsNum.text = [NSString stringWithFormat:@"*%@",_dataModel.quantity];
    
    self.price.text = [NSString stringWithFormat:@"¥%.2f", [_dataModel.goodsPrice doubleValue] ];
    self.goodsDetail.text = _dataModel.goodsSpecDesc;
    
    self.freight.text = [NSString stringWithFormat:@"¥%.2f",[_dataModel.freight doubleValue]];
    self.shellCoin.text = [NSString stringWithFormat:@"%.2f",[_dataModel.expectAmount doubleValue]];
    self.buyCard.text = [NSString stringWithFormat:@"¥%.2f",[_dataModel.consumeAmount doubleValue]];
    self.actualMoney.text =[NSString stringWithFormat:@"¥%.2f", [_dataModel.goodsPrice doubleValue] ];;
    self.totalMoney.text = [NSString stringWithFormat:@"¥%.2f", [_dataModel.goodsPrice doubleValue] + [_dataModel.freight doubleValue] - [_dataModel.consumeAmount doubleValue] - [_dataModel.expectAmount doubleValue]];
    if ([self.dataModel.state isEqualToString:@"4"]) {
        [self.applyAfterSalesBtn setTitle:@"售后中" forState:UIControlStateNormal];
    } 
    if ([self.dataModel.state isEqualToString:@"3"]) {
        [self.applyAfterSalesBtn setTitle:@"删除订单" forState:UIControlStateNormal];
    }
}



- (void)setOrderType:(Myorder_type)orderType
{
    _orderType = orderType;
    switch (_orderType) {
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
