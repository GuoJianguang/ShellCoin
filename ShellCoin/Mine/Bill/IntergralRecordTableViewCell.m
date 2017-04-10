//
//  IntergralRecordTableViewCell.m
//  ShellCoin
//
//  Created by Guo on 2017/3/23.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "IntergralRecordTableViewCell.h"

@implementation FanxianModel

+ (id)modelWithDic:(NSDictionary *)dic
{
    FanxianModel *model = [[FanxianModel alloc]init];
    model.fanxianId = NullToSpace(dic[@"id"]);
    model.tranTime = NullToSpace(dic[@"tranTime"]);
    model.amount = NullToNumber(dic[@"amount"]);
    model.descript = NullToSpace(dic[@"description"]);
    model.consumeBalance = NullToNumber(dic[@"consumeBalance"]);
    return model;
}

@end
@implementation IntergralRecordTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.timeLabel.textColor = MacoDetailColor;
    self.moneyLabel.textColor = MacoColor;
    self.statusLabel.textColor = MacoColor;
    
    self.timeLabel.adjustsFontSizeToFitWidth = self.statusLabel.adjustsFontSizeToFitWidth = self.moneyLabel.adjustsFontSizeToFitWidth = YES;
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

- (void)setDataModel:(FanxianModel *)dataModel
{
    _dataModel = dataModel;
    self.timeLabel.text =_dataModel.tranTime;
    self.statusLabel.text = [NSString stringWithFormat:@"+¥%.2f",[_dataModel.amount doubleValue]];
    self.moneyLabel.text = [NSString stringWithFormat:@"+购物券%.2f",[_dataModel.consumeBalance doubleValue]];
}


@end
