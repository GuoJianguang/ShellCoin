//
//  IntergralRecordTableViewCell.m
//  ShellCoin
//
//  Created by Guo on 2017/3/23.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "IntergralRecordTableViewCell.h"

@implementation IntergralRecordTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setIntegaralModel:(BillIntegaralModel *)integaralModel
{
    _integaralModel = integaralModel;
    self.markLabel.text = _integaralModel.mchName;
    self.timeLabel.text = _integaralModel.time;
    switch ([_integaralModel.tranType integerValue]) {
        case 1:
        {
            self.statusLabel.text = [NSString stringWithFormat:@"消费¥%@",_integaralModel.tranAmount];
            self.moneyLabel.text = [NSString stringWithFormat:@"+%@积分",_integaralModel.accumulateAmount];
        }
            break;
        case 2:
        {
            self.statusLabel.text = [NSString stringWithFormat:@"抵换¥%@",_integaralModel.tranAmount];
            self.moneyLabel.text = [NSString stringWithFormat:@"-%@积分",_integaralModel.accumulateAmount];

        }
            break;
        case 3:
        {
            self.statusLabel.text = [NSString stringWithFormat:@"积分支付¥%@",_integaralModel.tranAmount];
            self.moneyLabel.text = [NSString stringWithFormat:@"-%@积分",_integaralModel.accumulateAmount];
        }
            break;
        default:
            break;
    }
    
    
    
}

- (void)setShellCoinModel:(IntegralShellCoinModel *)shellCoinModel
{
    _shellCoinModel = shellCoinModel;
    self.markLabel.text = _shellCoinModel.mchName;
    self.timeLabel.text = _shellCoinModel.time;
    switch ([_shellCoinModel.tranType integerValue]) {
        case 1:
        {
            self.statusLabel.text = [NSString stringWithFormat:@"消费¥%@",_shellCoinModel.tranAmount];
            self.moneyLabel.text = [NSString stringWithFormat:@"+%@积分",_shellCoinModel.shellsAmount];
        }
            break;
        case 2:
        {
            self.statusLabel.text = [NSString stringWithFormat:@"抵换¥%@",_shellCoinModel.tranAmount];
            self.moneyLabel.text = [NSString stringWithFormat:@"-%@积分",_shellCoinModel.shellsAmount];
            
        }
            break;
        case 3:
        {
            self.statusLabel.text = [NSString stringWithFormat:@"积分支付¥%@",_shellCoinModel.tranAmount];
            self.moneyLabel.text = [NSString stringWithFormat:@"-%@积分",_shellCoinModel.shellsAmount];
        }
            break;
        default:
            break;
    }

}
@end
