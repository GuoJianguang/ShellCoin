//
//  OrderTableViewCell.m
//  ShellCoin
//
//  Created by mac on 2017/6/13.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "OrderTableViewCell.h"
#import "LogisticsViewController.h"
#import "BuyRecodTableViewCell.h"
#import "OrderModel.h"
#import "MallSureOrderViewController.h"
#import "AfterSalesDetailViewController.h"

@implementation OrderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.statusBtn.titleLabel.adjustsFontSizeToFitWidth = self.goodsNumber.adjustsFontSizeToFitWidth = self.goodsDetail.adjustsFontSizeToFitWidth = YES;
    self.goodsName.textColor = self.goodsNumber.textColor =MacoTitleColor;
    self.goodsDetail.textColor = MacoDetailColor;
    [self.acitonBtn setTitleColor:MacoColor forState:UIControlStateNormal];
    
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - 取消订单／查看物流
- (IBAction)statusBtn:(UIButton *)sender {
    switch (self.orderType) {
        case Myorder_type_waitPay:
        {
            UIAlertController *alertcontroller = [UIAlertController alertControllerWithTitle:@"重要提示" message:@"您是否确认要取消该订单" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"点错了" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            }];
            UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                //取消订单
                NSDictionary *parms = @{@"orderId":self.dataModel.orderId,
                                        @"token":[ShellCoinUserInfo shareUserInfos].token};
                [HttpClient POST:@"shop/order/cancel" parameters:parms success:^(NSURLSessionDataTask *operation, id jsonObject) {
                    if (IsRequestTrue) {
                        [[JAlertViewHelper shareAlterHelper]showTint:@"取消成功" duration:2.];
                        [[NSNotificationCenter defaultCenter]postNotificationName:@"cancelOrder" object:nil];
                    }
                    
                } failure:^(NSURLSessionDataTask *operation, NSError *error) {
                    [[JAlertViewHelper shareAlterHelper]showTint:@"取消失败，请重试" duration:2.];

                }];
                
            }];
            [alertcontroller addAction:cancelAction];
            [alertcontroller addAction:otherAction];
            [self.viewController presentViewController:alertcontroller animated:YES completion:NULL];
 
        }
            break;
            case Myorder_type_waitReceiveGoods://查看物流
        {
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
            break;
            case Myorder_type_compelte:
        {
    
        }
            break;
        default:
            break;
    }

    
}

#pragma mark - 去支付／提醒发货／确认收货／查看详情

- (IBAction)acitonBtn:(UIButton *)sender {
    
    switch (self.orderType) {
        case Myorder_type_waitPay:
        {
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic setObject:_dataModel.goodsId forKey:@"goodsId"];
            [dic setObject:_dataModel.priceId forKey:@"priceId"];
            [dic setObject:_dataModel.quantity forKey:@"quantity"];
            NSDictionary *orderDic = @{@"data":@{@"orderId":_dataModel.orderId,
                                       @"type":@"1"}};
            MallSureOrderViewController *sureVC = [[MallSureOrderViewController alloc]init];
            sureVC.orderArry = [NSMutableArray arrayWithArray:@[dic]];
            sureVC.waiPayOrderDic = orderDic;
            sureVC.isFormWaitPayOrder = YES;
            [self.viewController.navigationController pushViewController:sureVC animated:YES];
        }
            break;
        case Myorder_type_waitSendGoods:
        {
            [SVProgressHUD showSuccessWithStatus:@"提醒发货成功"];
            
        }
            break;
        case Myorder_type_waitReceiveGoods:
        {
            if ([self.dataModel.state isEqualToString:@"4"]) {
                //确认收货
                UIAlertController *alertcontroller = [UIAlertController alertControllerWithTitle:@"重要提示" message:@"该订单正在申请售后中，如果确认收货的话，将默认为您取消该订单的售后申请。是否继续？" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"点错了" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                }];
                UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"sureReceiving" object:nil];
                    
                }];
                [alertcontroller addAction:cancelAction];
                [alertcontroller addAction:otherAction];
                [self.viewController presentViewController:alertcontroller animated:YES completion:NULL];
                
                return;
                
                
            }
            

            [[NSNotificationCenter defaultCenter]postNotificationName:@"sureReceiving" object:@{@"orderId":self.dataModel.orderId}];
            
        }
            break;
        case Myorder_type_compelte:
        {
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
                    }
    
                } failure:^(NSURLSessionDataTask *operation, NSError *error) {
                    [[JAlertViewHelper shareAlterHelper]showTint:@"取消失败，请重试" duration:2.];
    
                }];
    
            }];
            [alertcontroller addAction:cancelAction];
            [alertcontroller addAction:otherAction];
            [self.viewController presentViewController:alertcontroller animated:YES completion:NULL];

        }
            break;
        default:
            break;
    }

    
    
}


