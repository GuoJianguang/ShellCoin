//
//  BillConsumptionTableViewCell.m
//  ShellCoin
//
//  Created by Guo on 2017/3/10.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "BillConsumptionTableViewCell.h"
#import "BillAmountDataModel.h"

@implementation BillConsumptionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)setXiaofeijiluModel:(BillAmountDataModel *)xiaofeijiluModel
{
    _xiaofeijiluModel = xiaofeijiluModel;
    self.markLabel.text = _xiaofeijiluModel.mchName;
    self.timeLabel.text = _xiaofeijiluModel.tranTime;
    NSString *statusStr = [NSString string];
    
    switch ([_xiaofeijiluModel.state integerValue]) {
        case 0:
            statusStr = @"未支付";
            break;
        case 1:
            statusStr = @"支付成功";
            break;
        case 2:
            statusStr = @"已返利";
            break;
        case 3:
            statusStr = @"冻结中";
            break;
        case 4:
            statusStr = @"已取消";
            break;
            
        default:
            break;
    }
    self.statusLabel.text = statusStr;
    self.moneyLabel.text = [NSString stringWithFormat:@"¥%@",_xiaofeijiluModel.totalAmount];
}

@end
