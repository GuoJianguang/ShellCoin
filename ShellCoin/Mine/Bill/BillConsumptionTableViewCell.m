//
//  BillConsumptionTableViewCell.m
//  ShellCoin
//
//  Created by Guo on 2017/3/10.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "BillConsumptionTableViewCell.h"
#import "BillAmountDataModel.h"
#import "BillDataModel.h"

@implementation BillConsumptionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.timeLabel.textColor = MacoDetailColor;
    self.moneyLabel.textColor = MacoColor;
    self.markLabel.textColor = MacoTitleColor;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)setXiaofeijiluModel:(BillDataModel *)xiaofeijiluModel
{
    _xiaofeijiluModel = xiaofeijiluModel;
    self.markLabel.text = _xiaofeijiluModel.mchName;
    self.timeLabel.text = _xiaofeijiluModel.tranTime;
    self.buyCardLabel.text = @"";
    NSString *statusStr = [NSString string];
    
    switch ([_xiaofeijiluModel.state integerValue]) {
        case 1:
        {
            statusStr = @"支付成功";
            self.markImageView.image = [UIImage imageNamed:@"pic_state_red"];
            self.statusLabel.textColor = self.moneyLabel.textColor = self.buyCardLabel.textColor = MacoColor;
        }
            break;
        case 2:
        {
            statusStr = @"支付成功";
            self.markImageView.image = [UIImage imageNamed:@"pic_state_red"];
            self.statusLabel.textColor = self.moneyLabel.textColor = self.buyCardLabel.textColor = MacoColor;
        }
            break;
        case 3:
        {
            self.markImageView.image = [UIImage imageNamed:@"pic_state_blue"];
            self.statusLabel.textColor = self.moneyLabel.textColor = self.buyCardLabel.textColor = [UIColor colorFromHexString:@"#2586d5"];
            statusStr = @"冻结中";
        }
            break;
        default:
            break;
    }
    
    switch ([_xiaofeijiluModel.channel integerValue]) {
        case 1://线下现金支付
            self.sortImageview.image = [UIImage imageNamed:@"icon_cash_payment_nor"];
            break;
        case 3://`pay_type`     '0余额支付 1微信支付
        {
            
            if ([_xiaofeijiluModel.payType isEqualToString:@"0"]) {
                self.buyCardLabel.text = [NSString stringWithFormat:@"(含购物券%@)",_xiaofeijiluModel.consumeAmount];
                self.sortImageview.image = [UIImage imageNamed:@"icon_balance_payment_nor"];
            }else{
                self.sortImageview.image = [UIImage imageNamed:@"icon_wechat_payment_nor"];
            }
        }
            break;
        default:
            break;
    }
    self.moneyLabel.text = [NSString stringWithFormat:@"¥%@",_xiaofeijiluModel.totalAmount];
    self.statusLabel.text = statusStr;
}

@end
