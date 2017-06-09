//
//  BillTableViewCell.m
//  ShellCoin
//
//  Created by Guo on 2017/3/10.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "BuyRecodTableViewCell.h"
#import "LogisticsViewController.h"

@implementation BuyRecodeModel

+ (id)modelWithDic:(NSDictionary *)dic
{
    BuyRecodeModel *model = [[BuyRecodeModel alloc]init];
    model.time  = NullToSpace(dic[@"time"]);
    model.amount = NullToNumber(dic[@"tranAmount"]);
    model.count = NullToNumber(dic[@"buyNum"]);
    model.goodsName = NullToNumber(dic[@"goodsName"]);
    model.buyId = NullToNumber(dic[@"id"]);
    model.deliverFlag = NullToNumber(dic[@"deliverFlag"]);
    model.logisticsCompany = NullToSpace(dic[@"logisticsCompany"]);
    model.logisticsNumber = NullToSpace(dic[@"logisticsNumber"]);
    model.logisticsCompanyCode = NullToSpace(dic[@"logisticsCompanyCode"]);
    return model;
}

@end

@implementation BuyRecodTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.timeLabel.textColor = MacoDetailColor;
    self.moneyLabel.adjustsFontSizeToFitWidth = YES;
    self.markLabel.textColor = MacoTitleColor;
    [self.checkLogisticBtn setTitleColor:MacoColor forState:UIControlStateNormal];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}


- (void)setDataModel:(BuyRecodeModel *)dataModel
{
    _dataModel = dataModel;
    self.moneyLabel.text = [NSString stringWithFormat:@"¥%.2f",[_dataModel.amount doubleValue]];
    self.timeLabel.text = _dataModel.time;
    self.markLabel.text = [NSString stringWithFormat:@"%@*%@",_dataModel.goodsName,_dataModel.count];
    
    switch ([_dataModel.deliverFlag integerValue]) {
        case 0:
        {
            [self.checkLogisticBtn setTitle:@"未发货" forState:UIControlStateNormal];
            self.enterWidth.constant = TWitdh*(15/750.);
            self.checkLogisticBtn.enabled= NO;
            self.iconEnter.hidden = YES;
            [self.checkLogisticBtn setTitleColor:MacoDetailColor forState:UIControlStateNormal];

        }
            break;
        case 1:
        {
            [self.checkLogisticBtn setTitle:@"查看物流" forState:UIControlStateNormal];
            self.enterWidth.constant = TWitdh*(60/750.);
            self.checkLogisticBtn.enabled= YES;
        }
            break;
        default:
            break;
    }
    
    
}

- (IBAction)checkLogisticBtn:(UIButton *)sender {
    LogisticsViewController *logisticsVC = [[LogisticsViewController alloc]init];
    logisticsVC.dataModel = self.dataModel;
    [self.viewController.navigationController pushViewController:logisticsVC animated:YES];
    
}
@end