- (void)setOrderType:(Myorder_type)orderType
{
    _orderType = orderType;
    switch (orderType) {
        case Myorder_type_waitPay:
        {
            self.sortImgaeView.image = [UIImage imageNamed:@"pic_state_yellow2"];
            [self.statusBtn setTitle:@"取消订单" forState:UIControlStateNormal];
            [self.statusBtn setBackgroundImage:[UIImage imageNamed:@"bg_status_label_yellow"] forState:UIControlStateNormal];
            [self.acitonBtn setTitle:@"去支付" forState:UIControlStateNormal];
        }
            break;
        case Myorder_type_waitSendGoods:
        {
            self.sortImgaeView.image = [UIImage imageNamed:@"pic_state_blue2"];
            [self.statusBtn setTitle:@"待发货" forState:UIControlStateNormal];
            [self.statusBtn setBackgroundImage:[UIImage imageNamed:@"bg_status_label_blue"] forState:UIControlStateNormal];
            [self.acitonBtn setTitle:@"提醒发货" forState:UIControlStateNormal];

        }
            break;
        case Myorder_type_waitReceiveGoods:
        {
            self.sortImgaeView.image = [UIImage imageNamed:@"pic_state_blue2"];
            [self.statusBtn setTitle:@"查看物流" forState:UIControlStateNormal];
            [self.statusBtn setBackgroundImage:[UIImage imageNamed:@"bg_status_label_blue"] forState:UIControlStateNormal];
            [self.acitonBtn setTitle:@"确认收货" forState:UIControlStateNormal];

        }
            break;
        case Myorder_type_compelte:
        {
            self.sortImgaeView.image = [UIImage imageNamed:@"pic_state_red3"];
            [self.statusBtn setTitle:@"已完成" forState:UIControlStateNormal];
            [self.statusBtn setBackgroundImage:[UIImage imageNamed:@"bg_status_label_red"] forState:UIControlStateNormal];
            [self.acitonBtn setTitle:@"查看详情" forState:UIControlStateNormal];

        }
            break;
        default:
            break;
    }
}

- (void)setDataModel:(OrderModel *)dataModel
{
    _dataModel = dataModel;
    self.storeName.text = _dataModel.mchName;
    self.goodsName.text = _dataModel.goodsName;
    [self.goodsImage sd_setImageWithURL:[NSURL URLWithString:_dataModel.goodsImage] placeholderImage:LoadingErrorDefaultImageSquare];
    self.goodsDetail.text = _dataModel.goodsSpecDesc;
    self.goodsNumber.text = [NSString stringWithFormat:@"*%@",_dataModel.quantity];
    
    switch ([self.dataModel.state integerValue]) {
        case 5:
        {
            [self.statusBtn setTitle:@"已退款" forState:UIControlStateNormal];
            [self.statusBtn setBackgroundImage:[UIImage imageNamed:@"bg_status_label_green"] forState:UIControlStateNormal];
//            [self.acitonBtn setTitle:@"查看详情" forState:UIControlStateNormal];
            [self.acitonBtn setTitle:@"删除订单" forState:UIControlStateNormal];
            self.sortImgaeView.image = [UIImage imageNamed:@"pic_state_green"];
        }
            break;
        case 3:
        {
            [self.statusBtn setTitle:@"已完成" forState:UIControlStateNormal];
            [self.statusBtn setBackgroundImage:[UIImage imageNamed:@"bg_status_label_red"] forState:UIControlStateNormal];
            [self.acitonBtn setTitle:@"删除订单" forState:UIControlStateNormal];
            self.sortImgaeView.image = [UIImage imageNamed:@"bg_status_label_red"];
        }
            break;
        default:
            break;
    }
}



//switch ([self.dataModel.state integerValue]) {
//    case 5://已退款
//    {
//        AfterSalesDetailViewController *afterDetailVC =[[AfterSalesDetailViewController alloc]init];
//        afterDetailVC.dataModel = self.dataModel;
//        [self.viewController.navigationController pushViewController:afterDetailVC animated:YES];
//    }
//        break;
//    case 3://已完成
//    {
//        UIAlertController *alertcontroller = [UIAlertController alertControllerWithTitle:@"重要提示" message:@"您是否确认要删除该订单" preferredStyle:UIAlertControllerStyleAlert];
//        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"点错了" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
//        }];
//        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//            //取消订单
//            NSDictionary *parms = @{@"orderId":self.dataModel.orderId,
//                                    @"token":[ShellCoinUserInfo shareUserInfos].token};
//            [HttpClient POST:@"shop/order/delete" parameters:parms success:^(NSURLSessionDataTask *operation, id jsonObject) {
//                if (IsRequestTrue) {
//                    [[JAlertViewHelper shareAlterHelper]showTint:@"删除订单成功" duration:2.];
//                    [[NSNotificationCenter defaultCenter]postNotificationName:@"cancelOrder" object:nil];
//                }
//                
//            } failure:^(NSURLSessionDataTask *operation, NSError *error) {
//                [[JAlertViewHelper shareAlterHelper]showTint:@"取消失败，请重试" duration:2.];
//                
//            }];
//            
//        }];
//        [alertcontroller addAction:cancelAction];
//        [alertcontroller addAction:otherAction];
//        [self.viewController presentViewController:alertcontroller animated:YES completion:NULL];
//        
//    }
//        break;
//        
//    default:
//        break;
//}


@end
